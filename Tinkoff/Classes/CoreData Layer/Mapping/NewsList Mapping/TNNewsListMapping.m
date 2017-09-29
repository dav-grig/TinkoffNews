//
//  TNNewsListMapping.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListMapping.h"
#import "TNNewsList+CoreDataClass.h"
#import "TNNewsListPayload+CoreDataClass.h"

@implementation TNNewsListMapping

- (void)newsListMapping:(NSDictionary *)news WithCompletionBlock:(TNServiceSuccessBlock)completionBlock {
    TNNewsList* newslist =  [[TNNewsList alloc] initWithContext];
    
    if ([[news valueForKey:@"resultCode"] isKindOfClass:[NSString class]]) {
        newslist.resultCode = [news valueForKey:@"resultCode"];
        
        if ([newslist.resultCode isEqualToString:@"OK"]) {
            if ([[news valueForKey:@"trackingId"] isKindOfClass:[NSString class]]) {
                newslist.trackingId = [news valueForKey:@"trackingId"];
            }
            if ([[news valueForKey:@"payload"] isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *payloadObject in [news valueForKey:@"payload"]) {
                    TNNewsListPayload *newsPayload = [[TNNewsListPayload alloc] initWithContext];
                    
                    if ([[payloadObject valueForKey:@"id"] isKindOfClass:[NSString class]]) {
                        newsPayload.identifier = [payloadObject valueForKey:@"id"];
                    }
                    if ([[payloadObject valueForKey:@"name"] isKindOfClass:[NSString class]]) {
                        newsPayload.name = [payloadObject valueForKey:@"name"];
                    }
                    if ([[payloadObject valueForKey:@"text"] isKindOfClass:[NSString class]]) {
                        newsPayload.text = [payloadObject valueForKey:@"text"];
                    }
                    if ([[payloadObject valueForKey:@"bankInfoTypeId"] isKindOfClass:[NSNumber class]]) {
                        NSNumber *bankInfoTypeId = [payloadObject valueForKey:@"bankInfoTypeId"];
                        newsPayload.bankInfoTypeId = bankInfoTypeId.longLongValue;
                    }
                    if ([[payloadObject valueForKey:@"publicationDate"] isKindOfClass:[NSDictionary class]]) {
                        
                        NSDictionary *publicDateDictionary = [payloadObject valueForKey:@"publicationDate"];
                        if ([[publicDateDictionary valueForKey:@"milliseconds"] isKindOfClass:[NSNumber class]]) {
                            NSNumber *milliseconds = [publicDateDictionary valueForKey:@"milliseconds"];
                            newsPayload.publicationDate = milliseconds.longLongValue;;
                        }
                    }
                     [newslist addPayloadObject:newsPayload];
                }
            }
        }
    }
    completionBlock(YES);
}

@end
