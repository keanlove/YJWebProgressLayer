//
//  ViewController.m
//  YJWebProgressLayer
//
//  Created by Kean on 2016/12/15.
//  Copyright © 2016年 Kean. All rights reserved.
// https://github.com/keanlove/YJWebProgressLayer

#import "ViewController.h"
#import "YJWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;

    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    button.center = self.view.center;
    [button setTitle:@"点击进入加载页" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)onClick:(id)sender {

    NSLog(@"按钮被点击了");
    
    YJWebViewController *web = [[YJWebViewController alloc] init];
    web.url = @"https://www.baidu.com";
    [self.navigationController pushViewController:web animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
