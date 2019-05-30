//
//  UIPageViewController+ZMAdd.h
//  ProjectArchitecture
//
//  Created by ZM on 2019/2/13.
//  Copyright © 2019年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIPageViewController (ZMAdd)

// PageViewController 的 ScrollView 滚动设置
+ (void)pageScrollEnabled:(BOOL)scrollEnabled pageVC:(UIPageViewController *)pageVC;
// 找到UIPageViewController 的 ScrollView
+ (UIScrollView *)findPageViewControllerScrollView:(UIPageViewController *)pageVC;

// PageViewController 的 ScrollView 滚动设置
- (void)pageScrollEnabled:(BOOL)scrollEnabled;
// 找到UIPageViewController 的 ScrollView
- (UIScrollView *)findScrollView;
    
    
@end

NS_ASSUME_NONNULL_END
