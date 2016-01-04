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
    return cell;
}

#pragma mark -重写方法
//-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    //往cell中添加元素
//    //添加时间label
//    UILabel *timeLabel=[[UILabel alloc]init];
//    [self.contentView addSubview:timeLabel];
//    self.timeLabel=timeLabel;
//
//    //添加头像image
//    UIImageView *iconImage=[[UIImageView alloc]init];
//    [self.contentView addSubview:iconImage];
//    self.iconImage=iconImage;
//
//    //添加消息内容button
//    UIButton *textButton=[[UIButton alloc]init];
//    [self.contentView addSubview:textButton];
//    self.textButton=textButton;
//
//    return self;
//}

-(void) setFrame:(MessageFrame *)frame{
        _frame=frame;
        MessageModel *message=frame.message;
    
        //设置时间的frame
        self.timeLabel.frame=frame.timeFrame;
        self.timeLabel.text=message.time;
    
//    设置头像的frame
}

@end
