//
//  TNCoreDataService.h
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^MTCoreDataServiceSuccessBlockObject)(id result);
typedef void (^MTCoreDataServiceSuccessMappingBlock)(BOOL success);

@interface TNCoreDataService : NSObject

+ (instancetype)sharedInstance;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
- (void)deleteEntity:(NSString *)entityName;
- (void)deleteAllEntities;

///**
// * Удалить содержимое сущности
// * @param entity - Класс сущности
// */
//- (void)deleteEntity:(id)entity;
//
///**
// * Маппинг сущности
// * @param entity - Класс сущности
// */
//- (void)mappingEntity:(id)entity
//   withResponseObject:(id)responseObject
//              success:(MTCoreDataServiceSuccessMappingBlock)success;



@end
