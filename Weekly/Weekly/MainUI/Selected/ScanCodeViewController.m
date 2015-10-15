//
//  ScanCodeViewController.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "ScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "EditSelectedViewController.h"

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface ScanCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *sanFrameView;

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"扫描二维码";
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];

	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
	[_sanFrameView addGestureRecognizer:tapGesture];
	
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
	EditSelectedViewController *editSelectedViewController = [[EditSelectedViewController alloc] initWithNibName:@"EditSelectedViewController" bundle:nil];
	[self.navigationController pushViewController:editSelectedViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
	[self startReading];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopReading];
}

- (BOOL)startReading {
	// 获取 AVCaptureDevice 实例
	NSError * error;
	AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	// 初始化输入流
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
	if (!input) {
		NSLog(@"%@", [error localizedDescription]);
		return NO;
	}
	// 创建会话
	_captureSession = [[AVCaptureSession alloc] init];
	// 添加输入流
	[_captureSession addInput:input];
	// 初始化输出流
	AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
	// 添加输出流
	[_captureSession addOutput:captureMetadataOutput];
	
	// 创建dispatch queue.
	dispatch_queue_t dispatchQueue;
	dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
	[captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
	// 设置元数据类型 AVMetadataObjectTypeQRCode
	[captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
	
	// 创建输出对象
	_videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
	[_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	[_videoPreviewLayer setFrame:_sanFrameView.layer.bounds];
	[_sanFrameView.layer addSublayer:_videoPreviewLayer];
	// 开始会话
	[_captureSession startRunning];
	
	return YES;
}

- (void)stopReading {
	// 停止会话
	[_captureSession stopRunning];
	_captureSession = nil;
}

- (void)reportScanResult:(NSString *)result {
	[self stopReading];
	EditSelectedViewController *editSelectedViewController = [[EditSelectedViewController alloc] initWithNibName:@"EditSelectedViewController" bundle:nil];
	editSelectedViewController.url = result;
	[self.navigationController pushViewController:editSelectedViewController animated:YES];
}

#pragma AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
	  fromConnection:(AVCaptureConnection *)connection {
	if (metadataObjects != nil && [metadataObjects count] > 0) {
		AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
		NSString *result;
		if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
			result = metadataObj.stringValue;
		} else {
			NSLog(@"不是二维码");
		}
		[self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
	}
}

- (void)backAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
