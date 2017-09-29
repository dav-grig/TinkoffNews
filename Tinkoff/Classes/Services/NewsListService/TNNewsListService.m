//
//  TNNewsListService.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListService.h"
#import "TNNewsListMapping.h"
#import "TNCoreDataService.h"


#import "TNNewsList+CoreDataClass.h"
#import "TNNewsListPayload+CoreDataClass.h"

NSString *TNNewsListEntity = @"TNNewsList";
NSString *TNNewsListPayloadEntity = @"TNNewsListPayload";

@interface TNNewsListService()

@property (strong, nonatomic) TNCoreDataService *coreDataService;

@end

@implementation TNNewsListService


- (void)obtainNewsListWithCompletionBlock:(TNServiceCompletionBlock)completionBlock {
    typeof(self) __weak weakSelf = self;
    // Request to api for the downloading data
    [self requestToApiWithCompletionBlock:^(id result, NSError *error) {
        __block NSArray<TNNewsListPayload *> *listPayloads = [NSArray new];
        if (!error) {
            NSError *dictError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options: NSJSONReadingMutableContainers error: &dictError];
            
            // Delete all entities
            [weakSelf.coreDataService deleteAllEntities];
            // Mapping response data
            TNNewsListMapping *newsListMap = [TNNewsListMapping new];
            [newsListMap newsListMapping:responseDictionary WithCompletionBlock:^(BOOL success) {
                //Save in context
                [weakSelf.coreDataService saveContext];
                // Fetch data from local DB
                [weakSelf fetchPayloadsListfromLocalDbWithOffset:0 WithCompletionBlock:^(id result) {
                    listPayloads = result;
                    completionBlock (listPayloads);

                }];
            }];

        } else {
            // TODO: - Need to refactor
            completionBlock (listPayloads);
        }
    }];
    
}

- (void)fetchPayloadsListfromLocalDbWithOffset:(NSInteger)offset WithCompletionBlock:(TNServiceCompletionBlock)completionBlock {
   NSArray<TNNewsListPayload *> *listPayloads = [NSArray new];
    
    NSManagedObjectContext *context = self.coreDataService.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:TNNewsListPayloadEntity  inManagedObjectContext: context];
    [fetchRequest setEntity:entityDescription];
    fetchRequest.fetchOffset = offset;
    fetchRequest.fetchLimit = 50;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"publicationDate" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSError * error = nil;
    listPayloads = [context executeFetchRequest:fetchRequest error:&error];
    
    completionBlock(listPayloads);
}

#pragma mark - Private

- (void)requestToApiWithCompletionBlock:(TNServiceCompletionResponseBlock)completionBlock {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://api.tinkoff.ru/v1/news"]];
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
