//
//  MessageModel.h
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  定义消息类型枚举
 */
typedef enum{
    MessageModelTypeMe=0,
    MessageModelTypeOther=1
} MessageModelType;

@interface MessageModel : UIView

/**
 *  消息内容
 */
@property(copy,nonatomic) NSString *text;

/**
 *  消息时间
 */
@property (copy,nonatomic)NSString *time;

/**
 *  消息类型
 */
@property(assign,nonatomic)MessageModelType type;

/**
 *  静态方法初始化数据模型
 *
 *  @param dict 传入字典
 *
 *  @return 数据模型
 */
-(instancetype)initWithDict:(NSDictionary*) dict;

/**
 *  成员方法初始化数据模型
 *
 *  @param dict 传入字典
 *
 *  @return 数据模型
 */
+(instancetype) messageModelWithDict:(NSDictionary*) dict;
@end
