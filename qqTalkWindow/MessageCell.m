//
//  MessageCell.m
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "MessageFrame.h"
#import "UIImage+Extension.h"

@interface MessageCell ()
/**
 *  时间标签标签
 */
@property(weak,nonatomic) UILabel *timeLabel;

/**
 *  消息内容按钮
 */
@property(weak,nonatomic) UIButton *textButton;

/**
 *  头像图片
 */
@property(weak,nonatomic) UIImageView *iconImage;
@end

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype) cellWithTableView:(UITableView *)tableView{
    static NSString *identifier=@"messageCell";
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor=tableView.backgroundColor;
    return cell;
}

#pragma mark -重写方法
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //往cell中添加元素
    //添加时间label
    UILabel *timeLabel=[[UILabel alloc]init];
    [self.contentView addSubview:timeLabel];
    timeLabel.font=[UIFont systemFontOfSize:12];
    self.timeLabel=timeLabel;

    //添加头像image
    UIImageView *iconImage=[[UIImageView alloc]init];
    [self.contentView addSubview:iconImage];
    self.iconImage=iconImage;

    //添加消息内容button
    UIButton *textButton=[[UIButton alloc]init];
    textButton.titleLabel.numberOfLines = 0; // 自动换行
    textButton.titleLabel.font = TextFont;
    textButton.contentEdgeInsets = UIEdgeInsetsMake(TextPadding, TextPadding, TextPadding, TextPadding);
    [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:textButton];
    self.textButton=textButton;

    return self;
}

-(void) setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame=messageFrame;
    MessageModel *message=messageFrame.message;
    
    //设置时间
    self.timeLabel.frame=messageFrame.timeFrame;
    //灰色
    self.timeLabel.textColor=[UIColor grayColor];
    //居中
    self.timeLabel.textAlignment=NSTextAlignmentCenter;
    self.timeLabel.text=message.time;
    
    //设置头像
    self.iconImage.frame=messageFrame.iconFrame;
    NSString *iconImage;
    if (message.type==MessageModelTypeMe) {
        iconImage=@"me";
    }else{
        iconImage=@"other";
    }
    self.iconImage.image=[UIImage imageNamed:iconImage];
    
    //设置消息内容
    self.textButton.frame=messageFrame.textFrame;
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
    NSString *textNormalBackImage;
    NSString *textPressBackImage;
    if(MessageModelTypeMe==message.type){
        textNormalBackImage=@"chat_send_nor";
        textPressBackImage=@"chat_send_press_pic";
    }else{
        textNormalBackImage=@"chat_recive_nor";
        textPressBackImage=@"chat_recive_press_pic";
    }
    [self.textButton setBackgroundImage:[UIImage resizableImage:textNormalBackImage] forState:UIControlStateNormal];
    [self.textButton setBackgroundImage:[UIImage resizableImage:textPressBackImage] forState:UIControlStateHighlighted];
}

@end
