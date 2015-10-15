//
//  H5Case.m
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "H5Case.h"

@implementation H5Case

- (id)init {
	if (self = [super init]) {
		_imageUrls = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)setImageUrls:(NSMutableArray *)imageUrls {
	for (int i = 0; i < imageUrls.count; i++) {
		AVFile *avFile = imageUrls[i];
		[_imageUrls addObject:avFile.url];
	}
}

@end
