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
        self.navigationItem.title = @"Homepwner";
        UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        self.navigationItem.rightBarButtonItem = add;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    /*** for Gold solution
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GoldenGateBridge.jpg"]];
     **/
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
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
//    return [[[BNRItemStore sharedStore]allItems]count];
    
}

/*** gold solution
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    while (indexPath.row < [[[BNRItemStore sharedStore]allItems]count]){
        return 66;
    }
    return 44;
    
}
 **/
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
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        return cell;
    }
    
    cell.textLabel.text = @"No more items";
    
    /*
    BNRItem *p = [[[BNRItemStore sharedStore]allItems]objectAtIndex:indexPath.row];
    
    cell.textLabel.text = p.description;
    */
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    BNRItem *item = [items objectAtIndex:indexPath.row];
    
    DetailViewControllerViewController *dvc = [[DetailViewControllerViewController alloc]init];
    dvc.item = item;
    [self.navigationController pushViewController:dvc animated:YES];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BNRItemStore *ps = [BNRItemStore sharedStore];
        NSArray *items = [ps allItems];
        BNRItem *p = [items objectAtIndex:indexPath.row];
        [ps removeItem:p];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [[[BNRItemStore sharedStore]allItems]count]) {
        return NO;
    }
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == [[[BNRItemStore sharedStore]allItems]count]) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}


- (IBAction)addNewItem:(id)sender
{
    BNRItem *item = [[BNRItemStore sharedStore]createItem];
    int lastRow = [[[BNRItemStore sharedStore] allItems]indexOfObject:item];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationTop];
}
@end
