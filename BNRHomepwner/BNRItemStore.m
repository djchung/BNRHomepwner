//
//  BNRItemStore.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

- (id)init
{
    self = [super init];
    if (self) {
        allItems = [[NSMutableArray alloc]init];
        itemsUnder50 = [[NSArray alloc]init];
        itemsOver50 = [[NSArray alloc]init];
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;

}

- (NSArray *)itemsUnder50
{
    NSPredicate *under50 = [NSPredicate predicateWithFormat:@"valueInDollars <= 50"];
    itemsUnder50 = [[[BNRItemStore sharedStore]allItems]filteredArrayUsingPredicate:under50];
    return itemsUnder50;
}

- (NSArray *)itemsOver50
{
    NSPredicate *over50 = [NSPredicate predicateWithFormat:@"valueInDollars > 50"];
    itemsOver50 = [[[BNRItemStore sharedStore]allItems]filteredArrayUsingPredicate:over50];
    return itemsOver50;
}
- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    
    [allItems addObject:p];
    
    return p;
}

- (void)removeItem:(BNRItem *)p
{
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    BNRItem *p = [allItems objectAtIndex:from];
    [allItems removeObjectAtIndex:from];
    [allItems insertObject:p atIndex:to];
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
@end
