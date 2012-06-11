//
//  ChangeDateViewController.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface ChangeDateViewController : UIViewController
{
    
    __weak IBOutlet UIDatePicker *datePicker;
}
@property (strong, nonatomic) BNRItem *item;
@end
