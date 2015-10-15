//
//  SelectedCell.h
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "H5Case.h"

@interface SelectedCell : UITableViewCell

@property (nonatomic) BOOL showDate;
@property (nonatomic) CGFloat height;

- (void)setData:(H5Case *)h5Case;

@end
