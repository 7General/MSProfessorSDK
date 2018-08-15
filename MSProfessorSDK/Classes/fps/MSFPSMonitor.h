//
//  MSFPSMonitor.h
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MSFPSMonitor : NSObject
+ (instancetype)shareManager;
@property (nonatomic , copy) void(^fpsBlock)(float fps, NSString *vcString);
- (void)star;
- (void)stop;
@end
