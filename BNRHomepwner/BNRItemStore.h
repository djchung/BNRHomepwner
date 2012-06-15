//
//  BNRItemStore.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//fwd declaration is speed up compile time. Used when we just need to be able to use the BNRItem symbol without having to import BNRItem.h with lots of the other stuff. 
@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
    NSMutableArray *allAssetTypes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
    NSArray *itemsUnder50;
    NSArray *itemsOver50;
}

+ (BNRItemStore *)sharedStore;

- (BOOL)saveChanges;
- (NSArray *)allItems;
- (NSArray *)itemsUnder50;
- (NSArray *)itemsOver50;
- (BNRItem *)createItem;
- (void) removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(int)from 
                toIndex:(int)to;
- (NSString *)itemArchivePath;
- (void)loadAllItems;
- (NSArray *)allAssetTypes;
- (void)addNewAssetType:(NSString *)newAssetType;

@end
