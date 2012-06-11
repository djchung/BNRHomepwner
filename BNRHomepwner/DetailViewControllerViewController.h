//
//  DetailViewControllerViewController.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeDateViewController.h"

@class BNRItem;

@interface DetailViewControllerViewController : UIViewController
{
    
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *nameField;
}
- (IBAction)backgroundTapped:(id)sender;
@property (strong, nonatomic) BNRItem *item;
- (IBAction)changeDateButton:(id)sender;
@end
