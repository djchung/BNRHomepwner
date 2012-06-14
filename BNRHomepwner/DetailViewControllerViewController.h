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

@interface DetailViewControllerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
{
    
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *nameField;
    
    UIPopoverController *imagePickerPopover;
}

- (id)initForNewItem:(BOOL)isNew;
- (IBAction)backgroundTapped:(id)sender;
@property (strong, nonatomic) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);
- (IBAction)changeDateButton:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)clearImage:(id)sender;
@end
