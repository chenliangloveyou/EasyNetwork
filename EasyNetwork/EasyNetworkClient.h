//
//  EasyNetworkClient.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface EasyNetworkClient : AFHTTPSessionManager

+ (instancetype)shareClient ;

@end
