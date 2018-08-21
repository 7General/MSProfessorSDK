//
//  msViewController.m
//  MSProfessorSDK
//
//  Created by wanghuizhou21@163.com on 08/15/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

#import "msViewController.h"
#import <MSProfessorSDK/MSLAMonitor.h>
#import <MSProfessorSDK/MSMainThreadGuard.h>
#import "msSmartFun.h"


@interface msViewController ()

@end

@implementation msViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MSLAMonitor showFPSWithFpsBlock:^(float fps, NSString *vcname) {
        NSLog(@"------vcname:%@",vcname);
    }];
    MSMainThreadGuard * cup = [[MSMainThreadGuard alloc] init];
    [cup MSredCupThread];
    
    

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        msSmartFun * ms = [[msSmartFun alloc] init];
        [ms updatedb];
    });
}

@end
