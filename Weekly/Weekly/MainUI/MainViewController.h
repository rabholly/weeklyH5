//
//  MainViewController.h
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController

@property (nonatomic, strong) UINavigationController *selectedNavController;
@property (nonatomic, strong) UINavigationController *casesNavController;
@property (nonatomic, strong) UINavigationController *memberNavController;

@end
