//
//  ViewController.m
//  04-UITextViewDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.delegate = self;
    
    [self configTextView];
    
    //利用通知中心监听键盘的显示和消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardAction:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleKeyBoardAction:(NSNotification *)notification {
    NSLog(@"%@",notification);
    //1、计算动画前后的差值
    CGRect beginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat detalY = endFrame.origin.y - beginFrame.origin.y;
    
    //2、根据差值更改_textView的高度
    CGRect frame = _textView.frame;
    frame.size.height += detalY;
    _textView.frame = frame;
}

//配置文本信息（属性文本）
-(void)configTextView {
    //黑体range
    NSRange boldRange = [_textView.text rangeOfString:@"enim"];
    
    //下划线
    NSRange underLineRange = [_textView.text rangeOfString:@"exercitation"];
    
    //背景颜色
    NSRange bgRange = [_textView.text rangeOfString:@"reprehenderit"];
    
    //字体颜色
    NSRange colorRange = [_textView.text rangeOfString:@"proident"];
    
     NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
    
    //添加属性
    [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:boldRange];
    [mutableAttributedString addAttribute:NSUnderlineStyleAttributeName value:@(1) range:underLineRange];
    [mutableAttributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:bgRange];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:colorRange];
    
    
    //添加图片
    //文字附着图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"text_view_attachment"];
    
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [mutableAttributedString appendAttributedString:attachString];
    
    _textView.attributedText = mutableAttributedString;
}

#pragma mark -UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishAction)];
    self.navigationItem.rightBarButtonItem = doneItem;
}

-(void)finishAction{
    [_textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
