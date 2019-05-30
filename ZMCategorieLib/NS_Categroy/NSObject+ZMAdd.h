//
//  NSObject+ZMAdd.h
//  ZMArchitecture
//
//  Created by ZM on 16/5/12.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZMAdd)
{

}
/**
 *  获取属性列表
 */
- (NSArray *)zm_propertyNameList;
/**
 *  获取方法列表
 */
- (NSArray *)zm_methodNameList;
/**
 *  获取成员变量列表：数组
 */
- (NSArray *)zm_ivarNameList;
/**
 *  获取成员变量列表：字典
 */
- (NSDictionary *)zm_ivarDic;

/**
 *  字典转模型方法
 */
+ (instancetype)zm_objectWithDict:(NSDictionary *)dict;
#pragma mark ---把一个model的值赋 给另一个model
+ (void)zm_setTargetModel:(NSObject *)targetModel fromModel:(NSObject *)model;

// 返回类的属性列表
- (NSArray *)zm_propertyList;
+ (NSArray *)zm_propertyList;

- (BOOL)zm_isNotEmptyObject;
+ (BOOL)zm_isNotEmptyObject:(id)object;

- (BOOL)zm_isEmptyObject;
+ (BOOL)zm_isEmptyObject:(id)object;

// 空数据转换：id
- (id)zm_convertNullToObject;
// 空数据转换：NSString
- (NSString *)zm_convertNullToString:(NSString *)object;
// 空数据转换：NSDictionary
- (NSDictionary *)zm_convertNullToDictionary:(NSDictionary *)object;
// 空数据转换：NSArray
- (NSArray *)zm_convertNullToArray:(NSArray *)object;


@end
