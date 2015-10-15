//
//  UIImage+Compress.h
//  Ftiao
//
//  Created by 熊烈 on 15/1/6.
//  Copyright (c) 2015年 Seedfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

//根据默认尺寸压缩图片
- (UIImage *)compressedImage;

//根据给定尺寸压缩图片
- (UIImage *)compressedImagetoSize:(CGFloat)maxSize;
@end
