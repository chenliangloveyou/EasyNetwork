//
//  EasyNetworkResponse.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkResponse.h"
#import "EasyNetworkRequest.h"
#import "EasyNetworkUtils.h"
#import "BaseResponse.h"

@implementation EasyNetworkResponse

+ (instancetype)networkResponseWithRequest:(EasyNetworkRequest *)request
                                  response:(NSURLResponse *)response
                              responseData:(id)responseData
                                parseClass:(Class)parseClass
                                     error:(EasyNetworkError *)error
{
   
    EasyNetworkResponse *resultResponse = [[EasyNetworkResponse alloc]init];
    resultResponse.request = request ;
    resultResponse.URLResponse = (NSHTTPURLResponse *)response ;
    resultResponse.responseCode = resultResponse.URLResponse.statusCode ;
    resultResponse.orginalData = responseData ;
    
    //网络错误
    if (error) {
        if (request.requestTask.state != NSURLSessionTaskStateCanceling) {

            NSInteger responseCode = resultResponse.responseCode ;
            NSError *errorN = [NSError errorWithDomain:error.error.domain code:responseCode userInfo:nil];
            EasyNetworkError *tempError = [EasyNetworkError networkToolError:errorN code:NetworkErrorCodeNetError];
            resultResponse.error = tempError ;
        }
        else{
            error.errorCode = NetworkErrorCodeCancelRequest ;
            resultResponse.error = error ;
        }
        return resultResponse ;
    }
    
    //返回数据非字典
    if (![responseData isKindOfClass:[NSDictionary class]]) {
        error.errorCode = NetworkErrorCodeNotDictionary ;
        return resultResponse ;
    }
    
    NSDictionary* responseDict = [NSDictionary dictionaryWithDictionary:(NSDictionary*)responseData];
    responseDict = [EasyNetworkUtils dictionaryClearEmpty:responseDict];
    
    if ([parseClass isKindOfClass:[NSNull class]] || parseClass == Nil) {
        return resultResponse ;
    }
    NSError* analysisError = nil;
    BaseResponse* responseModel = nil;
    @try {
        responseModel = [[[parseClass class] alloc] initWithDictionary:responseDict error:&analysisError];
    }@catch (NSException *exception) {
        NSLog(@"数据解析出错 error:%@ == %@  ==== %@", self,exception,error);
    }
    
    if (nil == responseModel || analysisError) {
        responseModel = [[BaseResponse alloc]initWithDictionary:responseDict error:&analysisError];
    }
    
    if (responseModel.code==0 && !analysisError && responseModel) {//数据正常
        //数据解析正常
        resultResponse.responseData = responseModel ;
        return resultResponse ;
    }
    else{
        
        if (responseModel.msg.length > 0 ) {
            analysisError = [NSError errorWithDomain:responseModel.msg code:analysisError.code userInfo:nil];
        }
        EasyNetworkError *tempError = [EasyNetworkError networkToolError:analysisError];
        switch (responseModel.code) {//code =0 正确 code=-1异常 code=2001密码错误 code=2002登录失效
            case 2001: tempError.errorCode = NetworkErrorCodePasswordError ; break;
            case 2002: tempError.errorCode = NetworkErrorCodeNotLogin ; break ;
            case -1  : tempError.errorCode = NetworkErrorCodeNoZero ;break ;
            default:   tempError.errorCode = NetworkErrorCodeAnalyzeError ; break;
        }
        resultResponse.error = tempError ;
        return resultResponse ;

    }
    return resultResponse ;
}

//当子类没有实现解析数据方法时调用
- (BaseResponse*)parseResponse:(NSDictionary*)responseDict error:(NSError**)error
{
    return [[BaseResponse alloc] initWithDictionary:responseDict error:error];
}

@end
