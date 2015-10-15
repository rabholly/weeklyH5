//
//  PullRefreshTableView.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "PullRefreshTableView.h"

typedef NS_ENUM(NSInteger, PullRefreshState) { //刷新状态
	PullRefreshNormal,		//未刷新
	PullRefreshPulling,		//正在拉伸
	PullRefreshLoading,		//正在加载
};

@interface PullRefreshTableView () {
	UIRefreshControl *refreshControl;
	UILabel *loadingLabel;
}

@property (nonatomic) BOOL refreshEnabled;	//是否开启下拉刷新功能，默认开启
@property (nonatomic) BOOL pullEnabled;		//是否开启上拉加载更多功能，默认关闭
@property (nonatomic) PullRefreshState state;

@end

@implementation PullRefreshTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setup];
    }
    return self;
}

- (void)awakeFromNib {
	[self setup];
}

- (void)setup {
	_currentPageNum = 1;
	self.refreshEnabled = YES;
	self.pullEnabled = NO;
	self.state = PullRefreshNormal;
}

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
	_refreshEnabled = refreshEnabled;
	[self updateView];
}

- (void)setPullEnabled:(BOOL)pullEnabled {
	_pullEnabled = pullEnabled;
	[self updateView];
}

- (void)updateView {
	if (_refreshEnabled) {
		if (!refreshControl) {
			refreshControl = [[UIRefreshControl alloc] init];
			refreshControl.tintColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
			[refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
			[self addSubview:refreshControl];
		}
	} else {
		[refreshControl removeFromSuperview];
		refreshControl = nil;
	}
	
	if (_pullEnabled) {
		if (loadingLabel) {
			loadingLabel.frame = CGRectMake(0, self.contentSize.height + 10, self.frame.size.width, 20);
		} else {
			loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentSize.height + 10, self.frame.size.width, 20)];
			loadingLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
			loadingLabel.font = [UIFont systemFontOfSize:15];
			loadingLabel.textAlignment = NSTextAlignmentCenter;
			[self addSubview:loadingLabel];
		}
	} else {
		[loadingLabel removeFromSuperview];
		loadingLabel = nil;
	}
}

- (void)refreshControlAction:(id)sender {
	_currentPageNum = 1;
	[_pullRefreshDelegate tableViewBeginPullRefreshLoading:self];
}

#pragma mark - 加载结果

- (void)loadOK {
	if (_currentPageNum == 1) {
		[self refreshLoadOK];
	} else {
		[self pullLoadOK];
	}
	
	self.pullEnabled = _currentPageNum < _totalPages;
	[self updateView];
}

- (void)loadFailed {
	if (_currentPageNum == 1) {
		[self refreshLoadFailed];
	} else {
		[self pullLoadFailed];
	}
}

#pragma mark - 下拉刷新

- (void)refreshLoadOK {
	[refreshControl endRefreshing];
}

- (void)refreshLoadFailed {
	[refreshControl endRefreshing];
}

#pragma mark - 上拉加载更多

- (void)pullLoadOK {
	self.state = PullRefreshNormal;
	[UIView animateWithDuration:0.3 animations:^{
		self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	}];
}

- (void)pullLoadFailed {
	_currentPageNum--;
	self.state = PullRefreshNormal;
	[UIView animateWithDuration:0.3 animations:^{
		self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	}];
}

#pragma mark - UIScrollView

- (void)didScroll {
	if (self.contentOffset.y + self.frame.size.height < self.contentSize.height + kLoadingHeight && self.contentOffset.y > 0) {
		self.state = PullRefreshNormal;
	} else if (self.contentOffset.y + self.frame.size.height > self.contentSize.height + kLoadingHeight) {
		self.state = PullRefreshPulling;
	}
}

- (void)didEndDragging {
	if (_currentPageNum < _totalPages && self.contentOffset.y > 0 &&
		self.contentOffset.y + self.frame.size.height > self.contentSize.height + kLoadingHeight &&
		_pullEnabled) {
		_currentPageNum++;
		[_pullRefreshDelegate tableViewBeginPullRefreshLoading:self];
		self.state = PullRefreshLoading;
		[UIView animateWithDuration:0.3 animations:^{
			self.contentInset = UIEdgeInsetsMake(0, 0, kLoadingHeight, 0);
		}];
	}
}

- (void)setState:(PullRefreshState)state {
	_state = state;
	switch (_state) {
		case PullRefreshNormal:
			loadingLabel.text = kPull;
			break;
		case PullRefreshPulling:
			loadingLabel.text = kLoadMore;
			break;
		case PullRefreshLoading:
			loadingLabel.text = kLoading;
			break;
		default:
			break;
	}
}

@end
