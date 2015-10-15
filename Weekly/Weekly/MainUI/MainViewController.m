//
//  MainViewController.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "MainViewController.h"
#import "SelectedViewController.h"
#import "CasesViewController.h"
#import "LoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self customUI];
}

- (void)customUI {
	SelectedViewController *selectedViewController = [[SelectedViewController alloc] initWithNibName:@"SelectedViewController" bundle:nil];
	CasesViewController *casesViewController = [[CasesViewController alloc] initWithNibName:@"CasesViewController" bundle:nil];
	LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];

	_selectedNavController = [[UINavigationController alloc] initWithRootViewController:selectedViewController];
	_casesNavController = [[UINavigationController alloc] initWithRootViewController:casesViewController];
	_memberNavController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
	
	_selectedNavController.tabBarItem.title = kSelectedTitle;
	_casesNavController.tabBarItem.title = kCasesTitle;
	_memberNavController.tabBarItem.title = kMemberTitle;
	
	_selectedNavController.tabBarItem.image = [[UIImage imageNamed:@"tab_selected"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
	_casesNavController.tabBarItem.image = [[UIImage imageNamed:@"tab_cases"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
	_memberNavController.tabBarItem.image = [[UIImage imageNamed:@"tab_member"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
	
	_selectedNavController.navigationBar.translucent = NO;
	_casesNavController.navigationBar.translucent = NO;
	_memberNavController.navigationBar.translucent = NO;
	
	self.viewControllers = @[_selectedNavController, _casesNavController, _memberNavController];
	self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
