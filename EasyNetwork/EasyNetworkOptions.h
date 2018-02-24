//
//  EasyNetworkOptions.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyNetworkOptions : NSObject

+ (instancetype)sharedEasyNetworkOptions ;


//用来在请求参数，添加公共的参数。这些参数会在每一个请求中都会添加进去
@property (nonatomic,strong)NSDictionary *commonDictionary ;

//放在请求的cookie中
@property (nonatomic,strong)NSDictionary *httpHeaderDictonary ;



//是否取消重复的请求，
//比如 任务A还在请求没有回调 -- 又发出任务A的请求。   是否取消前面一次的任务A请求，保留后一次的请求
@property (nonatomic,assign)BOOL cancelRepeatRequest ;

//默认是否使用线上环境
@property (nonatomic,assign)BOOL defaultIsOnLine ;

//测试地址，正式地址。
@property (nonatomic,strong)NSString *baseUrl ;
@property (nonatomic,strong)NSString *baseTestUrl ;

@end


