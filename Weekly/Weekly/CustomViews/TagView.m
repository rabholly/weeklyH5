//
//  TagView.m
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "TagView.h"

@interface TagView() {
	UILabel *label;
}

@end

@implementation TagView

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if(self) {
		label = [[UILabel alloc] init];
		label.frame = self.bounds;
		label.layer.masksToBounds = YES;
		label.text = @"节日";
		label.font = [UIFont systemFontOfSize:14];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[self addGestureRecognizer:tapGesture];
		
		self.selected = NO;
	}
	return self;
}

- (void)setText:(NSString *)text {
	_text = text;
	label.text = text;
}

- (void)setSelected:(BOOL)selected {
	_selected = selected;
	if (selected) {
		label.layer.borderWidth = 1.0;
		label.layer.borderColor = [[UIColor redColor] CGColor];
	} else {
		label.layer.borderWidth = 1.0;
		label.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	}
	
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
	self.selected = !_selected;
}

@end
