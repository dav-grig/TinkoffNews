//
//  TNNewsDetailsMapping.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetailsMapping.h"
#import "TNNewsDeyailsPayload+CoreDataClass.h"
#import "TNNewsDetails+CoreDataClass.h"
#import "TNNewsListPayload+CoreDataClass.h"

@implementation TNNewsDetailsMapping

- (void)newsDetailsMapping:(NSDictionary *)news WithCompletionBlock:(TNNewsDetailServiceSuccessBlock)completionBlock {
    TNNewsDetails* newsDetails = [[TNNewsDetails alloc] initWithContext];
    
    if ([[news valueForKey:@"resultCode"] isKindOfClass:[NSString class]]) {
        newsDetails.resultCode = [news valueForKey:@"resultCode"];
        
        if ([newsDetails.resultCode isEqualToString:@"OK"]) {
            if ([[news valueForKey:@"trackingId"] isKindOfClass:[NSString class]]) {
                newsDetails.trackingId = [news valueForKey:@"trackingId"];
            }
            if ([[news valueForKey:@"payload"] isKindOfClass:[NSDictionary class]]) {
                TNNewsDeyailsPayload *newsDetailsPayload = [[TNNewsDeyailsPayload alloc] initWithContext];
                
                if ([[[news valueForKey:@"payload"] valueForKey:@"title"] isKindOfClass:[NSDictionary class]]) {
                    TNNewsListPayload *newsListPayload = [[TNNewsListPayload alloc] initWithContext];
                    
                    NSDictionary *payloadDict = [[news valueForKey:@"payload"] valueForKey:@"title"];
                    newsListPayload.identifier = [payloadDict valueForKey:@"id"];
                    newsListPayload.name = [payloadDict valueForKey:@"text"];
                    
                    if ([[payloadDict valueForKey:@"bankInfoTypeId"] isKindOfClass:[NSNumber class]]) {
                        NSNumber *bankInfoTypeId = [payloadDict valueForKey:@"bankInfoTypeId"];
                        newsListPayload.bankInfoTypeId = bankInfoTypeId.longLongValue;
                    }
                    
                    if ([[payloadDict valueForKey:@"publicationDate"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *publicDateDictionary = [payloadDict valueForKey:@"publicationDate"];
                        
                        if ([[publicDateDictionary valueForKey:@"milliseconds"] isKindOfClass:[NSNumber class]]) {
                            NSNumber *milliseconds = [publicDateDictionary valueForKey:@"milliseconds"];
                            newsListPayload.publicationDate = milliseconds.longLongValue;
                        }
                    }
                newsDetailsPayload.title = newsListPayload;
                }
                if ([[[news valueForKey:@"payload"] valueForKey:@"creationDate"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *payloadCreateDateDictionary = [[news valueForKey:@"payload"] valueForKey:@"creationDate"];
                    
                    if ([[payloadCreateDateDictionary valueForKey:@"milliseconds"] isKindOfClass:[NSNumber class]]) {
                        NSNumber *milliseconds = [payloadCreateDateDictionary valueForKey:@"milliseconds"];
                        newsDetailsPayload.creationDate = milliseconds.longLongValue;
                    }
                }
                if ([[[news valueForKey:@"payload"] valueForKey:@"lastModificationDate"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *payloadCreateDateDictionary = [[news valueForKey:@"payload"] valueForKey:@"lastModificationDate"];
                    
                    if ([[payloadCreateDateDictionary valueForKey:@"milliseconds"] isKindOfClass:[NSNumber class]]) {
                        NSNumber *milliseconds = [payloadCreateDateDictionary valueForKey:@"milliseconds"];
                        newsDetailsPayload.lastModificationDate = milliseconds.longLongValue;
                    }
                }
                if ([[[news valueForKey:@"payload"] valueForKey:@"content"] isKindOfClass:[NSString class]]) {
                    newsDetailsPayload.content = [[news valueForKey:@"payload"] valueForKey:@"content"];
                }
                if ([[[news valueForKey:@"payload"] valueForKey:@"bankInfoTypeId"] isKindOfClass:[NSNumber class]]) {
                    NSNumber *bankInfoTypeIdForPayload = [[news valueForKey:@"payload"] valueForKey:@"bankInfoTypeId"];
                    newsDetailsPayload.bankInfoTypeId = bankInfoTypeIdForPayload.longLongValue;
                }
                if ([[[news valueForKey:@"payload"] valueForKey:@"typeId"] isKindOfClass:[NSString class]]) {
                    newsDetailsPayload.typeId = [[news valueForKey:@"payload"] valueForKey:@"typeId"];
                }
            newsDetails.payload = newsDetailsPayload;
            }
        }
    }
    completionBlock(YES);
}


@end
