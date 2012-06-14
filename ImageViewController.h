//
//  ImageViewController.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imageView;
}
@property (strong, nonatomic) UIImage *image;
@end
