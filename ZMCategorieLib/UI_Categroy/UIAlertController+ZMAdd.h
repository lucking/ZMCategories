//
//  UIAlertController+ZMAdd.h
//  ProjectArchitecture
//
//  Created by ZM on 2017/2/28.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ZMAdd)

+ (void)zm_alertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;

@end
