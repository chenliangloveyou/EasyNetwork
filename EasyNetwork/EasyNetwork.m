//
//  EasyNetwork.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetwork.h"
#import "EasyNetworkEnvironment.h"
#import "EasyNetworkClient.h"
#import "EasyNetworkOptions.h"
#import "EasyNetworkUtils.h"
#import "EasyNetworkRequestQueue.h"
#import "EasyNetworkResponse.h"


@interface EasyNetwork()

@property (nonatomic,weak)id<NetworkToolProtocol> delegate ;
@property (nonatomic,strong)Class analyzeClass ;
@property (nonatomic,copy)EasyNetworkCallback networkCallback ;

@end

@implementation EasyNetwork

- (instancetype)initWithDelegate:(id<NetworkToolProtocol>)delegate
{
    if (self = [super init]) {
        self.delegate = delegate ;
    }
    return self ;
}


- (EasyNetworkRequest *)postNetworkToolWithPath:(NSString *)path
                                     parameters:(NSDictionary *)parameters
                                     parseClass:(Class)parseClass
{
    if (![parseClass isKindOfClass:[NSNull class]] && parseClass != Nil) {
        self.analyzeClass = parseClass;
    }
    return [self AFNetworkingRequestWithPath:path
                                   parameter:parameters
                                  MethodType:EasyRequestMethodPost];
}

+ (void)postEasyNetworkWithPath:(NSString *)path
                     parameters:(NSDictionary *)parameters
                     parseClass:(Class)parseClass
                       callback:(EasyNetworkCallback)callback
{
    EasyNetwork *tempNetworkTool = [[EasyNetwork alloc]init] ;
    tempNetworkTool.networkCallback = callback ;
    tempNetworkTool.analyzeClass = parseClass;
    EasyNetworkRequest *request = [tempNetworkTool AFNetworkingRequestWithPath:path
                                                                     parameter:parameters
                                                                    MethodType:EasyRequestMethodPost];
    [request startRequest];
}


//取消所有请求
- (void)cancelEasyNetworkAllRequest
{
    for (EasyNetworkRequest *request in [EasyNetworkRequestQueue shareEasyNetworkRequestQueue].requestArray) {
        [request cancelRequest];
    }
}

#pragma mark - private

- (EasyNetworkRequest *)AFNetworkingRequestWithPath:(NSString *)path
                                          parameter:(NSDictionary *)parameter
                                         MethodType:(EasyRequestMethod)methodType
{
    
    NSString *commonParameters = [EasyNetworkUtils commonParametersString] ;
    NSString *newPath = [EasyNetworkUtils URLString:path appendingQueryString:commonParameters];
    
    kWeakSelf(self)
    EasyNetworkRequestCallback tempCallback = [self analyzeDataWithSelf:weakself] ;
    EasyNetworkRequest *request = [EasyNetworkRequest easyNetworkRequestWithPath:newPath parameters:parameter callback:tempCallback];
    request.EasyRequestMethod = methodType ;
    
    //将请求添加到请求队列
    [[EasyNetworkRequestQueue shareEasyNetworkRequestQueue] addEasyNetworkRequest:request];
    
    return request ;
}


- (EasyNetworkRequestCallback)analyzeDataWithSelf:(id)weakSelf
{
    kWeakSelf(self)
    return ^(EasyNetworkRequest *request , NSURLResponse *response, id responseData , EasyNetworkError *error){
        
        //将请求从请求队列中删除
        [[EasyNetworkRequestQueue shareEasyNetworkRequestQueue] removeEasyNetworkRequest:request];
        
        //解析数据
        EasyNetworkResponse *tempResponse = [EasyNetworkResponse networkResponseWithRequest:request
                                                                                   response:response
                                                                               responseData:responseData
                                                                                 parseClass:weakself.analyzeClass
                                                                                      error:error];
        
        //通知代理
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(getEasyNetworkFinish:response:)]) {
            [weakself.delegate getEasyNetworkFinish:weakSelf response:tempResponse];
        }
        //回调block
        if (weakself.networkCallback) {
            weakself.networkCallback(weakSelf, tempResponse);
            weakself.networkCallback = nil ;
        }
        
    };
}



@end
