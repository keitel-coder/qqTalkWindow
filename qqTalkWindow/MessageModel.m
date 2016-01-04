//
//  MessageModel.m
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) messageModelWithDict:(NSDictionary *)dict{
    return  [[MessageModel alloc]initWithDict:dict];
}

@end
