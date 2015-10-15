//
//  SelectedViewController.m
//  Weekly
//
//  Created by horry on 15/10/14.
//  Copyright © 2015年 ___horryBear___. All rights reserved.
//

#import "SelectedViewController.h"
#import "SelectedCell.h"
#import "ScanCodeViewController.h"
#import "H5Case.h"
#import "DateUtils.h"

static NSString *const CellIdentifier = @"SelectedCellIdentifier1";
static NSString *const CellWithoutImageIdentifier = @"SelectedCellIdentifier2";

@interface SelectedViewController () {
	NSMutableArray *h5Cases;
}

@property (weak, nonatomic) IBOutlet PullRefreshTableView *selectedTableView;

@end

@implementation SelectedViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	self.navigationItem.title = @"每周精选H5";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoScanCode:)];
	h5Cases = [[NSMutableArray alloc] init];
	[self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)loadData {
	AVQuery *query = [AVQuery queryWithClassName:@"H5Case"];
	[query orderByDescending:@"date"];
	[query includeKey:@"h5Images"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			if (_selectedTableView.currentPageNum == 1) {
				[h5Cases removeAllObjects];
			}
			NSInteger maxCount = MIN(objects.count, _selectedTableView.currentPageNum * 10);
			for (int i = (_selectedTableView.currentPageNum - 1) * 10; i  < maxCount; i++) {
				AVObject *avObject = objects[i];
				H5Case *h5Case = [[H5Case alloc] init];
				h5Case.title = avObject[@"title"];
				h5Case.info = avObject[@"info"];
				h5Case.url = avObject[@"url"];
				h5Case.score = [avObject[@"score"] doubleValue];
				h5Case.imageUrls = avObject[@"h5Images"];
				h5Case.date = avObject[@"date"];
				h5Case.tags = avObject[@"tags"];
				[h5Cases addObject:h5Case];
			}
			// 检索成功
			[_selectedTableView reloadData];
			_selectedTableView.totalPages = (int)(objects.count / 10) + 1;
			[_selectedTableView loadOK];
		} else {
			// 输出错误信息
			[_selectedTableView loadFailed];
		}
	}];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_selectedTableView didScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_selectedTableView didEndDragging];
}

#pragma mark - PullRefreshTableViewDelegate

- (void)tableViewBeginPullRefreshLoading:(PullRefreshTableView *)tableView {
	[self loadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return h5Cases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SelectedCell *cell;
	H5Case *h5Case = h5Cases[indexPath.row];
	if (h5Case.imageUrls.count == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:CellWithoutImageIdentifier];
	}
	if (!cell) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectedCell" owner:self options:nil] lastObject];
	}
	if (indexPath.row == 0) {
		cell.showDate = YES;
	} else {
		H5Case *lastH5Case = h5Cases[indexPath.row - 1];
		cell.showDate = [[DateUtils sharedDateUtils] compareWithMonthAndDay:h5Case.date toDate:lastH5Case.date];
	}
	[cell setData:h5Case];
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	H5Case *h5Case = h5Cases[indexPath.row];
	SelectedCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectedCell" owner:self options:nil] lastObject];
	[cell setData:h5Case];
	return cell.height;
}

#pragma mark - Action

- (void)gotoScanCode:(id)sender {
	ScanCodeViewController *scanCodeViewController = [[ScanCodeViewController alloc] initWithNibName:@"ScanCodeViewController" bundle:nil];
	scanCodeViewController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:scanCodeViewController animated:YES];
}

@end
