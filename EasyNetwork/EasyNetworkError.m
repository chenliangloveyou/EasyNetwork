//
//  EasyNetworkError.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkError.h"

@implementation EasyNetworkError
+ (instancetype)networkToolError:(NSError *)error
{
    EasyNetworkError *tempError = [EasyNetworkError networkToolError:error code:0];
    return tempError ;
}
+ (instancetype)networkToolError:(NSError *)error code:(NetworkErrorCode)code
{
    EasyNetworkError *tempError = [[self alloc]init];
    tempError.error = error ;
    tempError.errorCode = code ;
    return tempError ;
}

- (NSString *)errorDesc
{
    if (_errorDesc) {
        return _errorDesc ;
    }
    
    switch (_errorCode) {
        case NetworkErrorCodeNotLogin:      return @"登录失效，请重新登录";
        case NetworkErrorCodePasswordError: return @"密码错误，请重新登录";
        case NetworkErrorCodeNotDictionary: return @"结果异常，请稍后再试！";
        case NetworkErrorCodeNoZero:{
            NSString *desc = [NSString stringWithFormat:@"后台异常(%@%ld)",_error.domain,(long)_error.code];
            return desc;
        }
        case NetworkErrorCodeAnalyzeError: {
            NSString *desc = [NSString stringWithFormat:@"解析异常(%@%ld)",_error.domain,(long)_error.code];
            return desc;
        }
        case NetworkErrorCodeResultError:   return @"";
        case NetworkErrorCodeNoNet:         return @"无网络，请稍后再试!";
        case NetworkErrorCodeNetError: {
            NSString *desc = [NSString stringWithFormat:@"网络错误(%@%ld)",_error.domain,(long)_error.code];
            return desc ;
        }
        case NetworkErrorCodeCancelRequest: return @"";
        default:
            break;
    }
    return @"" ;
}
//这是网络错误
//NSInteger responseCode = ((NSHTTPURLResponse *)request.response).statusCode ;
//NSError *errorN = [NSError errorWithDomain:error.domain code:responseCode userInfo:nil];
//EasyNetworkError *tempError = [EasyNetworkError networkToolError:errorN code:NetworkErrorCodeNetError];
//[weasSelf notifyDelegateCallbackResponse:nil error:tempError];


@end
