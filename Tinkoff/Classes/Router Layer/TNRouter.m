//
//  TNRouter.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNRouter.h"
#import "TNNewsDetailsViewController.h"

@implementation TNRouter

- (void)showNewsDetailsFromSourceViewController:(UIViewController *)sourceViewController withNews:(NSString *)payloadId {
    UIStoryboard *aStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TNNewsDetailsViewController *newsDetailsViewController = [aStoryboard instantiateViewControllerWithIdentifier:@"TNNewsDetailsViewController"];
    newsDetailsViewController.newsId = payloadId;
    [self pushViewController:newsDetailsViewController fromSourceViewController:sourceViewController];
}

- (void)pushViewController:(UIViewController *)viewController fromSourceViewController:(UIViewController *)sourceViewController {
    if ([sourceViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)sourceViewController;
        [navController pushViewController:viewController animated:YES];
        return;
    }
    [sourceViewController.navigationController pushViewController:viewController animated:YES];
}

@end
