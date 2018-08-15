//
//  MSLATool.m
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MSLATool.h"


@implementation MSLATool

//+ (NSString *)gz_getNetwork {
//    NetworkStatus status = [[Reachability reachabilityForInternetConnection]  currentReachabilityStatus];
//    if (status == NotReachable) {
//        return @"none";
//    }else if(status == ReachableViaWiFi){
//        return @"wifi";
//    }else{
//        NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
//                                   CTRadioAccessTechnologyGPRS,
//                                   CTRadioAccessTechnologyCDMA1x];
//        NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
//                                   CTRadioAccessTechnologyWCDMA,
//                                   CTRadioAccessTechnologyHSUPA,
//                                   CTRadioAccessTechnologyCDMAEVDORev0,
//                                   CTRadioAccessTechnologyCDMAEVDORevA,
//                                   CTRadioAccessTechnologyCDMAEVDORevB,
//                                   CTRadioAccessTechnologyeHRPD];
//        NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
//        CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
//        NSString *accessString = teleInfo.currentRadioAccessTechnology;
//        if (!accessString) {
//            return @"other";
//        }
//        if ([typeStrings4G containsObject:accessString])  {
//            return @"4g";
//        } else if ([typeStrings3G containsObject:accessString]) {
//            return @"3g";
//        } else if ([typeStrings2G containsObject:accessString]) {
//            return @"2g";
//        } else {
//            return @"other";
//        }
//    }
//}
//
//+ (NSString *)gz_getControllerOfView:(UIView *)view{
//    for (UIView* next = [view superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return NSStringFromClass([nextResponder class]);
//        }
//    }
//    return @"";
//}

+ (NSString *)gz_getCurrentVC {
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc;
    UIViewController *rootViewController = window.rootViewController;
    if (!rootViewController) {
        return @"未知";
    }
    
    if ([rootViewController isKindOfClass:NSClassFromString(@"UITabBarController")]) {
        UITabBarController *tVC = (UITabBarController *)rootViewController;
        UIViewController *tmp = [tVC viewControllers][tVC.selectedIndex];
        if ([tmp isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)tmp topViewController];
        }else{
            vc = tmp;
        }
    }else if ([rootViewController isKindOfClass:NSClassFromString(@"UINavigationController")]){
        vc = [(UINavigationController *)rootViewController topViewController];
    }else{
        vc = rootViewController;
    }
    return NSStringFromClass(vc.class);
}

//+ (NSString *)gz_getCarrier{
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [info subscriberCellularProvider];
//    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
//    if (mCarrier.length == 0 || !carrier) {
//        mCarrier = @"其他";
//    }
//    return mCarrier;
//}


@end
