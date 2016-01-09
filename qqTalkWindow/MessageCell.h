//
//  MessageCell.h
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/4.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrame;
@interface MessageCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic) MessageFrame *messageFrame;
@end
