//
//  MSLAMonitor.h
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/15.
//  Copyright © 2018年 王会洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLAMonitor : NSObject

+ (void)showFPSWithFpsBlock:(void (^)(float fps,NSString *vcname))fpsBlock;

@end
