//
//  AddAssetType.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;
@interface AddAssetType : UIViewController
{
    
    __weak IBOutlet UITextField *assetTypeText;
}
- (IBAction)saveNewAssetType:(id)sender;
@property (strong, nonatomic) BNRItem *item;

@end
