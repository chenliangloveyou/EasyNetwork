//
//  BaseResponse.h
//  HHMusic
//
//  Created by liumadu on 14-9-22.
//  Copyright (c) 2014年 hengheng. All rights reserved.
//

#import "JSONModel.h"

@interface BaseResponse : JSONModel

@property (nonatomic, assign) int code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *msg;

//+ (void)initKeyMapper;

//+ (JSONKeyMapper *)keyMapper ;

@end
