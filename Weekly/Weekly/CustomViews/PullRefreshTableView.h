//
//  PullRefreshTableView.h
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullRefreshTableViewDelegate;

@interface PullRefreshTableView : UITableView

@property (nonatomic) int currentPageNum;
@property (nonatomic) int totalPages;
@property (nonatomic, weak) IBOutlet id<PullRefreshTableViewDelegate> pullRefreshDelegate;

//加载结果
- (void)loadOK;
- (void)loadFailed;

- (void)didScroll;
- (void)didEndDragging;

@end


@protocol PullRefreshTableViewDelegate <NSObject>

- (void)tableViewBeginPullRefreshLoading:(PullRefreshTableView *)tableView;

@end
