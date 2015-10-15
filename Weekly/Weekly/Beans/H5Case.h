//
//  H5Case.h
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H5Case : NSObject

@property (nonatomic) long long caseID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) CGFloat score;
@property (nonatomic, strong) NSMutableArray *imageUrls;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSArray *tags;

@end
