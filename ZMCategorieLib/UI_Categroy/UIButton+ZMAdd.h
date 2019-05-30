//
//  UIButton+ZMAdd.h
//  Architecture
//
//  Created by ZM on 2016/10/25.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock) (void);
typedef void (^IntBlock) (int);
typedef NSString* _Nonnull (^StrBlock) (NSString *_Nonnull);
typedef void (^ClickActionBlock) (id _Nonnull obj);

// 枚举三
typedef NS_ENUM(NSInteger,CourseStatus) {
    status1 =   101,
    status2 =   102,
    status3 =   103,
    status4 =   104,
    status5 =   105,
};

@interface UIButton (ZMAdd)

/**
 * 课程状态
 */
@property(nonatomic, assign)CourseStatus courseStatus;
/**
 *  点击按钮回调
 */
@property(nonatomic, strong)ButtonBlock _Nonnull BtnBlock;

- (void)addEventHandler:(ClickActionBlock _Nonnull )clickBlock forControlEvents:(UIControlEvents)event;

// UIButton：添加下划线
- (void)zm_addUnderline;
// UIButton：给一段文本，添加下划线、改变颜色
+ (void)zm_changeButton:(UIButton *_Nonnull)myBtn withText:(NSString *_Nonnull)text color:(UIColor *_Nonnull)myColor addUnderline:(BOOL)addline;
// UIButton：给一段文本，添加下划线、改变颜色
//- (void)zm_changeBtnText:(NSString *)text color:(UIColor *)myColor;
- (void)zm_changeBtnText:(nonnull NSString *)text color:(nonnull UIColor *)myColor font:(nonnull UIFont *)font;


// 改变UIButton的文本的 两种以上颜色及字体
+ (void)zm_changeTextBtn:(UIButton *_Nonnull)myBtn
             stringArray:(NSArray *_Nonnull)strArray
           colorArray:(NSArray *_Nonnull)colorArray
            fontArray:(NSArray *_Nonnull)fontArray;



@end
