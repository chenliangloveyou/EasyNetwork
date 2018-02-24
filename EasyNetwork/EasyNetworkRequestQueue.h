//
//  EasyNetworkRequestQueue.h
//  EFHealth
//
//  Created by nf on 2018/2/10.
//  Copyright © 2018年 ef. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EasyNetworkRequest ;

@interface EasyNetworkRequestQueue : NSObject

@property (nonatomic,strong,readonly)NSMutableArray *requestArray ;

+ (instancetype)shareEasyNetworkRequestQueue ;

//添加一个请求
- (NSUInteger)addEasyNetworkRequest:(EasyNetworkRequest *)request ;

//删除一个请求
- (NSUInteger)removeEasyNetworkRequest:(EasyNetworkRequest *)request ;

@end

