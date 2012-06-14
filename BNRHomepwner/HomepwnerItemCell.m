//
//  HomepwnerItemCell.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomepwnerItemCell.h"

@implementation HomepwnerItemCell
@synthesize thumbNailView;
@synthesize nameLabel;
@synthesize serialNumberLabel;
@synthesize valueLabel;
@synthesize controller;
@synthesize tableView;

- (IBAction)showImage:(id)sender {
    //Get name of this method
    NSString *selector = NSStringFromSelector(_cmd);
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self];
    
    if (indexPath) {
        if ([self.controller respondsToSelector:newSelector]) {
            [self.controller performSelector:newSelector withObject:sender withObject:indexPath];

        }
    }
//    [self.controller showImage:sender atIndexPath:indexPath];
}
@end
