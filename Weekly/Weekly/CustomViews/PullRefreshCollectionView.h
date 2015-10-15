//
//  PullRefreshCollectionView.h
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullRefreshCollectionViewDelegate;

@interface PullRefreshCollectionView : UICollectionView

@property (nonatomic) int currentPageNum;
@property (nonatomic) int totalPages;
@property (nonatomic, weak) IBOutlet id<PullRefreshCollectionViewDelegate> pullRefreshDelegate;

//加载结果
- (void)loadOK;
- (void)loadFailed;
- (void)updateView;

- (void)didScroll;
- (void)didEndDragging;

@end


@protocol PullRefreshCollectionViewDelegate <NSObject>

- (void)collectionViewBeginPullRefreshLoading:(PullRefreshCollectionView *)collectionView;

@end
