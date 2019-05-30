//
//  UIView+ZMAdd.h
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZMAdd)

/**
 设置
 @param cornerRadius 圆弧半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
-(void)zm_cornerRadius:(CGFloat)cornerRadius
           borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *_Nonnull)borderColor;
/**
 设置view的四个边角圆弧
 
 @param myView  要设置的View
 @param corners 不同的角度
 @param radii   每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
+  (void)zm_setCornersOfView:(UIView *_Nullable)myView frame:(CGRect)frame
                   byCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)radii
                   fillColor:(UIColor *_Nullable)fillColor
                   lineWidth:(CGFloat )lineWidth
                   lineColor:(UIColor *_Nullable)lineColor;

/**
 阴影设置：shadow
 
 @param myView  主视图
 @param shadowOffset  阴影偏移
 @param shadowColor   阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius  阴影角弧度
 */
+ (void)zm_setshadowOfView:(UIView *_Nonnull)myView
              shadowOffset:(CGSize)shadowOffset
               shadowColor:(UIColor *_Nonnull)shadowColor
             shadowOpacity:(float)shadowOpacity
              shadowRadius:(CGFloat)shadowRadius
              cornerRadius:(CGFloat)cornerRadius;


/**
 设置渐变色：多种颜色
 
 @param myView 主View
 @param frame 尺寸位置
 @param startPoint 开始位置
 @param endPoint   结束位置
 @param colors    渐变颜色
 @param locations 渐变位置
 @param idx 在接收者子数组的“idx”位置插入“层”。如果“层”已经有一个超层，它将被删除之前插入。
 */
+ (void)zm_setGradientOfView:(UIView *_Nonnull)myView frame:(CGRect)frame 
                  startPoint:(CGPoint)startPoint 
                    endPoint:(CGPoint)endPoint  
                      colors:(NSArray *_Nonnull)colors 
                   locations:(NSArray<NSNumber *> *_Nonnull)locations atIndex:(unsigned)idx;

/**
 设置渐变色：两种颜色
 
 @param myView 主View
 @param frame 尺寸位置
 @param oneColor 开始颜色
 @param twoColor 结束颜色
 @param startPoint 开始位置
 @param endPoint 结束位置
 @param locations 渐变位置
 @param idx 在接收者子数组的“idx”位置插入“层”。如果“层”已经有一个超层，它将被删除之前插入。
 */
+ (void)zm_setGradientOfView:(UIView *_Nonnull)myView frame:(CGRect)frame 
                    oneColor:(UIColor *_Nonnull)oneColor 
                    twoColor:(UIColor *_Nonnull)twoColor 
                  startPoint:(CGPoint)startPoint 
                    endPoint:(CGPoint)endPoint  
                   locations:( NSArray<NSNumber *> *_Nonnull)locations atIndex:(unsigned)idx;


/**
 画虚线
 
 @param dashArray 虚线间隙数组
 @param startPoint  开始点 坐标
 @param endPoint    结束点 坐标
 @param lineWidth 线宽
 @param lineColor 线颜色
 */
- (void)zm_drawDashLineOfDashArray:(const CGFloat *_Nonnull)dashArray
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint
                         lineWidth:(CGFloat)lineWidth
                         lineColor:(UIColor *_Nonnull)lineColor;


// 设置view的：边角弧度
- (void)zm_setCornerRadius:(CGFloat)cornerRadius;
// 设置view的：边角弧度、边框
- (void)zm_setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor;


/**
 1.设置view的四个边角圆弧 (添加图层)
 
 @param corners 不同的角度
 @param radii 每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
- (void)zm_setCornersByCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)radii
                     fillColor:(UIColor *_Nonnull)fillColor
                     lineWidth:(CGFloat )lineWidth
                     lineColor:(UIColor *_Nonnull)lineColor;
/**
 2.1 设置view的四个边圆角 (遮罩图层)
 
 @param corners 圆角的位置
 @param cornerRadii 每个角的半径.
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

//2.2 设置view的四个边圆角 (遮罩图层：自定义图层大小)
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii frame:(CGRect)frame;

//2.3（同上：不用self，用view）
- (void)setCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii 
              view:(UIView *_Nonnull)view frame:(CGRect)frame;

//等边三角形（垂直）
- (void)zm_drawTriangleStarX:(CGFloat)xx starY:(CGFloat)yy ww:(CGFloat)ww hh:(CGFloat)hh
                   fillColor:(UIColor * _Nonnull )fillColor 
                   lineWidth:(CGFloat)lineWidth 
                   lineColor:(UIColor * _Nonnull)lineColor;


// 清除UITableView底部多余的分割线
+ (void)zm_clearTableViewLine:(UITableView *_Nonnull)tabelView
                 isHeaderView:(BOOL)isHeader
                 isFooterView:(BOOL)isFooter;

/**
 *  移除所有子视图
 */
- (void)zm_removeAllSubview;

#pragma mark 导航视图 动画
- (void)zm_pushViewController:(UIViewController *_Nonnull)nav;

#pragma mark 普通动画
- (void)zm_flipView:(UIView *_Nonnull)myView
               Rect:(CGRect)myRect
            forView:(UIView *_Nonnull)view
       timeInterval:(NSTimeInterval)durationTime;



// 动画 (模仿系统方法)
- (void)zm_animationDuration:(NSTimeInterval)duration animation:(void (^_Nonnull)(void) )animationBlock;

// 翻页动画
- (void)zm_animationDuration:(NSTimeInterval)duration
                  transition:(UIViewAnimationTransition)transition
                       curve:(UIViewAnimationCurve)curve
                   animation:(void (^_Nonnull)(void) )animationBlock;

@end
