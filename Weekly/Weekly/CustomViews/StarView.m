//
//  StarView.m
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "StarView.h"
static const NSInteger starWidth = 12;

@interface StarView () {
	NSMutableArray *stars;
}

@end

@implementation StarView

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if(self) {
		stars = [[NSMutableArray alloc] init];
		for (int i = 0; i < 5; i ++) {
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * starWidth, 0, 12, 12)];
			imageView.image = [UIImage imageNamed:@"star_normal"];
			[self addSubview:imageView];
			[stars addObject:imageView];
		}
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[self addGestureRecognizer:tapGesture];
	}
	return self;
}

- (void)setScore:(NSInteger)score {
	_score = score;
	for (int i = 0; i < score; i++) {
		UIImageView *imageView = stars[i];
		imageView.image = [UIImage imageNamed:@"star_highlight"];
	}
	
	for (int i = score; i < stars.count; i++) {
		UIImageView *imageView = stars[i];
		imageView.image = [UIImage imageNamed:@"star_normal"];
	}
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
	CGPoint point = [gestureRecognizer locationInView:self];
	self.score = point.x / starWidth + 1;
}

@end
