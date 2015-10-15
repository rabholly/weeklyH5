//
//  SelectedCell.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "SelectedCell.h"
#import "DateUtils.h"
#import "UIImageView+WebCache.h"

@interface SelectedCell () {
	CGAffineTransform originalTransform;
	BOOL praiseable;
}
@property (weak, nonatomic) IBOutlet UIView *introduceBgView;
@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UIView *dateBgView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation SelectedCell

- (void)awakeFromNib {
    // Initialization code
	_scoreLabel.layer.masksToBounds = YES;
	_scoreLabel.layer.cornerRadius = 6;
}

- (void)setData:(H5Case *)h5Case {
	_scoreLabel.text = [NSString stringWithFormat:@"%.1f分", h5Case.score];
	_titleLabel.text = h5Case.title;
	_infoLabel.text = h5Case.info;
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:_infoLabel.font,NSFontAttributeName,nil];
	CGSize size = CGSizeMake(_infoLabel.frame.size.width, 20000.0f);
	size = [h5Case.info boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
	if (size.height < _infoLabel.frame.size.height) {
		CGRect frame = _infoLabel.frame;
		frame.size.height = size.height;
		_infoLabel.frame = frame;
	}
	
	_dayLabel.text = [NSString stringWithFormat:@"%@",@([[DateUtils sharedDateUtils] dayInDate:h5Case.date])];
	_monthLabel.text = [NSString stringWithFormat:@"%@月",@([[DateUtils sharedDateUtils] monthInDate:h5Case.date])];
	
	if (h5Case.imageUrls.count == 0) {
		CGRect frame = _introduceBgView.frame;
		frame.origin.y = _imageBgView.frame.origin.y;
		_introduceBgView.frame = frame;
		_imageBgView.hidden = YES;
	} else {
		for (int i = 0; i < _imageViews.count; i++) {
			UIImageView *imageView = _imageViews[i];
			if (i < h5Case.imageUrls.count) {
				[imageView sd_setImageWithURL:h5Case.imageUrls[i]];
			} else {
				imageView.image = nil;
			}
		}
	}
	_dateBgView.hidden = !_showDate;
	_height = _introduceBgView.frame.origin.y + _introduceBgView.frame.size.height;
}

@end
