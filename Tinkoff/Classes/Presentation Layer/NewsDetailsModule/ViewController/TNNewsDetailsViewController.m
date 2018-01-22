//
//  TNNewsDetailsViewController.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetailsViewController.h"
#import "TNNewsDetailService.h"
#import <SafariServices/SafariServices.h>

@interface TNNewsDetailsViewController ()
@property (strong, nonatomic) TNNewsDetailService *newsDetailService;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIWebView *tnWebView;

@end

@implementation TNNewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.newsDetailService = [TNNewsDetailService new];
    [self configureAppearance];
    [self loadServiceData];
}

- (void)configureAppearance {
    self.tnWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tnWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Services

- (void)loadServiceData {
    [self.activityIndicator startAnimating];
    typeof(self) __weak weakSelf = self;
    [self.newsDetailService obtainNewsListWithNewsId:self.newsId WithCompletionBlock:^(id result) {
        NSString *contentString = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tnWebView loadHTMLString:contentString baseURL:nil];
                [weakSelf.activityIndicator stopAnimating];
            });
    }];
}

@end
