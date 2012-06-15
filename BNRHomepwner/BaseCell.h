//
//  BaseCell.h
//  BNRHomepwner
//
//  Created by DJ Chung on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

- (void)forward:(NSString *)actionMessage toController:(id)controller withObjects:(NSArray *)objects;

@end
