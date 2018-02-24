//
//  EasyNetworkRequest.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkRequest.h"

#import "AFNetworking.h"
#import "EasyNetworkClient.h"
#import "EasyNetworkUtils.h"
#import "EasyNetworkOptions.h"

static int easynetwork_request_tag = 1 ; //网络请求的tag

@interface EasyNetworkRequest()

@property (nonatomic,strong)NSURLSessionTask *requestTask ;
@property (nonatomic,strong)EasyNetworkRequestCallback callback ;

@end

@implementation EasyNetworkRequest

+ (instancetype)easyNetworkRequestWithPath:(NSString *)path
                                parameters:(NSDictionary *)parameters
                                  callback:(EasyNetworkRequestCallback)callback
{
    EasyNetworkRequest *request = [[EasyNetworkRequest alloc]init];
    request->_requestPath = path ;
    request->_requestparameters = parameters ;
    request->_requestTag = ++easynetwork_request_tag ;
    request.callback = callback ;
    return request ;
}

- (NSMutableURLRequest *)requestWithError:(NSError *__autoreleasing *)error
{
    NSString *methodName = [self requestMethodName];
    NSString *requestURL = [[NSURL URLWithString:_requestPath relativeToURL:[EasyNetworkClient shareClient].baseURL] absoluteString] ;
    AFHTTPRequestSerializer *serializer = [EasyNetworkRequest getNetworkClient].requestSerializer ;
    serializer.timeoutInterval = self.EasyRequestTimeoutInterval<=0 ? 60 : self.EasyRequestTimeoutInterval ;
    NSMutableURLRequest *request = [serializer requestWithMethod:methodName
                                                       URLString:requestURL
                                                      parameters:_requestparameters
                                                           error:error];
    return request ;
}
- (NSURLSessionTask *)requestTask
{
    if (nil == _requestTask) {
        
        NSError * __autoreleasing requestError = nil;
        NSMutableURLRequest *request = [self requestWithError:&requestError];
        //如果有错误发生，则不能创建request，报错
        if (requestError) {
            EasyNetworkError *tempError = [EasyNetworkError networkToolError:requestError code:NetworkErrorCodeRequestError];
            if (self.callback) {
                self.callback(self,nil,nil, tempError );
                self.callback = nil ;
            }
            return nil ;
        }
        kWeakSelf(self)
        _requestTask = [[EasyNetworkClient shareClient] dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            if (weakself.requestUploadProgress) {
                weakself.requestUploadProgress(weakself, uploadProgress);
            }
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            if (weakself.requestDownloadProgress) {
                weakself.requestDownloadProgress(weakself, downloadProgress);
            }
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                        
            EasyNetworkError *tempError = nil ;
            if (error) {
                tempError = [EasyNetworkError networkToolError:error code:NetworkErrorCodeResponseError];
            }
            if (weakself.callback) {
                weakself.callback(self,response, responseObject, tempError);
                weakself.callback = nil ;
            }
        }];
        
        if (self.EasyRequestPriority == EasyRequestPriorityLow) {
            _requestTask.priority = NSURLSessionTaskPriorityLow ;
        }else if (self.EasyRequestPriority == EasyRequestPriorityHeight){
            _requestTask.priority = NSURLSessionTaskPriorityHigh ;
        }
    }
    return _requestTask ;
}

- (void)startRequest
{
    if (self.requestTask.state != NSURLSessionTaskStateRunning ) {
        [self.requestTask resume];
    }
}
- (void)startRequestWithDelay:(float)delayTime
{
    if (delayTime <= 0) {
        [self startRequest];
        return ;
    }
    [self performSelector:@selector(startRequest) withObject:nil afterDelay:delayTime];
}
- (void)stopRequest
{
    [self.requestTask suspend];
}
- (void)cancelRequest
{
    if (self.requestTask.state != NSURLSessionTaskStateCanceling ) {
        [self.requestTask cancel];
    }
}
- (void)cancelRequestWithDelay:(float)delayTime
{
    if (delayTime <= 0) {
        [self cancelRequest];
        return ;
    }
    [self performSelector:@selector(cancelRequest) withObject:nil afterDelay:delayTime];

}
//请求方法的名称
- (NSString *)requestMethodName
{
    NSString *tempMethodName = @"POST" ;
    switch (self.EasyRequestMethod) {
        case EasyRequestMethodGet:    tempMethodName = @"GET"; break;
        case EasyRequestMethodPost:   tempMethodName = @"POST"; break;
        case EasyRequestMethodDelete: tempMethodName = @"DELETE"; break;
        case EasyRequestMethodPut:    tempMethodName = @"PUT"; break;
        case EasyRequestMethodHead:   tempMethodName = @"HEAD"; break;
        case EasyRequestMethodPatch:  tempMethodName = @"PATCH"; break;
        default: break;
    }
    return tempMethodName ;
}

+ (EasyNetworkClient *)getNetworkClient
{
    EasyNetworkClient *client = [EasyNetworkClient shareClient];
    NSDictionary *tempDictionary = [EasyNetworkOptions sharedEasyNetworkOptions].httpHeaderDictonary ;
    if (tempDictionary.count) {
        for (NSString *tempKey in tempDictionary) {
            NSString *tempValue = [tempDictionary objectForKey:tempKey];
            if (tempKey.length && tempValue.length) {
                [client.requestSerializer setValue:tempValue forHTTPHeaderField:tempKey];
            }
        }
    }
    return client;
}

@end
