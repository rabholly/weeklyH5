//
//  QQManager.h
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <Foundation/Foundation.h>

@interface QQManager : NSObject <TencentSessionDelegate,QQApiInterfaceDelegate>

+ (QQManager *)sharedQQManager;

- (void)login;
- (void)logout;

@end
