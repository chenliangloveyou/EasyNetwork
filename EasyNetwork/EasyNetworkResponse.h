//
//  EasyNetworkResponse.h
//  EFDoctorHealth
//
//  Created by nf on 2018/2/2.
//  Copyright © 2018年 NF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EasyNetworkRequest ;
@class EasyNetworkError ;

@interface EasyNetworkResponse : NSObject

+ (instancetype)networkResponseWithRequest:(EasyNetworkRequest *)request
                                  response:(NSURLResponse *)response
                              responseData:(id)responseData
                                parseClass:(Class)parseClass
                                     error:(EasyNetworkError *)error;


@property (nonatomic,strong)EasyNetworkError *error ;

@property (nonatomic,strong)id responseData ;

@property (nonatomic,strong)id orginalData ;//原始数据

@property (nonatomic,assign)NSInteger responseCode ;
@property (nonatomic,strong)NSHTTPURLResponse *URLResponse;
@property (nonatomic,strong)EasyNetworkRequest *request ;

/**
    if (error) {
        //说明数据下载发生了错误
        //错误代码:error.errorCode  错误信息:error.errorDesc
    }
    else{
        //说明没有发生错误
        if (parseClass) {//如果你传入了parseClass 需要用jsonModel解析数据
            //取responseData
        }
        else{
            //取orginalData原始数据 自己解析
        }
    }
 */

@end










