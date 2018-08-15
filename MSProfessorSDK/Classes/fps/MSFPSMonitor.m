//
//  MSFPSMonitor.m
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/15.
//  Copyright © 2018年 zzg. All rights reserved.
//


#import "MSFPSMonitor.h"
#import "MSLATool.h"

@interface MSFPSMonitor()

@property (nonatomic , strong) CADisplayLink  *displayLink;
@property (nonatomic , strong) UILabel        *fpsLable;
@property (nonatomic , assign) NSTimeInterval lastime;
@property (nonatomic , assign) NSInteger      count;

@end

#define FPS_THRESHOLD 45 //上传阈值，低于此阈值的时候上传

@implementation MSFPSMonitor

+ (instancetype)shareManager {
    static MSFPSMonitor *monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[MSFPSMonitor alloc] init];
    });
    return monitor;
}

- (void)dealloc {
    [_displayLink setPaused:YES];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (instancetype)init {
    if (self = [super init]) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(track:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        self.fpsLable = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 50) / 2 + 55, 3, 50, 15)];
        self.fpsLable.textAlignment = NSTextAlignmentCenter;
        self.fpsLable.font = [UIFont boldSystemFontOfSize:12];
    }
    return self;
}

- (void)track:(CADisplayLink *)link {
    if (_lastime == 0) {
        // 记录时间戳
        _lastime = link.timestamp;
        return;
    }
    _count++;
    // 间隔
    NSTimeInterval delta = link.timestamp - _lastime;
    if (delta < 1) {return;}
    _lastime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    if (self.fpsBlock && fps < FPS_THRESHOLD) {
        self.fpsBlock(fps,[MSLATool gz_getCurrentVC]);
    }
#if DEBUG
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    self.fpsLable.textColor = color;
    self.fpsLable.text = [NSString stringWithFormat:@"fps:%d",(int)round(fps)];
#endif
}

- (void)star {
    [self.displayLink setPaused:NO];
#if DEBUG
    self.fpsLable.hidden = NO;
    if (self.fpsLable.superview) {
        return;
    }
    [[((NSObject <UIApplicationDelegate> *)([UIApplication sharedApplication].delegate)) window].rootViewController.view addSubview:self.fpsLable];
#endif
}

- (void)stop {
    [self.displayLink setPaused:YES];
    self.fpsLable.hidden = YES;
}


@end
