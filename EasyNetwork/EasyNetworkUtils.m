//
//  EasyNetworkUtils.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkUtils.h"
#import "EasyNetworkOptions.h"
@implementation EasyNetworkUtils

+ (NSString *)commonParametersString
{
    NSMutableDictionary *commP = [NSMutableDictionary dictionaryWithDictionary:[EasyNetworkOptions sharedEasyNetworkOptions].commonDictionary];
    if (![commP.allKeys containsObject:@"platform"]) {
        [commP setValue:@"ios" forKey:@"platform"];
    }
    return [EasyNetworkUtils urlEncodedStringWithDictionary:commP] ;
}


+ (NSString *)urlEncodedStringWithDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dictionary) {
        id value = [dictionary objectForKey: key];
        NSString *tempKey = [[NSString stringWithFormat:@"%@",key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        NSString *tempValue = [[NSString stringWithFormat:@"%@",value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (tempKey && tempValue) {
            NSString *part = [NSString stringWithFormat: @"%@=%@", tempKey, tempValue];
            
            [parts addObject: part];
        }
    }
    return [parts componentsJoinedByString:@"&"];
}

+ (NSString *)URLString:(NSString *)orginalString appendingQueryString:(NSString *)queryString
{
    if (![queryString length]) {
        return orginalString ;
    }
    return [NSString stringWithFormat:@"%@%@%@", orginalString,
            [orginalString rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
}

//将所有的NSNull类型转化成@""
+(id)dictionaryClearEmpty:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]]){
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]]){
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]]){
        return [NSString stringWithFormat:@"%@",myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]]){
        return @"" ;
    }
    return myObj;
}

+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++){
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self dictionaryClearEmpty:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i++){
        id obj = [self dictionaryClearEmpty:myArr[i]];
        [resArr addObject:obj];
    }
    return resArr;
}

@end
