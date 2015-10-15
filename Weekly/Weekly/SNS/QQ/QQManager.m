//
//  QQManager.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "QQManager.h"

@interface QQManager()
@property (retain, nonatomic) TencentOAuth	*tencentOAuth;
@property (retain, nonatomic) NSString		*accessToken;
@property (retain, nonatomic) NSString		*openId;
@property (retain, nonatomic) NSDate		*expirationDate;
@property (retain, nonatomic) NSString		*username;
@property (retain, nonatomic) NSString		*figureurl;		//头像url

@end

@implementation QQManager
@synthesize accessToken;
@synthesize openId;
@synthesize expirationDate;
@synthesize username;
@synthesize figureurl;

+ (QQManager *)sharedQQManager {
	static QQManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	return instance;
}

- (id)init {
	if (self = [super init]) {
		self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQAppId andDelegate:self];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	_tencentOAuth = nil;
}

- (void)login {
	NSArray* permissions = [NSArray arrayWithObjects:
							kOPEN_PERMISSION_GET_USER_INFO,
							kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
							kOPEN_PERMISSION_ADD_SHARE,
							nil];
	[_tencentOAuth authorize:permissions inSafari:NO];
}

- (void)logout {
	[_tencentOAuth logout:self];
}




#pragma mark - TencentLoginDelegate
//登录回调
- (void)tencentDidLogin {
	accessToken = [_tencentOAuth accessToken];
	openId = [_tencentOAuth openId];
	expirationDate = [_tencentOAuth expirationDate];
	[_tencentOAuth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
}

- (void)tencentDidNotNetWork {
}

- (void)responseDidReceivedNotify:(NSNotification *)notify {
}

#pragma mark - TencentSessionDelegate

- (void)tencentDidLogout {
}

- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message {
}

/* json数据中的头像字段
 figureurl		30	空间头像(数字代表图片大小)
 figureurl_1	50
 figureurl_2	100
 figureurl_qq_1	40	QQ头像
 figureurl_qq_2	100
 */
- (void)getUserInfoResponse:(APIResponse*)response {
	//用户信息字典
	NSLog(@"%@", response.jsonResponse);
	NSDictionary *dict = response.jsonResponse;
	username = dict[@"nickname"];
	figureurl = dict[@"figureurl_qq_2"];
	//用户可能不存在100*100大小的头像，使用40*40代替
	if (!figureurl || [figureurl isEqualToString:@""]) {
		figureurl = dict[@"figureurl_qq_1"];
	}
}

#pragma mark - QQApiInterfaceDelegate

- (void)onReq:(QQBaseReq *)req {
	switch (req.type) {
		case EGETMESSAGEFROMQQREQTYPE:
			break;
		default:
			break;
	}
}

- (void)onResp:(QQBaseResp *)resp {
	switch (resp.type) {
		case ESENDMESSAGETOQQRESPTYPE:
			break;
		default:
			break;
	}
}

- (void)isOnlineResponse:(NSDictionary *)response {
	NSArray *QQUins = [response allKeys];
	NSMutableString *messageStr = [NSMutableString string];
	for (NSString *str in QQUins) {
		if ([[response objectForKey:str] isEqualToString:@"YES"]) {
			[messageStr appendFormat:@"QQ号码为:%@ 的用户在线\n",str];
		} else {
			[messageStr appendFormat:@"QQ号码为:%@ 的用户不在线\n",str];
		}
	}
	NSLog(@"response:%@",response);
}

@end
