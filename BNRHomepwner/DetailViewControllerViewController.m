//
//  DetailViewControllerViewController.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewControllerViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

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
    imageView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
//    data should be set in this method
    [super viewWillAppear:YES];
    nameField.text = item.itemName;
    serialNumberField.text = item.serialNumber;
    valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    NSString *imageKey = item.imageKey;
    if (imageKey) {
        UIImage *imageToDispay = [[BNRImageStore sharedStore]imageForKey:imageKey];
        imageView.image = imageToDispay;
    }else {
        imageView.image = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
    item.itemName = nameField.text;
    item.serialNumber = serialNumberField.text;
    item.valueInDollars = [valueField.text intValue];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = item.imageKey;
    if (oldKey) {
        [[BNRImageStore sharedStore]deleteImageForKey:oldKey];
    }
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *key = (__bridge NSString *)newUniqueIDString;
    item.imageKey = key;
    [[BNRImageStore sharedStore]setImage:image forKey:item.imageKey];
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
