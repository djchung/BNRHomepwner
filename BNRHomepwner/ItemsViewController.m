//
//  ItemsViewController.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@implementation ItemsViewController


- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore]createItem];
        }
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 2;  for Bronze solution
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /***Bronze solution
    if (section == 0) {
        return [[[BNRItemStore sharedStore]itemsOver50] count];
    } else {
        return [[[BNRItemStore sharedStore]itemsUnder50]count];
    }
    ***/
    return [[[BNRItemStore sharedStore]allItems]count] + 1; //for Silver solution
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    /***Bronze solution
    if (indexPath.section == 0) {
        BNRItem *bnrItem = [[[BNRItemStore sharedStore]itemsOver50]objectAtIndex:indexPath.row];
        cell.textLabel.text = bnrItem.description;
        return cell;
    }
    else {
        BNRItem *p = [[[BNRItemStore sharedStore]itemsUnder50]objectAtIndex:indexPath.row];
        cell.textLabel.text = p.description;
        
        return cell;
    }
    ***/
    
    while (indexPath.row < [[[BNRItemStore sharedStore]allItems]count]) {
        BNRItem *p = [[[BNRItemStore sharedStore]allItems]objectAtIndex:indexPath.row];
        cell.textLabel.text = p.description;
        return cell;
    }
    
    cell.textLabel.text = @"No more items";
    
    return cell;
}

@end