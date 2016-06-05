//
//  MeasureMeNavigationController.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-20.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "MeasureMeNavigationController.h"

@interface MeasureMeNavigationController () <UINavigationControllerDelegate>

@end

@implementation MeasureMeNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [super pushViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    return [super popToRootViewControllerAnimated:animated];
}
#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

@end
