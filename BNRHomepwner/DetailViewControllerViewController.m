//
//  DetailViewControllerViewController.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewControllerViewController.h"
#import "BNRItem.h"

@interface DetailViewControllerViewController ()

@end

@implementation DetailViewControllerViewController
@synthesize item;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewDidUnload {
    nameField = nil;
    serialNumberField = nil;
    valueField = nil;
    dateLabel = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    nameField.text = item.itemName;
    serialNumberField.text = item.serialNumber;
    valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
    item.itemName = nameField.text;
    item.serialNumber = serialNumberField.text;
    item.valueInDollars = [valueField.text intValue];
    
    
}

- (void)setItem:(BNRItem *)i
{
    item = i;
    self.navigationItem.title = item.itemName;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)changeDateButton:(id)sender {
    ChangeDateViewController *cdvc = [[ChangeDateViewController alloc]init];
    cdvc.item = self.item;
    [self.navigationController pushViewController:cdvc animated:YES];
}
@end
