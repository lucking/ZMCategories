//
//  UIView+ZMAdd.m
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "UIView+ZMAdd.h"
#import "UILabel+ZMAdd.h"

@implementation UIView (ZMAdd)

/**
 设置圆弧
 @param cornerRadius 圆弧半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
-(void)zm_cornerRadius:(CGFloat)cornerRadius
           borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor
{
    self.layer.cornerRadius= cornerRadius;
    self.layer.masksToBounds= YES;
    self.layer.borderWidth= borderWidth;
    self.layer.borderColor= borderColor.CGColor;
}

/**
 设置view的四个边角圆弧
 
 @param myView  要设置的View
 @param corners 不同的角度
 @param radii   每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
+ (void)zm_setCornersOfView:(UIView *)myView frame:(CGRect)frame
                  byCorners:(UIRectCorner)corners
                cornerRadii:(CGSize)radii
                  fillColor:(UIColor *)fillColor
                  lineWidth:(CGFloat )lineWidth
                  lineColor:(UIColor *)lineColor {
    //myView.bounds
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corners
                                                     cornerRadii:radii];
    CAShapeLayer *shapeLayer= [CAShapeLayer layer];
    shapeLayer.fillColor    = fillColor.CGColor;
    shapeLayer.strokeColor  = lineColor.CGColor;
    shapeLayer.lineWidth    = lineWidth;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [myView.layer addSublayer:shapeLayer];
}


/**
 阴影设置：shadow
 
 @param myView  主视图
 @param shadowOffset  阴影偏移
 @param shadowColor   阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius  阴影角弧度
 */
+ (void)zm_setshadowOfView:(UIView *)myView
              shadowOffset:(CGSize)shadowOffset
               shadowColor:(UIColor *)shadowColor
             shadowOpacity:(float)shadowOpacity
              shadowRadius:(CGFloat)shadowRadius
              cornerRadius:(CGFloat)cornerRadius
{
    myView.layer.shadowOffset = shadowOffset;
    myView.layer.shadowColor  = shadowColor.CGColor;
    myView.layer.shadowOpacity= shadowOpacity;
    myView.layer.shadowRadius = shadowRadius;
    myView.layer.cornerRadius = cornerRadius;    
}

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
+ (void)zm_setGradientOfView:(UIView *)myView frame:(CGRect)frame 
                  startPoint:(CGPoint)startPoint 
                    endPoint:(CGPoint)endPoint  
                      colors:(NSArray *)colors 
                   locations:(NSArray<NSNumber *> *)locations atIndex:(unsigned)idx {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = startPoint;
    layer.endPoint   = endPoint;  
    layer.colors     = colors;
    layer.locations  = locations;
    layer.frame = frame;
    [myView.layer insertSublayer:layer atIndex:idx];
}

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
+ (void)zm_setGradientOfView:(UIView *)myView frame:(CGRect)frame 
                    oneColor:(UIColor *)oneColor 
                    twoColor:(UIColor *)twoColor 
                  startPoint:(CGPoint)startPoint 
                    endPoint:(CGPoint)endPoint  
                   locations:( NSArray<NSNumber *> *)locations atIndex:(unsigned)idx {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = startPoint;
    layer.endPoint   = endPoint;  
    layer.colors = [NSArray arrayWithObjects:
                    (id)oneColor.CGColor,
                    (id)twoColor.CGColor,nil];
    layer.locations = locations;
    layer.frame = frame;
    [myView.layer insertSublayer:layer atIndex:idx];
}




/**
 画虚线
 @param dashArray 虚线间隙数组
 @param startPoint  开始点 坐标
 @param endPoint    结束点 坐标
 @param lineWidth 线宽
 @param lineColor 线颜色
 */
- (void)zm_drawDashLineOfDashArray:(const CGFloat *)dashArray
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint
                         lineWidth:(CGFloat)lineWidth
                         lineColor:(UIColor *)lineColor {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(ctx, 0, dashArray, 2);
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
}


// 设置view的：边角弧度
- (void)zm_setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}
// 设置view的：边角弧度、边框
- (void)zm_setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

