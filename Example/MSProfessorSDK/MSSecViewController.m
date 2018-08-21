//
//  MSSecViewController.m
//  MSProfessorSDK_Example
//
//  Created by zzg on 2018/8/17.
//  Copyright © 2018年 wanghuizhou21@163.com. All rights reserved.
//

#import "MSSecViewController.h"

@interface MSSecViewController ()

@end

@implementation MSSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame  =CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(clickSec) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)clickSec {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIView * v = [[UIView alloc] init];
            [self.view addSubview:v];
        });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.secHandler) {
        self.secHandler();
    }
}

@end
