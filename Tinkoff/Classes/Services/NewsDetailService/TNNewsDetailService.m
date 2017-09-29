//
//  TNNewsDetailService.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetailService.h"
#import "TNNewsDeyailsPayload+CoreDataClass.h"
#import "TNCoreDataService.h"
#import "TNNewsDetailsMapping.h"

NSString *TNNewsDetailsPayloadEntity = @"TNNewsDeyailsPayload";
NSString *TNNewsDetailsEntity = @"TNNewsDetails";

@interface TNNewsDetailService ()
@property (strong, nonatomic) TNCoreDataService *coreDataService;
@end

@implementation TNNewsDetailService

- (void)obtainNewsListWithNewsId:(NSString *)newsId WithCompletionBlock:(TNNewsDetailsServiceCompletionBlock)completionBlock {
    typeof(self) __weak weakSelf = self;
    __block NSString *content;
    __block TNNewsDeyailsPayload *newsDetailsPayload = [TNNewsDeyailsPayload new];
    // Fetch data from Local DB
    [self fetchNewsDetailsfromLocalDbWithId:newsId
                        WithCompletionBlock:^(id result) {
        if (result != nil) {
            newsDetailsPayload = result;
            content = newsDetailsPayload.content;
            completionBlock(content);
        // If no results: Request to api for downloading data
        } else {
            [weakSelf requestToApiWithNewsId:newsId WithCompletionBlock:^(id result, NSError *error) {
                // If no Error: Mapping Data and Save into loacal DB
                if (!error) {
                    NSError *dictError = nil;
                    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options: NSJSONReadingMutableContainers error: &dictError];
                 
                    // Mapping response data
                    TNNewsDetailsMapping *newsDetailsMapping = [TNNewsDetailsMapping new];
                    [newsDetailsMapping newsDetailsMapping:responseDictionary WithCompletionBlock:^(BOOL success) {
                        //Save in context
                        [weakSelf.coreDataService saveContext];
                        // Fetch data from loacl DB
                        [weakSelf fetchNewsDetailsfromLocalDbWithId:newsId
                                                WithCompletionBlock:^(id result) {
                            if (result == nil) {
                                // TODO: - Need to refactor
                                content = @"Ошибка :(";
                                completionBlock(content);
                            } else {
                                newsDetailsPayload = result;
                                content = newsDetailsPayload.content;
                                completionBlock (content);
                            }
                        }];
                    }];
                } else {
                    // TODO: - Need to refactor
                    content = @"Ошибка :(";
                    completionBlock(content);
                }
            }];
        }
    }];
}

#pragma mark - Private

- (void)fetchNewsDetailsfromLocalDbWithId:(NSString *)newsId
                      WithCompletionBlock:(TNNewsDetailsServiceCompletionBlock)completionBlock {
    NSArray<TNNewsDeyailsPayload *> *newsDetailsPayload;
    
    NSManagedObjectContext *context = self.coreDataService.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:TNNewsDetailsPayloadEntity  inManagedObjectContext: context];
    [fetchRequest setEntity:entityDescription];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"title.identifier like %@",newsId];
    
    NSError * error = nil;
    newsDetailsPayload = [context executeFetchRequest:fetchRequest error:&error];
    if (newsDetailsPayload.count) {
        completionBlock(newsDetailsPayload[0]);
    } else {
        completionBlock(nil);
    }
}

#pragma mark - Private

- (void)requestToApiWithNewsId:(NSString *)newsId WithCompletionBlock:(TNNewsDetailsServiceCompletionResponseBlock)completionBlock {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.tinkoff.ru/v1/news_content?id=%@",newsId];
    [request setURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 20.0;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(nil, error);
            NSLog(@"error - %@", error.localizedDescription);
        } else {
            completionBlock(data, nil);
        }
    }] resume];
}

#pragma mark - Custom accesors

- (TNCoreDataService *)coreDataService {
    if (!_coreDataService) {
        _coreDataService = [TNCoreDataService sharedInstance];
    }
    return _coreDataService;
}

@end
