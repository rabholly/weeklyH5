//
//  AppDelegate.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "QQManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	[AVOSCloud setApplicationId:kLeancloudId
					  clientKey:kLeancloudKey];
	
//	for (int i = 0; i < 9; i++) {
//		AVObject *h5Case = [AVObject objectWithClassName:@"H5Case"];
//		[h5Case setObject:@"haha" forKey:@"title"];
//		[h5Case setObject:@"heieheiheiheieheie" forKey:@"info"];
//		[h5Case setObject:[NSDate date] forKey:@"date"];
//		[h5Case save];
//	}
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	MainViewController *mainViewController = [[MainViewController alloc] init];
	self.window.rootViewController = mainViewController;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	NSString *string =[url absoluteString];
	if ([string hasPrefix:[NSString stringWithFormat:@"tencent%@", kQQAppId]]) {
		//登录回调
		return [TencentOAuth HandleOpenURL:url];

	}
	
	return YES;
}
@end
