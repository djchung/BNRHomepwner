//
//  AddAssetType.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddAssetType.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@interface AddAssetType ()

@end

@implementation AddAssetType

@synthesize item;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.leftBarButtonItem = cancel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    assetTypeText = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cancel
{
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}
- (IBAction)saveNewAssetType:(id)sender {
    NSString *newAssetType = assetTypeText.text;
    
    [[BNRItemStore sharedStore]addNewAssetType:newAssetType];
    
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
}
@end
