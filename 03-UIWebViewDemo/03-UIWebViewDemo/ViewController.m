//
//  ViewController.m
//  03-UIWebViewDemo
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    
    //缩放
    _webView.scalesPageToFit = YES;
    
    [self loadTextFieldRequest];
    // Do any additional setup after loading the view, typically from a nib.
}

//加载textField中的链接地址
-(void)loadTextFieldRequest {
    NSURL *url = [NSURL URLWithString:_textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}


#pragma mark  -UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible  = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *htmlString = @"<html><marquee><h4>对不起，你加载的网页不存在</h4></marquee></html>";
    [webView loadHTMLString:htmlString baseURL:nil];
    
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self loadTextFieldRequest];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
