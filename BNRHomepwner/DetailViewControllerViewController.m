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
#import "BNRItemStore.h"
#import "AssetTypePicker.h"

@interface DetailViewControllerViewController ()

@end

@implementation DetailViewControllerViewController
@synthesize item;
@synthesize dismissBlock;

- (IBAction)showAssetTypePicker:(id)sender {
    [self.view endEditing:YES];
    
    AssetTypePicker *assetTypePicker = [[AssetTypePicker alloc]init];
    assetTypePicker.item = item;
    
    [self.navigationController pushViewController:assetTypePicker animated:YES];
}

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"DetailViewControllerViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *clr = nil;
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    }else {
        clr = [UIColor groupTableViewBackgroundColor];
    }
    self.view.backgroundColor = clr;
    
}

- (void)viewDidUnload {
    nameField = nil;
    serialNumberField = nil;
    valueField = nil;
    dateLabel = nil;
    imageView = nil;
    assetTypeButton = nil;
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
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:item.dateCreated];
    dateLabel.text = [dateFormatter stringFromDate:date];
    NSString *imageKey = item.imageKey;
    if (imageKey) {
        UIImage *imageToDispay = [[BNRImageStore sharedStore]imageForKey:imageKey];
        imageView.image = imageToDispay;
    }else {
        imageView.image = nil;
    }
    
    NSString *typeLabel = [item.assetType valueForKey:@"label"];
    if (!typeLabel) {
        typeLabel = @"None";
        
    }
    [assetTypeButton setTitle:[NSString stringWithFormat:@"Type: %@", typeLabel]  forState:UIControlStateNormal];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
    item.itemName = nameField.text;
    item.serialNumber = serialNumberField.text;
    item.valueInDollars = [valueField.text intValue];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        return YES;
    }else {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    }
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
    
    if ([imagePickerPopover isPopoverVisible]) {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
     
    }else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        imagePickerPopover = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
        imagePickerPopover.delegate = self;
        
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
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
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [item setThumbnailDataFromImage:image];
}

- (IBAction)clearImage:(id)sender {
    imageView.image = nil;
    [[BNRImageStore sharedStore]deleteImageForKey:item.imageKey];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    imagePickerPopover = nil;
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:dismissBlock];
    
}
@end
