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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputText;

@property(strong,nonatomic) NSMutableArray *messageArray;
@property (nonatomic, strong) NSDictionary *autoreply;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消tableView的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //设置背景色
    self.tableView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    //设置代理方法
    self.tableView.delegate=self;
    
    //键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 3.设置文本框左边显示的view
    self.inputText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    // 永远显示
    self.inputText.leftViewMode = UITextFieldViewModeAlways;
    self.inputText.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma marke 键盘代理事件
-(void)keyboardWillChangeFrame:(NSNotification *)note{
    // 设置窗口的颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 1.自己发一条消息
    [self addMessage: textField.text type:MessageModelTypeMe];
    
    // 2.自动回复一条消息
    NSString *reply = [self replyWithText:textField.text];
    [self addMessage:reply type:MessageModelTypeOther];
    
    // 3.清空文字
    self.inputText.text = nil;
    
    // 返回YES即可
    return YES;
}

-(void)addMessage:(NSString*) text type:(MessageModelType)type{
    //创建模型
    MessageModel *model=[[MessageModel alloc]init];
    model.type=type;
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    model.time = [fmt stringFromDate:now];
    model.text=text;
    MessageFrame *lastFrame=[self.messageArray lastObject];
    //判断是否显示时间
    if ([lastFrame.message.time isEqualToString:model.time]) {
        model.isHiddenTime=YES;
    }
    MessageFrame *messageF=[[MessageFrame alloc]init];
    //添加数据
    messageF.message=model;
    [self.messageArray addObject:messageF];
    
    // 3.刷新表格
    [self.tableView reloadData];
    // 4.自动滚动表格到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(NSString *) replyWithText:(NSString *)text{
    for (int i = 0; i<text.length; i++) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        
        if (self.autoreply[word]) return self.autoreply[word];
    }
    return @"滚蛋";
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
            MessageFrame *lastObj=mutablArray.lastObject;
            if ([lastObj.message.time isEqualToString:message.time]) {
                message.isHiddenTime=YES;
            }
            [mutablArray addObject:frame];
            frame.message=message;
        }
        _messageArray=mutablArray;
    }
    return _messageArray;
}

- (NSDictionary *)autoreply
{
    if (_autoreply == nil) {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}

#pragma mark -tableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    MessageCell *cell=[MessageCell cellWithTableView:tableView];
    //为cell添加数据
    cell.messageFrame=self.messageArray[indexPath.row];
    return cell;
}

#pragma mark -tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrame *frame=self.messageArray[indexPath.row];
    return frame.cellHeight;
}

/**
 *  视图开始滚动
 *
 *  @param scrollView <#scrollView description#>
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
