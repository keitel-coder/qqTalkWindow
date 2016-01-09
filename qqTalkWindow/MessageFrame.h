//
//  MessageFrame.h
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  正文字体
 *
 *  @return 正文字体
 */
#define TextFont [UIFont systemFontOfSize:14]

/**
 *  正文的内边距
 *
 *  @return 内边距
 */
#define TextPadding 20
@class MessageModel;

@interface MessageFrame : UIView

/**
 *  头像的Frame
 */
@property(assign,nonatomic,readonly) CGRect iconFrame;

/**
 *  消息内容的Frame
 */
@property(assign,nonatomic,readonly) CGRect textFrame;

/**
 *  时间的Frame
 */
@property(assign,nonatomic,readonly) CGRect timeFrame;

/**
 *  消息模型
 */
@property(strong,nonatomic) MessageModel *message;

/**
 *  cell的高度
 */
@property(assign,nonatomic,readonly)CGFloat cellHeight;

@end
