//
//  UIViewController+ZMAdd.h
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^BackBlock) (UIButton *);
typedef void(^NoDataBtnBlock) (void);

@interface UIViewController (ZMAdd)

#pragma mark ===================="  add property  "==============================
/**
 *  要在Category中扩展的属性
 */
//测试
@property (nonatomic, strong) NSObject *property;
@property (nonatomic, strong) UILabel *zmLab;
@property (nonatomic, copy) NSString *name;
//导航栏上的按钮
@property (nonatomic, weak) UIButton *itemBtn;
//返回按钮
@property (nonatomic, weak) UIButton *backBtn;
//暂无数据，点击刷新
@property (nonatomic, weak) UIButton *noDataBtn;
//返回按钮：响应回调
@property (nonatomic, copy) BackBlock backBlock;
//暂无数据，点击刷新：响应回调
@property (nonatomic, copy) NoDataBtnBlock noDataRefreshBlock;
//IPhoneX，状态栏
@property (nonatomic, weak) UIImageView *statusBarView;


// 测试使用
- (void )addBtnTitle:(NSString *)title frame:(CGRect)frame tag:(int)tag;
// 测试使用 按钮
- (void)BtnClick:(UIButton *)Btn;


#pragma mark ===================="  private method  "==============================

// 自定义：状态栏
- (void)zm_addStatusBarViewImgName:(NSString *)imgName frame:(CGRect)frame;

// 自定义：暂无数据，点击刷新
- (void)zm_addNoDataBtnToSuperview:(UIView *)superview 
                          title:(NSString *)title
                        imgName:(NSString *)imgName 
                          frame:(CGRect)frame isAddWindow:(BOOL)isAddWindow;
- (void)zm_addNoDataBtnToSuperview:(UIView *)superview;


// 自定义 navigationItem：（使用系统 UIBarButtonItem）
- (void)zm_addNavigationItemRect:(CGRect)rect
                        title:(NSString *)title
                      imgName:(NSString *)imgName tag:(NSInteger)tag isRightItem:(BOOL)isRightItem;

// 自定义 navigationItem：UIButton可控制属性（self.itemBtn）
- (void)zm_addNavItemRect:(CGRect)rect
                 title:(NSString *)title
               imgName:(NSString *)imgName tag:(NSInteger)tag isRightItem:(BOOL)isRightItem;
// 导航栏按钮：响应
- (void)zm_navigationItemClick:(UIButton *)btn;


/**
 返回按钮：自定义图片
 @param noNavBar 是否有导航栏
 @param normalBack 是否正常返回
 */
-(void)zm_backBtnNoNavBar:(BOOL)noNavBar normalBack:(BOOL)normalBack;

#pragma mark 导航栏最下的一条线 改变坐标
- (void)zm_navBarlineImgViewChangeFrame;
// 是否隐藏导航栏最下的一条线
-(void)zm_navBarlineImgViewHidden:(BOOL)hidden;
// 找到导航栏最下面的一条线
- (UIImageView *)zm_findHairlineImageViewUnder:(UIView *)view;
// 注意：这个是UIImage 导航栏最下的一条线
- (UIImage *)zm_createImageWithColor:(UIColor*) color;

// 获取当前屏幕显示的_viewController
+ (UIViewController *)zm_getCurrentVC;
// 添加线：坐标、颜色、透明度
-(void)zm_addlineBg:(UIView*)view Rect:(CGRect)rect Color:(UIColor*)color Alpha:(float)alpha;



@end

