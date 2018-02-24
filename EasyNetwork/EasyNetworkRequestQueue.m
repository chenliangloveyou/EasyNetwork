//
//  EasyNetworkRequestQueue.m
//  EFHealth
//
//  Created by nf on 2018/2/10.
//  Copyright © 2018年 ef. All rights reserved.
//

#import "EasyNetworkRequestQueue.h"
#import "EasyNetworkOptions.h"
#import "EasyNetworkRequest.h"

@interface EasyNetworkRequestQueue()

@property (nonatomic,strong)NSMutableArray *requestArray ;

@end

@implementation EasyNetworkRequestQueue



static EasyNetworkRequestQueue *_showInstance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showInstance = [super allocWithZone:zone];
    });
    return _showInstance;
}
+ (instancetype)shareEasyNetworkRequestQueue{
    if (nil == _showInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _showInstance = [[[self class] alloc] init];
        });
    }
    return _showInstance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _showInstance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _showInstance;
}

- (NSUInteger)addEasyNetworkRequest:(EasyNetworkRequest *)request
{
    //如果是需要删除重复的请求。则取消之前发出的请求
    if ([EasyNetworkOptions sharedEasyNetworkOptions].cancelRepeatRequest) {
        
        for (EasyNetworkRequest *tempRequest in self.requestArray) {
            BOOL isCommonRequest = YES ;
            if([tempRequest.requestPath isEqualToString:request.requestPath]){
                for (NSString *tempKeys in [tempRequest.requestparameters allKeys]) {
                    if ([[request.requestparameters allKeys] containsObject:tempKeys]) {
                        NSString *temp_1 = [NSString stringWithFormat:@"%@",tempRequest.requestparameters[tempKeys]] ;
                        NSString *temp_2 = [NSString stringWithFormat:@"%@",request.requestparameters[tempKeys]];
                        if ([temp_1 isEqualToString:temp_2]) {
                            isCommonRequest = NO ;
                            break ;//原则上，requestArray中只有存在一个相同的请求。
                        }
                    }
                }
            }
            if (isCommonRequest) {
                [tempRequest cancelRequest];
            }
        }
    }
    @synchronized(self.requestArray){
        [self.requestArray addObject:request] ;
    }
    return -1 ;
}
- (NSUInteger)removeEasyNetworkRequest:(EasyNetworkRequest *)request
{

    if ([self.requestArray containsObject:request]) {
        @synchronized(self.requestArray){
            [self.requestArray removeObject:request] ;
        }
    }
    else{
        NSString *alertString = [NSString stringWithFormat:@"attention:you should deal with this error! request:%@ , requestqueue:%@",request,_requestArray] ;
        NSAssert(NO,alertString);
    }
    
    return -1 ;
}


-(NSMutableArray *)requestArray
{
    if (nil == _requestArray) {
        _requestArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _requestArray ;
}
@end
