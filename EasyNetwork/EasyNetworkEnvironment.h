//
//  EasyNetworkEnvironment.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyNetworkEnvironment : NSObject

+ (instancetype)shareEnvironment ;

@property (nonatomic,assign)BOOL isOnlineEnvironment ;
@end
