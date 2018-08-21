//
//  MSSecViewController.h
//  MSProfessorSDK_Example
//
//  Created by zzg on 2018/8/17.
//  Copyright © 2018年 wanghuizhou21@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^secClik)(void);
@interface MSSecViewController : UIViewController
@property (nonatomic, copy) secClik  secHandler;
@end
