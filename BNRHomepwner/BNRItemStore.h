//
//  BNRItemStore.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//fwd declaration is speed up compile time. Used when we just need to be able to use the BNRItem symbol without having to import BNRItem.h with lots of the other stuff. 
@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
    NSArray *itemsUnder50;
    NSArray *itemsOver50;
}
+ (BNRItemStore *)sharedStore;

- (NSArray *)allItems;
- (NSArray *)itemsUnder50;
- (NSArray *)itemsOver50;
- (BNRItem *)createItem;

@end
