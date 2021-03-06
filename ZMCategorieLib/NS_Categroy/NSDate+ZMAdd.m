//
//  NSDate+ZMAdd.m
//  ProjectArchitecture
//
//  Created by ZM on 2017/2/8.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "NSDate+ZMAdd.h"

@implementation NSDate (ZMAdd)
- (void)test {
    
//#pragma mark -----------------------"  获取不同格式的时间  "---------------------------------
//    // 获取当前时间 dateFormat
//    NSDate* currentDate = [NSDate date];
//    
//    NSString* dateStr11 = [NSDate dateFormatWithDate:currentDate dateFormatStatus:DFStyleMMdd];
//    NSString* dateStr22 = [NSDate dateFormatWithDate:currentDate dateFormatStatus:DFStyleYYYYMMdd];
//    NSString* dateStr33 = [NSDate dateFormatWithDate:currentDate dateFormatStatus:DFStyleHHmmss];
//    NSString* dateStr44 = [NSDate dateFormatWithDate:currentDate dateFormatStatus:DFStyleYYYYMMddHHmmss];
//    
//    NSLog(@"dateStr11 = %@ ",dateStr11);
//    NSLog(@"dateStr22 = %@ ",dateStr22);
//    NSLog(@"dateStr33 = %@ ",dateStr33);
//    NSLog(@"dateStr44 = %@ ",dateStr44);
//
//    NSDate *datenow = [NSDate date];//现在时间
//    NSLog(@"---> datenow= %@ ",datenow);
//    
//    
//    NSString *dateStr_1 = [NSDate timeIntervalWithString:@"1296035591" dateFormatStatus:DFStyleYYYYMMddHHmmss];
//    NSString *dateStr_12 = [NSDate timeIntervalWithString:@"1502953200" dateFormatStatus:DFStyleYYYYMMddHHmmss];
//    NSString *dateStr_2 = [NSDate timestampSwitchTime:1296035591 andFormatter:@"yyyy-MM-dd hh:mm:ss"];
//    NSLog(@"---> dateStr_1 = %@ \n ",dateStr_1);
//    NSLog(@"---> dateStr_12 = %@ \n ",dateStr_12);
//    NSLog(@"---> dateStr_2 = %@ \n ",dateStr_2);
//    
//    
//    //1.1、string to date
//    NSDate *myDate1 = [NSDate stringToDateWithDateStr:@"20110826134106" format:@"yyyyMMddHHmmss"];
//    NSDate *myDate2 = [NSDate stringToDateWithDateStr:@"2017-08-16 08:26:26" format:@"yyyy-MM-dd hh:mm:ss"];
//    NSLog(@"---> 1.1_1：string to date = %@",myDate1);
//    NSLog(@"---> 1.1_2：string to date = %@",myDate2);
//    //1.2、date To String
//    NSString *dateStr1 = [NSDate dateToStringWithDate:[NSDate date] format:@"yyyy-MM-dd hh:mm:ss"];
//    NSLog(@"---> 1.2：date to string = %@",dateStr1);
//    
//    //2.1、dateStr to 时间戳
//    NSString *timestampStr = [NSDate timeSwitchTimestamp:dateStr1 andFormatter:@"yyyy-MM-dd hh:mm:ss"];
//    NSLog(@"---> 2.1：dateStr to 时间戳 = %@",timestampStr);
//    //2.2时间戳 to dateStr
//    NSString *dateStr2 = [NSDate timeIntervalWithString:timestampStr dateFormatStatus:DFStyleYYYYMMddHHmmss];
//    NSString *dateStr2_2 = [NSDate timestampWithString:timestampStr format:@"yyyy-MM-dd hh:mm:ss"];
//    NSLog(@"---> 2.2_1：时间戳 to dateStr = %@ ",dateStr2);
//    NSLog(@"---> 2.2_2：时间戳 to dateStr = %@ \n ",dateStr2_2);
    
    /*
     * 注意：hh与HH的区别
     
     hh：表示12小时制
     HH：表示24小时制
     */
}



//======================="  日期和时间  "=================================

