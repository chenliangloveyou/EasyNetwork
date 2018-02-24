//
//  EasyNetworkRequest.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyNetworkError.h"

typedef NS_ENUM(NSInteger,EasyRequestPriority) {
    EasyRequestPriorityDefault ,//默认
    EasyRequestPriorityHeight ,
    EasyRequestPriorityLow ,
};
typedef NS_ENUM(NSInteger,EasyRequestMethod) {
    EasyRequestMethodGet = 1 ,
    EasyRequestMethodPost ,
    EasyRequestMethodDelete ,
    EasyRequestMethodHead ,
    EasyRequestMethodPatch,
    EasyRequestMethodPut
};

@class EasyNetworkRequest ;

typedef void (^EasyNetworkRequestCallback) (EasyNetworkRequest *request , NSURLResponse *response, id responseData , EasyNetworkError *error);
typedef void (^EasyNetWorkRequestProgress) (EasyNetworkRequest *request , NSProgress *progress);

@interface EasyNetworkRequest : NSObject

//创建一个请求
+ (instancetype)easyNetworkRequestWithPath:(NSString *)path
                                parameters:(NSDictionary *)parameters
                                  callback:(EasyNetworkRequestCallback)callback ;

//开始请求(delayTime:延迟时间)
- (void)startRequest ;
- (void)startRequestWithDelay:(CGFloat)delayTime ;
//停止请求(如果需要再次请求，请调用startrequest)
- (void)stopRequest ;
//取消请求(delayTime:延迟时间)
- (void)cancelRequest ;
- (void)cancelRequestWithDelay:(CGFloat)delayTime ;

//请求地址
@property (nonatomic,strong,readonly)NSString *requestPath ;
//请求参数
@property (nonatomic,strong,readonly)NSDictionary *requestparameters ;
//请求唯一标示
@property (nonatomic,assign,readonly)NSUInteger requestTag ;
//请求的任务
@property (nonatomic,strong,readonly)NSURLSessionTask *requestTask ;

//设置请求的优先级
@property (nonatomic,assign)EasyRequestPriority EasyRequestPriority ;

//设置请求方式 (通用为post，get)
@property (nonatomic,assign)EasyRequestMethod EasyRequestMethod ;

//设置此次请求超时时长 默认:60
@property (nonatomic,assign)CGFloat EasyRequestTimeoutInterval ;

//获取请求上传的进度
@property (nonatomic,strong)EasyNetWorkRequestProgress requestUploadProgress ;
//获取请求下载的进度
@property (nonatomic,strong)EasyNetWorkRequestProgress requestDownloadProgress ;


@end








