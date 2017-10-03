//
//  TNNewsListViewController.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListViewController.h"
#import "TNNewsListTableViewCell.h"
#import "TNNewsListService.h"
#import "TNNewsListPayload+CoreDataClass.h"
#import "TNRouter.h"

@interface TNNewsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray<TNNewsListPayload *> *listPayloads;
@property (strong, nonatomic) TNNewsListService *newsListService;

@property (assign, nonatomic) BOOL isEnd;
@property (assign, nonatomic) BOOL isUpdating;
@property (assign, nonatomic) BOOL isFirstLoad;

@end

@implementation TNNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listPayloads = [NSMutableArray new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // refreshControl init
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self.activityIndicator startAnimating];

    self.newsListService = [TNNewsListService new];
    [self loadServiceData];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listPayloads.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TNNewsListPayload *payload = self.listPayloads[indexPath.section];
    
    TNNewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TNNewsListTableViewCell className]];
    cell.layer.cornerRadius = 3;
    [cell configureNewsWith:payload.text];
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame), 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TNNewsListPayload *newsListPayload = self.listPayloads[indexPath.section];
    [self.router showNewsDetailsFromSourceViewController:self withNews:newsListPayload.identifier];
}

- (void)refreshData:(UIRefreshControl *)refreshControl {
    [self loadServiceData];
    [refreshControl endRefreshing];
}

#pragma mark - Services

- (void)loadServiceData {
    _isFirstLoad = YES;
    typeof(self) __weak weakSelf = self;
    // Load data
    [self.newsListService obtainNewsListWithCompletionBlock:^(id result) {
        [weakSelf.listPayloads removeAllObjects];
        weakSelf.listPayloads = result;
        if (weakSelf.listPayloads.count) {
            weakSelf.isFirstLoad = NO;
            weakSelf.isUpdating = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.tableView reloadData];
        });
        }
    }];
}

- (void)loadServiceDataWithOffset:(NSInteger)offset {
    // Do not load data form loacl DB if this is the first load, btcaous there is no data
    if (_isFirstLoad) {
        return;
    }
    typeof(self) __weak weakSelf = self;
    [self.activityIndicator startAnimating];
    [self.newsListService fetchPayloadsListfromLocalDbWithOffset:offset WithCompletionBlock:^(id result) {
       if (offset == 0) {
        [weakSelf.listPayloads removeAllObjects];
       }
       NSArray *items = result;
       [weakSelf.listPayloads addObjectsFromArray:items];
       weakSelf.isUpdating = NO;
       weakSelf.isEnd = ![result count];
    dispatch_async(dispatch_get_main_queue(), ^{
       [weakSelf.activityIndicator stopAnimating];
       [weakSelf.tableView reloadData];
    });
   }];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // If no data don't loading from local DB
    if (_isEnd) {
        return;
    }
    if (_isUpdating) {
        return;
    }
    float currentOffset = scrollView.contentOffset.y;
    float maxOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    float deltaOffset = maxOffset - currentOffset;
    
    if (deltaOffset <= self.view.frame.size.height/3) {
        _isUpdating = YES;
        
        [self loadServiceDataWithOffset:self.offset];
    }
}

// Offset for the downloading data from local DB in in pieces
- (CGFloat)offset {
    NSInteger offset = 0;
    if (self.listPayloads.count) {
        offset = self.listPayloads.count;
    }
    return offset;
}

#pragma mark - Custom accesors

- (TNRouter *)router {
    if (!_router) {
        _router = [TNRouter new];
    }
    
    return _router;
}

@end
