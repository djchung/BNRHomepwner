//
//  BaseCell.m
//  BNRHomepwner
//
//  Created by DJ Chung on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
- (void)forward:(NSString *)actionMessage toController:(id)controller withObjects:(NSArray *)objects
{
    SEL newSelector = NSSelectorFromString(actionMessage);
    if (!objects) {
        [controller performSelector:newSelector];
    } else {
        
        NSString *methodName = actionMessage;
        for (id object in objects){
           
        
        }
    }
    
}
 */

@end
