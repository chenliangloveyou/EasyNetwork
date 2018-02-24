//
//  EasyNetworkUtils.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWeakSelf(type)__weak typeof(type)weak##type = type;
#define kStrongSelf(type)__strong typeof(type)type = weak##type;

@interface EasyNetworkUtils : NSObject
+ (NSString *)commonParametersString ;
+ (NSString *)URLString:(NSString *)orginalString appendingQueryString:(NSString *)queryString ;
+(id)dictionaryClearEmpty:(id)myObj ;

@end