// 获取当前日期：固定格式
+(NSString*)getCurrentDateString
{
    NSDate * currentDate=[NSDate date];
    NSDateFormatter *dateFM=[[NSDateFormatter alloc]init];  // 时间格式器
    [dateFM setDateFormat:@"yyyy-MM-dd"];                   // 设置时间的格式
    NSString *getDate=[dateFM stringFromDate:currentDate];
    
    return getDate;
}
// 获取当前日期：自定义格式
+(NSString*)getCurrentDateWithFormatter:(NSString *)Formatter
{
    NSDate * currentDate=[NSDate date];
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];  // 时间格式器
    [dateFM setDateFormat:Formatter];                   // 设置时间的格式
    NSString *getDate=[dateFM stringFromDate:currentDate];
    
    return getDate;
}



/**
 date 转换为 string
 @param myDate      时间
 @param format   时间格式
 @return dateStr
 */
+ (NSString *)dateToStringWithDate:(NSDate *)myDate format:(NSString *)format{
    
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    [dateFM setDateFormat:format];
    NSString *dateStr= [dateFM stringFromDate:myDate];
    return dateStr;
}
/**
 string 转换为 date
 @param timeStr 时间字符串
 @param format 时间格式
 @return NSDate
 */
+ (NSDate *)stringToDateWithDateStr:(NSString *)timeStr format:(NSString *)format {

    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    [dateFM setLocale:[NSLocale currentLocale]];
    [dateFM setDateFormat:format];
    NSDate* date = [dateFM dateFromString:timeStr];
    return [NSDate worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}



// 获取与当前日期 相差的日期
+(NSString*)getDateSetYear:(NSInteger)year SetMonth:(NSInteger)month SetDay:(NSInteger)day
{
    //设置你需要增加或减少的年、月、日即可获得新的日期，上述的表示获取mydate日期前一个月的日期，
    //如果该成+1，则是一个月以后的日期，以此类推都可以计算。
    NSDate * currentDate = [NSDate date];
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //
    NSDateComponents *comps = nil;
    comps= [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    //
    NSDateComponents *adcomps= [[NSDateComponents alloc] init];
    [adcomps setYear:year];    //年份
    [adcomps setMonth:month];  //月份
    [adcomps setDay:day];      //日份
    NSDate *newDate= [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    // NSLog(@"--->newDate     :%@", newDate);
    NSDateFormatter *dateFM=[[NSDateFormatter alloc]init];
    [dateFM setDateFormat:@"yyyy-MM-dd"];
    NSString *getDate=[dateFM stringFromDate:newDate];
    
    return getDate;
}

// 日期间隔1天
+ (NSDate *)dateForGraphAfterDate:(NSDate *)date
{
    NSTimeInterval secondsInTwentyFourHours = 24 * 3600;
    NSDate *newDate= [date dateByAddingTimeInterval:secondsInTwentyFourHours];
    return newDate;
}
// 对时间进行格式化
/**
 *  MM/dd				 07/01
 *  yyyy-MM-dd			 2015-07-01
 *  HH:mm:ss			 17:30:40
 *  yyyy-MM-dd HH:mm:ss  2015-07-01 17:30:40
 */
+ (NSString *)dateFormatWithDate:(NSDate*)date dateFormatStatus:(DateFormatStatus)state {
    
    NSDateFormatter *df= [[NSDateFormatter alloc] init];
    // 设置时间的格式
    if (state == DFStyleMMdd) {                 df.dateFormat = @"MM/dd";
    }else if (state == DFStyleYYYYMMdd) {       df.dateFormat = @"yyyy-MM-dd";
    }else if (state == DFStyleHHmmss ) {        df.dateFormat = @"HH:mm:ss";
    }else if (state == DFStyleYYYYMMddHHmmss ) {df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSString *getDate= [df stringFromDate:date];
    return getDate;
}


///**
// * 时间戳 转换为 日期时间
// 
// @param string 时间戳
// @param state 日期时间格式
// @return 日期
// */
//+ (NSString *)timeIntervalWithString:(NSString *)string dateFormatStatus:(DateFormatStatus)state
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setLocale:[NSLocale currentLocale]];
//    // 设置时间的格式
//    if (state == DFStyleMMdd) {                 dateFormatter.dateFormat = @"MM/dd";
//    }else if (state == DFStyleYYYYMMdd) {       dateFormatter.dateFormat = @"yyyy-MM-dd";
//    }else if (state == DFStyleHHmmss ) {        dateFormatter.dateFormat = @"HH:mm:ss";
//    }else if (state == DFStyleYYYYMMddHHmmss ) {dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    }
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
//    NSString *timespStr = [dateFormatter stringFromDate:confromTimesp];
//
//    return timespStr;
//}
/**
 * 时间戳 转换为 日期时间字符串 选取不同格式：timesString --> dateString
 @param timesString 时间戳
 @param state 日期时间格式
 */
+ (NSString *)timeIntervalWithString:(NSString *)timesString dateFormatStatus:(DateFormatStatus)state
{
    NSString *format = @"";
    NSString *millisecond = @"";
    // 设置时间的格式
    if (state == DFStyleMMdd) {                     format = @"MM/dd";
    }else if (state == DFStyleYYYYMMdd) {           format = @"yyyy-MM-dd";
    }else if (state == DFStylehhmmss ) {            format = @"hh:mm:ss";
    }else if (state == DFStyleHHmmss ) {            format = @"HH:mm:ss";
    }else if (state == DFStyleYYYYMMddhhmm   ) {    format = @"yyyy-MM-dd hh:mm";
    }else if (state == DFStyleYYYYMMddHHmm   ) {    format = @"yyyy-MM-dd HH:mm";
    }else if (state == DFStyleYYYYMMddhhmmss ) {    format = @"yyyy-MM-dd hh:mm:ss";
    }else if (state == DFStyleYYYYMMddHHmmss ) {    format = @"yyyy-MM-dd HH:mm:ss";
        
    }else if (state == DFStyleYYYYMMddhhmmssSSS ) { format = @"yyyy-MM-dd hh:mm:ss.SSS";
        millisecond= [timesString substringWithRange:NSMakeRange(timesString.length-3,3)];
        timesString= [NSDate zm_deleteCharactersByEndNum:3 withString:timesString];
    }
    else if (state == DFStyleYYYYMMddHHmmssSSS ) { format = @"yyyy-MM-dd HH:mm:ss.SSS";
        millisecond= [timesString substringWithRange:NSMakeRange(timesString.length-3,3)];
        timesString= [NSDate zm_deleteCharactersByEndNum:3 withString:timesString];
    }
    
    if (timesString.length>10) {
        timesString= [NSDate zm_deleteCharactersByEndNum:3 withString:timesString];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    //设置时区
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
//    NSLog(@"---timesString= %@",timesString);
    NSDate *confromDate = [NSDate dateWithTimeIntervalSince1970:[timesString intValue]];
    NSString *dateStr = [formatter stringFromDate:confromDate];
    
    if ((state == DFStyleYYYYMMddhhmmssSSS) || (state == DFStyleYYYYMMddHHmmssSSS)) {        
        dateStr= [NSDate zm_deleteCharactersByEndNum:3 withString:dateStr];
        dateStr= [dateStr stringByAppendingString:millisecond];
    }    
    return dateStr;
}
// 同上：自定义时间格式
+ (NSString *)timestampWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置时区
    [dateFormatter setLocale:[NSLocale currentLocale]];
    // 设置时间的格式
    [dateFormatter setDateFormat:format];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
    NSString *timespStr = [dateFormatter stringFromDate:confromTimesp];
    return timespStr;
}
// 从最后一位开始删除：num 删除的位数
+ (NSString *)zm_deleteCharactersByEndNum:(int)num withString:(NSString *)myStr {
    NSMutableString* mutStr= [[NSMutableString alloc] initWithString:myStr];
    if (mutStr.length < num) {
        return nil;
    }
    [mutStr deleteCharactersInRange:NSMakeRange(mutStr.length-num,num)];
    return mutStr;
}



/**
 时间戳 转换为 日期时间
 
 @param timestamp 时间戳：例如 1296035591、1502926804
 @param format    设置你想要的格式//（@"yyyy-MM-dd hh:mm:ss"）-,hh与HH的区别:分别表示12小时制,24小时制
 @return 日期
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    //设置时区
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromDate = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSString *dateStr = [formatter stringFromDate:confromDate];
    return dateStr;
}

/**
 将某个时间转化成 时间戳
 @param formatTime 时间字符串
 @param format 时间格式
 @return 时间戳
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //将字符串按formatter转成NSDate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}



//--设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制  yyyy-MM-dd HH:mm:ss SSS
//获取当前时间戳：需要设置时间格式
+ (NSString *)timeSwitchTimestampFormatter:(NSString *)format {
    
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    [dateFM setDateFormat:format];
    NSString *dateStr= [dateFM stringFromDate:[NSDate date]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:dateStr]; //将字符串按formatter转成NSDate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}
//获取当前时间戳
+ (NSString *)getNowTimestamp {
        
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a= [dat timeIntervalSince1970];
    NSString*timeSP = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeSP;
}
//获取当前时间戳：(以秒为单位)
+ (NSString *)getNowTimestampOfSecond {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *dateNow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSP = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];
    return timeSP;
}
//获取当前时间戳：(以毫秒为单位）
+ (NSString *)getNowTimestampOfMillisecond {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSS"];  //yyyy-MM-dd HH:mm:ss.SSSS 或 YYYYMMddHHmmssSSSS
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *timeSP = [NSString stringWithFormat:@"%llu",theTime];
    return timeSP;
}

//平年与闰年 每月的天数计算
+ (NSInteger)daysCountOfMonth:(NSInteger)month andYear:(NSInteger)year {
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12)){
        return 31;
    }
    if((month == 4)||(month == 6)||(month == 9)||(month == 11)){
        return 30;
    }
    if(year%4==0 && year%100!=0){
        //普通年份，非100整数倍
        return 29;
    }
    if(year%400 == 0){
        //世纪年份
        return 29;
    }
    return 28;
    
}
    
/**
 * 获取每月的_日期数组
 
 @param yyyy 年份
 @param mm 月份
 @param formatter 日期格式
 @return 日期数组
 */
+ (NSMutableArray *)monthDayArrayWithYear:(NSString *)yyyy month:(NSString *)mm mmDDFormatter:(MonthDayFormatStatus)formatter {
    
    NSMutableArray *_dayArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger maxDay = 31;
    maxDay = [self dayNumWithYear:yyyy month:mm];
    //NSLog(@"---> maxDay = %ld",(long)maxDay);
    
    for (NSInteger i = 1; i <= maxDay; i++) {
        
        //NSLog(@"---> i = %ld",i);
        if (formatter == MMddStyle_AA) {
            // MM/dd
            [_dayArray addObject:[NSString stringWithFormat:@"%@/%ld",mm,(long)i]];
            
        }else if (formatter == MMddStyle_BB) {
            // MM-dd
            [_dayArray addObject:[NSString stringWithFormat:@"%@-%ld",mm,(long)i]];
            
        }else if (formatter == MMddStyle_CC ) {
            // MM.dd
            [_dayArray addObject:[NSString stringWithFormat:@"%@.%ld",mm,(long)i]];
        }
    }
    return _dayArray;
}


/**
 * 获取每月的天数_数组
 
 @param yyyy 年份
 @param mm 月份
 @return 天数_数组
 */
+ (NSMutableArray *)dayArrayWithYear:(NSString *)yyyy month:(NSString *)mm {
    
    NSMutableArray *_dayArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger maxDay = 31;
    maxDay = [self dayNumWithYear:yyyy month:mm];
    
    for (NSInteger i = 1; i < maxDay; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    return _dayArray;
}

/**
 * 获取每月的天数_数组
 
 @param yyyy 年份
 @param mm 月份
 @param isAddZero 日期小于10的，前置添加一个0
 @return 天数_数组
 */
+ (NSMutableArray *)dayArrayWithYear:(NSString *)yyyy month:(NSString *)mm isAddZero:(BOOL)isAddZero {
    
    NSMutableArray *_dayArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger maxDay = 31;
    maxDay = [self dayNumWithYear:yyyy month:mm];
    
    for (NSInteger i = 1; i < maxDay+1; i++) {
        
        if (isAddZero) {
            if (i<10) {
                [_dayArray addObject:[NSString stringWithFormat:@"0%ld",(long)i]];
            }else{
                [_dayArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
            }
        }else{
            [_dayArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return _dayArray;
}


/**
 * 获取每月的天数_个数
 
 @param yyyy 年份
 @param mm 月份
 @return 天数
 */
+ (NSInteger )dayNumWithYear:(NSString *)yyyy month:(NSString *)mm {
    
    NSInteger year = [yyyy integerValue];
    NSInteger month = [mm integerValue];
    NSInteger maxDay = 31;
    
    //    NSLog(@"--> year = %ld",year);
    //    NSLog(@"--> month = %ld \n ",month);
    
    if (year % 400 == 0 && month == 2) {
        maxDay = 29;
    } else if ((year % 100 != 0) && (year % 4 == 0) && month == 2){
        maxDay = 29;
    } else if (month == 2){
        maxDay = 28;
    } else if ((month % 2 != 0 && month < 8) || month == 8 || (month % 2 == 0 && month > 8)){
        maxDay = 31;
    } else {
        maxDay = 30;
    }
    return maxDay;
}




// 1.保存时间: 当前时间、24小时后的时间
+(void)createCurrentDateAndOneDay
{
    //NSDate生成:
//    NSDate *date1 = [NSDate date];
//    NSDate *date2 = [[NSDate alloc] initWithTimeIntervalSinceNow:24*3600];
    //    NSLog(@"---> date1：%@",date1);
    //    NSLog(@"---> date2：%@ \n ",date2);
//    [UserDefaults zm_setObject:date1 forKey:@"date1"];
//    [UserDefaults zm_setObject:date2 forKey:@"date2"];
}


// 2.判断时间大小、相同
+(NSString*)compareOneDay:(NSDate *)Date1 withAnotherDay:(NSDate *)Date2
{
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    [dateFM setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date11 = [dateFM stringFromDate:Date1];//date   To  string
    NSString *date22 = [dateFM stringFromDate:Date2];
    
    NSDate *dateA = [dateFM dateFromString:date11];  //string To  date
    NSDate *dateB = [dateFM dateFromString:date22];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedAscending){
        return @"-1";   //dateA 是过去的时间
    }
    else if (result == NSOrderedDescending) {
        return @"+1";   //dateA 是未来的时间
    }
    return @"0";        // 两者时间相同
}
// 3.判断：时间是否相同
+(BOOL)isEqualDate1:(NSDate *)Date1 WithDate2:(NSDate *)Date2
{
    if ([Date1 isEqualToDate: Date2]) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)zm_calculateTime:(NSString *)publishTime {
    //2.1、dateStr to 时间戳
//    NSString *publishTimestamp = [NSDate timeSwitchTimestamp:publishTime andFormatter:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *publishTimestamp = [NSDate timeIntervalWithString:publishTime dateFormatStatus:DFStyleYYYYMMddHHmmssSSS];
//    NSLog(@"---publishTimestamp= %@",publishTimestamp);
    
//    NSLog(@"---publishTime= %@",publishTime);
    NSString *currentTimesTamp = [NSDate getNowTimestampOfSecond];
    if (publishTime.length>10) {
        publishTime = [self zm_deleteCharactersByEndNum:3 originString:publishTime];
    }
    long long publishtimes = [publishTime longLongValue];
    long long currenttimes = [currentTimesTamp longLongValue];
    long long  gap = currenttimes - publishtimes;
//    NSLog(@"---publishtimes= %lld",publishtimes);
//    NSLog(@"---currenttimes= %lld",currenttimes);
//    NSLog(@"---gap= %lld \n",gap);

    if (gap>0) {
        long minute = gap/60;
        long hour   = gap/3600;
        long day    = gap/3600/24;
        if (minute < 60) {
            return [NSString stringWithFormat:@"%ld 分钟前",minute];
        }else if (hour < 24) {
            return [NSString stringWithFormat:@"%ld 小时前",hour];
        }else if (day < 7) {
            return [NSString stringWithFormat:@"%ld 天前",day];
        }else{
//            return  publishTime;
            return [NSDate timeIntervalWithString:publishTime dateFormatStatus:DFStyleYYYYMMddHHmm];
        }
    }else{
//        return  publishTime;
        return [NSDate timeIntervalWithString:publishTime dateFormatStatus:DFStyleYYYYMMddHHmm];
    }
}
// 从最后一位开始删除：num 删除的位数
+ (NSString *)zm_deleteCharactersByEndNum:(int)num originString:(NSString *)originString
{
    NSMutableString* mutStr= [[NSMutableString alloc] initWithString:originString];
    if (mutStr.length < num) {
        return nil;
    }
    [mutStr deleteCharactersInRange:NSMakeRange(mutStr.length-num,num)];
    return mutStr;
}


@end
