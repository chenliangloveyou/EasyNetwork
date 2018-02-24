//
//  EasyNetworkError.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,NetworkErrorCode) {
    NetworkErrorCodeNoNet = 1 ,//无网络数据
    NetworkErrorCodeNetError = 2 ,//网络错误
    NetworkErrorCodeCancelRequest = 3 , //取消青丘
    
    NetworkErrorCodeAnalyzeError = 4 , //解析错误
    NetworkErrorCodeResultError = 5 , //结果错误
    NetworkErrorCodeNoZero     = 6 ,//结果非0
    NetworkErrorCodeNotDictionary = 7 ,//结果不是字典
    
    NetworkErrorCodeNotLogin = 8 , //未登录错误      后台接口返回2002
    NetworkErrorCodePasswordError = 9 ,  //登录密码错误    后台接口返回2001
    
    NetworkErrorCodeRequestError = 10 ,//请求API错误
    NetworkErrorCodeResponseError = 11 ,//请求回复错误
};
@interface EasyNetworkError : NSObject
@property (nonatomic,assign)NetworkErrorCode errorCode ;
@property (nonatomic,strong)NSString *errorDesc ;
@property (nonatomic,strong)NSError *error ;

+ (instancetype)networkToolError:(NSError *)error ;
+ (instancetype)networkToolError:(NSError *)error code:(NetworkErrorCode)code ;

@end
