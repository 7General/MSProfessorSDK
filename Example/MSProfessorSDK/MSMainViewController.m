//
//  MSMainViewController.m
//  MSProfessorSDK_Example
//
//  Created by zzg on 2018/8/17.
//  Copyright © 2018年 wanghuizhou21@163.com. All rights reserved.
//

#import "MSMainViewController.h"
#import "MSSecViewController.h"

@interface MSMainViewController ()

@end

@implementation MSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MSSecViewController * sec = [[MSSecViewController alloc] init];
    [sec setSecHandler:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIView * v = [[UIView alloc] init];
            [self.view addSubview:v];
        });
    }];
    [self.navigationController pushViewController:sec animated:YES];
}


@end
