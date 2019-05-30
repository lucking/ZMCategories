//
//  NSArray+ZMAdd.m
//  ProjectArchitecture
//
//  Created by ZM on 2017/2/23.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "NSArray+ZMAdd.h"
#import <UIKit/UIKit.h>

@implementation NSArray (ZMAdd)


//1、valueForKeyPath可以获取数组中的最小值、最大值、平均值、求和。代码如下：
- (NSString *)caculateArray:(NSArray *)array
{
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
    NSLog(@"sum=%fn、avg=%fn、max=%fn、min=%f",sum,avg,max,min);
    return [NSString stringWithFormat:@"%f",sum];
}


//数组中是否包含 某个元素
- (BOOL)isContainString:(NSString *)myStr {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", myStr];
    NSArray *results = [self filteredArrayUsingPredicate:predicate];
    
    if (results.count > 0) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isContainObject:(id)obj {
    if ([self containsObject:obj]) {
        return YES;
    }else{
        return NO;
    }
}

// CFArray的二分查找方法
- (void)sort11 {
    
    //必须是有序的 表
    NSMutableArray *sortedArray = [NSMutableArray arrayWithObjects:
                                   @"Alice",
                                   @"Beth",
                                   @"Carol",
                                   @"Ellen",nil];
    //查找 位置
    id _searchObject = @"Beth";
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)sortedArray,
                                                    CFRangeMake(0, CFArrayGetCount((CFArrayRef)sortedArray)),
                                                    (CFStringRef)_searchObject,
                                                    (CFComparatorFunction)CFStringCompare,
                                                    NULL);
    if (index < [sortedArray count] && [_searchObject isEqualToString:sortedArray[index]])
    {
        NSLog(@"Beth 索引 at index = %u", index);
    } else {
        NSLog(@"Beth 不存在");
    }
    //有序的插入
    id _insertObject = @"Debra";
    
    unsigned insertIndex = (unsigned)CFArrayBSearchValues((CFArrayRef)sortedArray,
                                                          CFRangeMake(0, CFArrayGetCount((CFArrayRef)sortedArray)),
                                                          (CFStringRef)_insertObject,
                                                          (CFComparatorFunction)CFStringCompare,
                                                          NULL);
    //插入
    [sortedArray insertObject:_insertObject atIndex:insertIndex];
    NSLog(@"---> sortedArray = %@",sortedArray);
}
// NSArray的二分查找方法
- (void)sort22 {
    
    NSArray *sortedArray = @[@"Alice",
                             @"Beth",
                             @"Carol",
                             @"Ellen"]; // must be sorted
    id searchObject = @"Carol";
    NSRange searchRange = NSMakeRange(0, [sortedArray count]);
    //查找 位置
    NSUInteger findIndex = [sortedArray indexOfObject:searchObject
                                        inSortedRange:searchRange
                                              options:NSBinarySearchingFirstEqual
                                      usingComparator:^(id obj1, id obj2)
                            {
                                return [obj1 compare:obj2];
                            }];
    NSLog(@"---> NSArray的二分查找方法_findIndex_位置_22 = %ld \n ",findIndex);
}

// 自己编写二分查找算法
- (void)sort33 {
    
    // Conceptual tutorial
    NSArray *numberArray = @[@1, @3, @27, @36, @42, @70, @82];
    NSNumber *searchNum = @70;
    NSUInteger mid;
    NSUInteger min = 0;
    NSUInteger max = [numberArray count] - 1;
    BOOL found = NO;
    while (min <= max) {
        
        mid = (min + max)/2;
        
        if ([searchNum intValue] == [numberArray[mid] intValue]) {
            NSLog(@"---> 要找的数据位置在 index =  %lu \n ", mid);
            found = YES;
            break;
            
        } else if ([searchNum intValue] < [numberArray[mid] intValue]) {
            max = mid - 1;
            
        } else if ([searchNum intValue] > [numberArray[mid] intValue]) {
            min = mid + 1;
        }
    }
    if (!found) {
        NSLog(@"---> 没找到此数据");
    }
}


- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *mustr = [NSMutableString string];
    [mustr appendString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.count -1) {
            [ mustr appendFormat:@"\t%@,\n",obj];
        }else{
            [ mustr appendFormat:@"\t%@\n",obj];
        }
    }];
    [mustr appendString:@")"];
    return mustr;
}



#pragma mark  ======================="  Function  "=================================

#pragma 第一种 
//排序方法：利用数组的sortedArrayUsingComparator调用 NSComparator ，obj1和obj2指的数组中的对象
NSComparator cmptor_Function = ^(id obj1, id obj2){
    
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending; //递减
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;  //递升
    }
    return (NSComparisonResult)NSOrderedSame;			//相同
};

#pragma 第二种 
//排序方法：利用sortedArrayUsingFunction 调用 对应方法customSort，这个方法中的obj1和obj2分别是指数组中的对象

NSInteger IntSort_Function (id obj1, id obj2,void* context) { // NSInteger (*)(ObjectType, ObjectType, void * __nullable)
    
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};



//方法一： 从小到大
/**
 *  从小到大：利用sortedArrayUsingComparator
 *
 *  @return mutArray
 */
+ (NSArray *)sortedArrayUseComparator:(NSArray *)myArray {
    
    NSArray *array = [myArray sortedArrayUsingComparator:cmptor_Function]; //排序
    
    NSMutableArray* mutArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [mutArray addObject:obj];
    }];
    return mutArray;
}
//方法二：从小到大
/**
 *  利用sortedArrayUsingFunction
 *
 *  @return mutArray
 */
+ (NSArray *)sortedArrayUseFunction:(NSArray *)myArray
{
    NSArray *array = [myArray sortedArrayUsingFunction:IntSort_Function context:nil]; //排序
    
    NSMutableArray* mutArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [mutArray addObject:obj];
    }];
    return mutArray;
}
// 利用属性排序
/**
 *  利用sortUsingDescriptors调用 NSSortDescriptor
 *
 *  其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
 *
 *	ascending: YES（递升）  NO（递减）
 *
 *  @return Array
 */
+ (NSArray *)sortedArrayUseDescriptor:(NSArray *)myArray sortWithKey:(NSString *)myKey
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray *afterArray = [myArray sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"--->排序后_afterArray = %@",afterArray);
    return afterArray;
    // NSArray *sortDescript = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
}


//=========================="    "=================================

-(void)selectSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i=0; i<[data count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[data count]; j++) {
            if ([data objectAtIndex:j] < [data objectAtIndex:m]) {
                m = j;
            }
        }
        if (m != i) {
            [self swapWithData:data index1:m index2:i];
        }
    }
    NSLog(@"选择排序后的结果：%@",[data description]);
    //	[data release];
}

-(void)insertSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i = 1; i < [data count]; i++) {
        id tmp = [data objectAtIndex:i];
        int j = i-1;
        while (j != -1 && [data objectAtIndex:j] > tmp) {
            [data replaceObjectAtIndex:j+1 withObject:[data objectAtIndex:j]];
            j--;
        }
        [data replaceObjectAtIndex:j+1 withObject:tmp];
    }
    NSLog(@"插入排序后的结果：%@",[data description]);
    //	[data release];
}

-(void)quickSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc] initWithArray:aData];
    [self quickSortWithArray:data left:0 right:[aData count]-1];
    NSLog(@"快速排序后的结果：%@",[data description]);
    //	[data release];
    
}

-(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right{
    if (right > left) {
        NSInteger i = left;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [aData objectAtIndex:++i] < [aData objectAtIndex:left]) ;
            while (j-1 > -1 && [aData objectAtIndex:--j] > [aData objectAtIndex:left]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1];
        [self quickSortWithArray:aData left:j+1 right:right];
    }
}

-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}


@end
