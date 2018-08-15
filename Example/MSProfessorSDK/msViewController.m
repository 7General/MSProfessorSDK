//
//  msViewController.m
//  MSProfessorSDK
//
//  Created by wanghuizhou21@163.com on 08/15/2018.
//  Copyright (c) 2018 wanghuizhou21@163.com. All rights reserved.
//

#import "msViewController.h"
#import <MSProfessorSDK/MSLAMonitor.h>

@interface msViewController ()

@end

@implementation msViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MSLAMonitor showFPSWithFpsBlock:^(float fps, NSString *vcname) {
        
    }];
    
    
}

@end
