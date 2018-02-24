//
//  EasyNetworkEnvironment.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyNetworkEnvironment : NSObject

/**
 * 单例
 */
+ (instancetype)shareEnvironment ;

/**
 * 是否在线上环境
 */
 @property BOOL isOnlineEnvironment ;

/**
 * 切换环境
 * return 是否在线上环境
 */
- (BOOL)switchEnvironment ;

@end
