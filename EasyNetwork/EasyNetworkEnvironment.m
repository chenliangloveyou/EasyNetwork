//
//  EasyNetworkEnvironment.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkEnvironment.h"
#import "EasyNetworkOptions.h"

@implementation EasyNetworkEnvironment

- (BOOL)isOnlineEnvironment
{
    //默认加载固定的环境，但是可以切换
    return _isOnlineEnvironment ;
}

static EasyNetworkEnvironment *_environmentShare = nil ;
+ (instancetype)shareEnvironment
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _environmentShare = [[EasyNetworkEnvironment alloc] init];
        _environmentShare.isOnlineEnvironment = [EasyNetworkOptions sharedEasyNetworkOptions].defaultIsOnLine ;
    });
    return _environmentShare ;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _environmentShare = [super allocWithZone:zone];
    });
    return _environmentShare ;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _environmentShare ;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _environmentShare ;
}
@end
