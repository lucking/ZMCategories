//
//  UIPageViewController+ZMAdd.m
//  ProjectArchitecture
//
//  Created by ZM on 2019/2/13.
//  Copyright © 2019年 ZM. All rights reserved.
//

#import "UIPageViewController+ZMAdd.h"

@implementation UIPageViewController (ZMAdd)

// PageViewController 的 ScrollView 滚动设置
+ (void)pageScrollEnabled:(BOOL)scrollEnabled pageVC:(UIPageViewController *)pageVC{
    UIScrollView *scrollView = [self findPageViewControllerScrollView:pageVC];
    scrollView.scrollEnabled = scrollEnabled;
}
// 找到UIPageViewController 的 ScrollView
+ (UIScrollView *)findPageViewControllerScrollView:(UIPageViewController *)pageVC {
    UIScrollView *scrollView = nil;
    for(UIView *eachSubview in pageVC.view.subviews) {
        if([eachSubview isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)eachSubview;
            break;
        }
    }
    return scrollView;
}

// PageViewController 的 ScrollView 滚动设置
- (void)pageScrollEnabled:(BOOL)scrollEnabled {
    UIScrollView *scrollView = [self findScrollView];
    scrollView.scrollEnabled = scrollEnabled;
}
// 找到UIPageViewController 的 ScrollView
- (UIScrollView *)findScrollView {
    UIScrollView *scrollView = nil;
    for(UIView *eachSubview in self.view.subviews) {
        if([eachSubview isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)eachSubview;
            break;
        }
    }
    return scrollView;
}


@end
