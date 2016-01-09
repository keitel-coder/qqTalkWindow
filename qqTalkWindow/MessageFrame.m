//
//  MessageFrame.m
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "MessageFrame.h"
#import "MessageModel.h"
#import "NSString+Extension.h"

@implementation MessageFrame

-(void) setMessage:(MessageModel *)message{
    _message=message;
    
    //时间的frame
    CGFloat deviceW=[UIScreen mainScreen].bounds.size.width;
    CGFloat timeW=deviceW;
    CGFloat timeH=message.isHiddenTime?0:40.0;
    _timeFrame=CGRectMake(0, 0,timeW , timeH);
    CGFloat padding=10;
    
    //头像的frame
    CGFloat iconW=40;
    CGFloat iconH=40;
    //默认为他人发送的
    CGFloat iconX;
    CGFloat iconY=CGRectGetMaxY(_timeFrame);
    //自己发送的
    if(message.type==MessageModelTypeMe){
        iconX=deviceW-padding-iconW;
    }else{
        iconX=padding;
    }
    _iconFrame=CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3.正文
    CGFloat textY = iconY;
    // 文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    // 文字计算出来的真实尺寸(按钮内部label的尺寸)
    CGSize textRealSize = [message.text sizeWithFont:TextFont maxSize:textMaxSize];
    // 按钮最终的真实尺寸
    CGSize textBtnSize = CGSizeMake(textRealSize.width + TextPadding * 2, textRealSize.height + TextPadding * 2);
    CGFloat textX;
    if (message.type == MessageModelTypeMe) {// 自己发的
        textX = iconX - padding - textBtnSize.width;
    } else {//别人发的
        textX = CGRectGetMaxX(_iconFrame) + padding;
    }
    _textFrame = (CGRect){{textX, textY}, textBtnSize};
    
    //cell总高度
    _cellHeight=MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame))+padding;
    
}
@end
