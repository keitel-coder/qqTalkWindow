//
//  ViewController.m
//  qqTalkWindow
//
//  Created by 李贵 on 16/1/3.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "ViewController.h"
#import "MessageFrame.h"
#import "MessageModel.h"
#import "MessageCell.h"

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputText;

@property(strong,nonatomic) NSArray *messageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消tableView的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写方法

-(NSArray*) messageArray{
    if(_messageArray==nil){
        //从plist中加载
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        NSMutableArray *mutablArray=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in array) {
            MessageModel *message=[MessageModel messageModelWithDict:dict];
            MessageFrame *frame=[[MessageFrame alloc]init];
            frame.message=message;
            [mutablArray addObject:frame];
        }
        _messageArray=mutablArray;
    }
    return _messageArray;
}

#pragma mark -tableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    //    MessageCell *cell2=[MessageCell cellWithTableView:tableView];
    MessageCell *cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sss"];
    
    
//    NSString *identifier=@"messageCell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
//    if(cell==nil){
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    MessageFrame *frame= self.messageArray[indexPath.row];
//    MessageModel *message=frame.message;
//    cell.textLabel.text=message.text;
//    NSString *imageName;
//    if (message.type==MessageModelTypeMe) {
//        imageName=@"me";
//    }else{
//        imageName=@"other";
//    }
//    cell.imageView.image=[UIImage imageNamed:imageName];
    return cell;
}
@end
