//
//  MSStartUpRecord.m
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/21.
//

#import "MSStartUpRecord.h"

static void(^startupblock)(NSDictionary *dict);

@implementation MSStartUpRecord

+ (void)load {
    CFAbsoluteTime s =  CFAbsoluteTimeGetCurrent();
    @autoreleasepool {
        __block id<NSObject> obs;
        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                                object:nil queue:nil
                                                            usingBlock:^(NSNotification *note) {
                                                                NSMutableDictionary *dict = [NSMutableDictionary new];
                                                                double stay = (CFAbsoluteTimeGetCurrent() - s) * 1000;
                                                                NSString *stayString = [NSString stringWithFormat:@"%0.2f",stay];
                                                                [dict setValue:stayString forKey:@"stay"];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    startupblock ? startupblock(dict) : nil;
                                                                });
                                                                [[NSNotificationCenter defaultCenter] removeObserver:obs];
                                                            }];
    }
}

+ (void)setupWithBlock:(void (^)(NSDictionary *dict))block {
    startupblock = block;
}

@end