//1和2：这两种方式最好，对内存的消耗最少，而且渲染快速
/**
 1.设置view的四个边角圆弧 (添加图层)
 
 @param corners 不同的角度
 @param radii 每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
- (void)zm_setCornersByCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii
                     fillColor:(UIColor *)fillColor
                     lineWidth:(CGFloat )lineWidth
                     lineColor:(UIColor *)lineColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:radii];
    CAShapeLayer *shapeLayer= [CAShapeLayer layer];
    shapeLayer.fillColor    = fillColor.CGColor;
    shapeLayer.strokeColor  = lineColor.CGColor;
    shapeLayer.lineWidth    = lineWidth;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}
/**
 2.1 设置view的四个边圆角 (遮罩图层)
 @param corners 圆角的位置
 @param cornerRadii 每个角的半径.
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds 
                                                   byRoundingCorners:corners 
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//2.2 设置view的四个边圆角 (遮罩图层：自定义图层大小)
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii frame:(CGRect)frame
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame 
                                                   byRoundingCorners:corners 
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//2.3（同上：不用self，用view）
- (void)setCorners:(UIRectCorner)corners 
       cornerRadii:(CGSize)cornerRadii 
              view:(UIView *)view 
             frame:(CGRect)frame 
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame 
                                                   byRoundingCorners:corners 
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path  = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//等边三角形（垂直）
- (void)zm_drawTriangleStarX:(CGFloat)xx starY:(CGFloat)yy ww:(CGFloat)ww hh:(CGFloat)hh
                   fillColor:(UIColor * _Nonnull )fillColor 
                   lineWidth:(CGFloat)lineWidth 
                   lineColor:(UIColor * _Nonnull)lineColor {
    CGFloat rr= ww/2;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(xx, yy)];           // 起点
    [linePath addLineToPoint:CGPointMake(xx-rr, yy+hh)];  // 第2个点
    [linePath addLineToPoint:CGPointMake(xx+rr, yy+hh)];  // 第3个点
    [linePath addLineToPoint:CGPointMake(xx, yy)];        // 终点 == 起点
    //（使用图层填充）
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth   = lineWidth;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.fillColor   = fillColor.CGColor;
    [self.layer addSublayer:lineLayer];
}



// 清除UITableView底部多余的分割线
+ (void)zm_clearTableViewLine:(UITableView *)tabelView
                 isHeaderView:(BOOL)isHeader
                 isFooterView:(BOOL)isFooter {
    UIView *View=[UIView new];
    View.backgroundColor= [UIColor clearColor];
    if (isHeader) { [tabelView setTableHeaderView:View]; }
    if (isFooter) { [tabelView setTableFooterView:View]; }
}


/**
 *  移除所有子视图
 */
- (void)zm_removeAllSubview {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


//============================"  动画测试  "=============================


#pragma mark 导航视图 动画
- (void)zm_pushViewController:(UIViewController *)nav
{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    window.rootViewController= nav;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    //从底部滑入
    //nav.modalPresentationStyle =  UIModalPresentationFullScreen;
    [UIView commitAnimations];
}


#pragma mark 普通动画
- (void)zm_flipView:(UIView *)myView
               Rect:(CGRect)myRect
            forView:(UIView *)view
       timeInterval:(NSTimeInterval)durationTime
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:durationTime];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    myView.frame = myRect;
    [UIView commitAnimations];
    
}



// 动画 (模仿系统方法)
- (void)zm_animationDuration:(NSTimeInterval)duration animation:(void (^)(void) )animationBlock {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
    
    animationBlock();
    
    [UIView commitAnimations];
}

// 翻页动画
- (void)zm_animationDuration:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition curve:(UIViewAnimationCurve)curve animation:(void (^)(void) )animationBlock  {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:window cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    animationBlock();
    
    [UIView commitAnimations];
}

-(void)endAnimation
{
    
}
// 系统方法
- (void)aaa {
    
    //1.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 内容
    [UIView commitAnimations];
    
    
    UIView *myView=[[UIView alloc] init];
    //旋转动画：方式一
    [UIView animateWithDuration:0.05 animations:^{
        myView.transform= CGAffineTransformMakeRotation(M_PI_2);
    }];
    //旋转动画：方式二
    //创建一个CGAffineTransform  transform对象、设置旋转度数
    CGAffineTransform transform;
    transform = CGAffineTransformRotate(myView.transform,M_PI_2);
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [myView setTransform:transform];//获取transform的值
    [UIView commitAnimations];      //关闭动画
    //旋转动画：方式三
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 0.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1; //ULLONG_MAX
    [myView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    
    
    //2.
    [UIView animateWithDuration:0.3 animations:^{
        
    }];
    
    //3.
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //4. 起始时间和持续时间值在0.0和1.0之间指定时间和持续时间相对于整体的关键帧动画
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //5.
    [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //6.
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.0f initialSpringVelocity:0.0f options:0 animations:^{
        
    } completion:^(BOOL finished) {
    }];
}

/**
 *
 1.常规动画属性设置（可以同时选择多个进行设置）
 
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 
 UIViewAnimationOptionRepeat：重复运行动画。
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
 UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 
 UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 
 2.动画速度控制（可从其中选择一个设置）
 
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
 UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
 UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 
 UIViewAnimationOptionTransitionNone：没有转场动画效果。
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
 UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
 UIViewAnimationOptionTransitionCurlUp：            向后翻页的动画过渡效果。
 UIViewAnimationOptionTransitionCurlDown ：        向前翻页的动画过渡效果。
 
 UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
 UIViewAnimationOptionTransitionFlipFromTop ：  从上方翻转效果。
 UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 */


@end
