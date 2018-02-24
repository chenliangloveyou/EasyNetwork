//
//  EasyNetworkOptions.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkOptions.h"

@implementation EasyNetworkOptions


static EasyNetworkOptions *_showInstance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showInstance = [super allocWithZone:zone];
    });
    return _showInstance;
}
+ (instancetype)sharedEasyNetworkOptions{
    if (nil == _showInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _showInstance = [[[self class] alloc] init];
        });
    }
    return _showInstance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _showInstance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _showInstance;
}


- (instancetype)init
{
    if (self = [super init]) {
        _cancelRepeatRequest = YES ;
        _defaultIsOnLine = YES ;
    }
    return self ;
}
@end
