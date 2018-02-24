//
//  EasyNetwork.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

//单个请求 ， 多个请求，栏栅请求，串行请求。
//读取本地缓存
//需要添加缓存过滤条件。
//缓存的版本
//打印分waring 错误，请求，返回。 还可以在logUtils里更改
//可以延时请求,延时请求的时间可以设置
//每一个请求都有一个tag，创建的时候就返回的。
//任务2有一个参数是任务3的参数，所以
// 任务1                     任务5
// 任务2  ----> 任务4  ---->
// 任务3                     任务6

// 任务1  ----> 任务2  ----> 任务3

// 任务1
// 任务2
// 任务3

//请求类的开始请求要分开。  可以直接开始请求，也可以先创建，之后再发请求
// 所以有一个request类，有一个
//判断有没有同一个请求，如果有的话可以选择取消之前的请求。条件：地址和参数必须全部相同。
//可以自定义是否解析数据。判断条件就是是否传入解析类。


#import "EasyNetworkError.h"

#import "EasyNetworkRequest.h"
#import "EasyNetworkResponse.h"
@class EasyNetworkResponse ;
@class EasyNetwork ;

typedef void (^EasyNetworkCallback) (EasyNetwork *network , EasyNetworkResponse *response);

@protocol NetworkToolProtocol <NSObject>

- (void)getEasyNetworkFinish:(EasyNetwork *)network
                    response:(EasyNetworkResponse *)response ;
@end


@interface EasyNetwork : NSObject

/**
 * 初始化方法，当需要调用对象方法发请求的时候使用
 */
- (instancetype)initWithDelegate:(id<NetworkToolProtocol>)delegate ;

/**
 * 对象方法 post请求(需要调用startrequest)
 * path       请求路径
 * parameters 请求参数
 * parseClass 数据解析model(为nil的时候，不会解析数据)
 * 结果都会在代理中回调
 */
- (EasyNetworkRequest *)postNetworkToolWithPath:(NSString*)path
                                     parameters:(NSDictionary*)parameters
                                     parseClass:(Class)parseClass ;


/**
 * 类方法 post请求
 * path       请求路径
 * parameters 请求参数
 * parseClass 数据解析model(为nil的时候，不会解析数据)
 * callback   数据回调
 */
+ (void)postEasyNetworkWithPath:(NSString*)path
                     parameters:(NSDictionary*)parameters
                     parseClass:(Class)parseClass
                       callback:(EasyNetworkCallback)callback ;



//取消所有请求
- (void)cancelEasyNetworkAllRequest ;



@end










