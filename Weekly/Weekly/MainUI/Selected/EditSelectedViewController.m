//
//  EditSelectedViewController.m
//  Weekly
//
//  Created by horry on 15/10/15.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "EditSelectedViewController.h"
#import "TagView.h"
#import "StarView.h"

@interface EditSelectedViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
	NSMutableArray *h5Images;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIView *tagBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *photoBgView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (strong, nonatomic) IBOutletCollection(TagView) NSArray *tags;
@property (strong, nonatomic) IBOutletCollection(StarView) NSArray *stars;
@end

@implementation EditSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.title = @"编辑案例";
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
	h5Images = [[NSMutableArray alloc] init];
	[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
	[_scrollView addGestureRecognizer:tapGesture];
	
	[self customUI];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)customUI {
	_photoBgView.layer.masksToBounds = YES;
	_photoBgView.layer.borderWidth = 1.0;
	_photoBgView.layer.cornerRadius = 2.0;
	_photoBgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoAction:)];
	[_photoBgView addGestureRecognizer:tapGesture];
	
	_tagBgView.layer.masksToBounds = YES;
	_tagBgView.layer.borderWidth = 1.0;
	_tagBgView.layer.cornerRadius = 2.0;
	_tagBgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	
	_titleTextField.layer.masksToBounds = YES;
	_titleTextField.layer.borderWidth = 1.0;
	_titleTextField.layer.cornerRadius = 2.0;
	_titleTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	CGRect frame = _titleTextField.frame;
	frame.size.width = 5;
	UIView *leftView = [[UIView alloc] initWithFrame:frame];
	_titleTextField.leftViewMode = UITextFieldViewModeAlways;
	_titleTextField.leftView = leftView;
	
	_infoTextView.layer.masksToBounds = YES;
	_infoTextView.layer.borderWidth = 1.0;
	_infoTextView.layer.cornerRadius = 2.0;
	_infoTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	
	_saveButton.layer.masksToBounds = YES;
	_saveButton.layer.borderWidth = 1.0;
	_saveButton.layer.cornerRadius = 2.0;
	_saveButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	
	NSArray *tagText = @[@"节日", @"情怀", @"动画", @"游戏", @"招聘"];
	for (int i = 0; i < _tags.count; i ++) {
		TagView *tagView = _tags[i];
		tagView.text = tagText[i];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 键盘通知

- (void)keyboardWillShow:(NSNotification *)notification {
	CGRect keyboardBounds;
	[[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
	NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:[duration doubleValue]];
	[UIView setAnimationCurve:(UIViewAnimationCurve)[curve intValue]];
	CGRect frame = self.view.frame;
	frame.origin.y = 64 - keyboardBounds.size.height / 2;
	self.view.frame = frame;
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:[duration doubleValue]];
	[UIView setAnimationCurve:[curve intValue]];
	CGRect frame = self.view.frame;
	frame.origin.y = 64;
	self.view.frame = frame;
	[UIView commitAnimations];
}

#pragma mark - Action

- (void)backAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)addPhotoAction:(UITapGestureRecognizer *)gestureRecognizer {
	//实例化照片选择控制器
	UIImagePickerController *pickControl=[[UIImagePickerController alloc]init];
	//设置照片源
	[pickControl setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	//设置协议
	[pickControl setDelegate:self];
	//设置编辑
	[pickControl setAllowsEditing:YES];
	//选完图片之后回到的视图界面
	[self presentViewController:pickControl animated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
	AVObject *h5Case = [AVObject objectWithClassName:@"H5Case"];
	[h5Case setObject:_titleTextField.text forKey:@"title"];
	[h5Case setObject:_infoTextView.text forKey:@"info"];
	[h5Case setObject:[NSDate date] forKey:@"date"];
	NSMutableArray *tags = [[NSMutableArray alloc] init];
	for (int i = 0; i < _tags.count; i ++) {
		TagView *tagView = _tags[i];
		if (tagView.selected) {
			[tags addObject:tagView.text];
		}
	}
	[h5Case setObject:tags forKey:@"tags"];
	CGFloat score = 0;
	for (int i = 0; i < _stars.count; i ++) {
		StarView *starView = _stars[i];
		score += starView.score * 2;
	}
	[h5Case setObject:@(score / _stars.count) forKey:@"score"];
	NSMutableArray *avFiles = [[NSMutableArray alloc] init];
	NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
		for (int i = 0; i < h5Images.count; i++) {
			NSData *imagedata = UIImagePNGRepresentation(h5Images[i]);
			AVFile *file = [AVFile fileWithName:@"h5Image.png" data:imagedata];
			[file save];
			[avFiles addObject:file];
		}
	}];
	
	NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
		[h5Case setObject:avFiles forKey:@"h5Images"];
		[h5Case save];
	}];
	
	[op2 addDependency:op1];
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:op1];
	[queue addOperation:op2];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
	[_titleTextField resignFirstResponder];
	[_infoTextView resignFirstResponder];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image=info[@"UIImagePickerControllerEditedImage"];
	if (h5Images.count == 0) {
		_imageView1.image = image;
	} else if (h5Images.count == 1) {
		_imageView2.image = image;
	} else if (h5Images.count == 2) {
		_imageView3.image = image;
	}
	[h5Images addObject:image];
	//选取完图片之后关闭视图
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	_titleTextField.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
