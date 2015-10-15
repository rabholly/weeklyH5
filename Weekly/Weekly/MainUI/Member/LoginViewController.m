//
//  LoginViewController.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "LoginViewController.h"
#import "QQManager.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self customUI];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customUI {
	_wxLoginButton.layer.masksToBounds = YES;
	_wxLoginButton.layer.borderWidth = 1.0;
	_wxLoginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
	
	_qqLoginButton.layer.masksToBounds = YES;
	_qqLoginButton.layer.borderWidth = 1.0;
	_qqLoginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
}

#pragma mark - Action

- (IBAction)qqLoginAction:(id)sender {
	[[QQManager sharedQQManager] login];
}

@end
