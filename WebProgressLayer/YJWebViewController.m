//
//  YJWebViewController.m
//  YJWebProgressLayer
//
//  Created by Kean on 2016/12/15.
//  Copyright © 2016年 Kean. All rights reserved.
//

#import "YJWebViewController.h"
#import "YJWebProgressLayer.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface YJWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) YJWebProgressLayer *webProgressLayer;  //  进度条

@end

@implementation YJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    
}

- (void)initUI {

    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    NSLog(@"%@",self.url);
    [_webView loadRequest:request];
    
    _webProgressLayer = [[YJWebProgressLayer alloc] init];
    _webProgressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);

    [self.navigationController.navigationBar.layer addSublayer:_webProgressLayer];

    [self.view addSubview:_webView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {

    [_webProgressLayer startLoad];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [_webProgressLayer finishedLoadWithError:nil];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    [_webProgressLayer finishedLoadWithError:error];

}


- (void)dealloc {
    
    [_webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
