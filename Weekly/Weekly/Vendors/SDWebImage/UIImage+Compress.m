//
//  UIImage+Compress.m
//  Ftiao
//
//  Created by 熊烈 on 15/1/6.
//  Copyright (c) 2015年 Seedfield. All rights reserved.
//

#import "UIImage+Compress.h"

#define DEFAULT_MAX_IMAGEPIX 200.0				//默认压缩尺寸

@implementation UIImage (Compress)

- (UIImage *)compressedImage {
    return  [self compressedImagetoSize:DEFAULT_MAX_IMAGEPIX];
}

- (UIImage *)compressedImagetoSize:(CGFloat)maxSize {
	CGFloat width = self.size.width;
	CGFloat height = self.size.height;
	
	if (MAX(width, height) <= maxSize) {
		return self;
	}
	
	//裁剪图片为正方形
	CGFloat minLength = MIN(width, height);
	UIImage *subImage;
	if (width > height) {
		subImage = [self getSubImage:CGRectMake((width - minLength) / 2, 0, floorf(minLength), floorf(minLength))];
	} else {
		subImage = [self getSubImage:CGRectMake(0, (height - minLength) / 2, floorf(minLength), floorf(minLength))];
	}
	
	//压缩图片
    UIGraphicsBeginImageContext(CGSizeMake(DEFAULT_MAX_IMAGEPIX, DEFAULT_MAX_IMAGEPIX));
	[subImage drawInRect:CGRectMake(0, 0, DEFAULT_MAX_IMAGEPIX, DEFAULT_MAX_IMAGEPIX)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	//降低图片质量
	CGFloat scaleRatio = DEFAULT_MAX_IMAGEPIX / minLength;
	return [UIImage imageWithData:UIImageJPEGRepresentation(imageCopy,scaleRatio)];
}

//裁剪图片到指定尺寸
- (UIImage *)getSubImage:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect subImageBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(subImageBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageBounds, subImageRef);
    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
	CGImageRelease(subImageRef);
	
    return subImage;
}

@end