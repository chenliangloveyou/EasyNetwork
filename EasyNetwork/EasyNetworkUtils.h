//
//  EasyNetworkUtils.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyNetworkUtils : NSObject
+ (NSString *)commonParametersString ;
+ (NSString *)URLString:(NSString *)orginalString appendingQueryString:(NSString *)queryString ;
+(id)dictionaryClearEmpty:(id)myObj ;

@end
