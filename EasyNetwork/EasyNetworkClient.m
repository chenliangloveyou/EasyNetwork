//
//  EasyNetworkClient.m
//  EFDoctorHealth
//
//  Created by nf on 2018/2/5.
//  Copyright © 2018年 NF. All rights reserved.
//

#import "EasyNetworkClient.h"
#import "EasyNetworkEnvironment.h"
#import "EasyNetworkOptions.h"

@implementation EasyNetworkClient

+ (instancetype)shareClient
{
    if ([EasyNetworkEnvironment shareEnvironment].isOnlineEnvironment) {
        return [EasyNetworkClient shareNetworkClient];
    }
    return [EasyNetworkClient shareNetworkTestClient];
#warning 分析这两个单例。
}

+ (instancetype)shareNetworkClient
{
    static EasyNetworkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:[EasyNetworkOptions sharedEasyNetworkOptions].baseUrl];
        NSAssert(url, @"look ！the base url is empty");
        _sharedClient = [[EasyNetworkClient alloc] initWithBaseURL:url];
        [EasyNetworkClient clientConfigWithManager:_sharedClient];
    });
    return _sharedClient;
}
+ (instancetype)shareNetworkTestClient
{
    static EasyNetworkClient *_sharedTestClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:[EasyNetworkOptions sharedEasyNetworkOptions].baseTestUrl];
        NSAssert(url, @"look ！the base url is empty");
        _sharedTestClient = [[EasyNetworkClient alloc] initWithBaseURL:url];
        [EasyNetworkClient clientConfigWithManager:_sharedTestClient];
    });
    return _sharedTestClient;
}
+ (void)clientConfigWithManager:(EasyNetworkClient *)client
{
    AFSecurityPolicy* policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    [client setSecurityPolicy:policy];
    client.requestSerializer = [AFHTTPRequestSerializer serializer];
    client.responseSerializer = [AFHTTPResponseSerializer serializer];
    //client.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    client.responseSerializer = [AFJSONResponseSerializer serializer];
    client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript",@"application/json", @"text/json", @"text/html", nil];
}

@end
