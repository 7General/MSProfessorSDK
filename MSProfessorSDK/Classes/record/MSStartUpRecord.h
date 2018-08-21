//
//  MSStartUpRecord.h
//  MSProfessorSDK
//
//  Created by 王会洲 on 2018/8/21.
//

#import <Foundation/Foundation.h>

@interface MSStartUpRecord : NSObject


/**
 app启动

 @param block dict
 */
+ (void)setupWithBlock:(void(^)(NSDictionary *dict))block;

@end
