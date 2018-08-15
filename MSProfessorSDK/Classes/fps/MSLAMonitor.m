//
//  MSLAMonitor.m
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MSLAMonitor.h"
#import "MSFPSMonitor.h"

@implementation MSLAMonitor

+ (void)showFPSWithFpsBlock:(void (^)(float,NSString *))fpsBlock {
    // 开启 FPS 显示
    dispatch_async(dispatch_get_main_queue(), ^{
        [MSFPSMonitor shareManager].fpsBlock = fpsBlock;
        [[MSFPSMonitor shareManager] star];
    });
}


@end
