//
//  MSMainThreadGuard.m
//  MSProfessorSDK
//
//  Created by zzg on 2018/8/16.
//

#import "MSMainThreadGuard.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation MSMainThreadGuard

- (void)MSredCupStart {
#ifndef RELEASE
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"开始检测");
        [self MSredCupThread];
    });
#endif
}


- (void)MSredCupThread {
    id objc_class = objc_getClass("UIView");
    Class class = [objc_class class];
    // 黑名单
    NSMutableArray *ignoreMethods = [NSMutableArray arrayWithArray:@[@"retain", @"release", @"dealloc", @".cxx_destruct"]];
    
    // 获取类所包含所有属性的数组
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for(int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        [ignoreMethods addObject:@(property_getName(property))];
    }
    free(properties);
    
    // 获取类的实例方法
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    
    for (int i = 0; i < methodCount; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        
        if (![methodName hasPrefix:@"_"]) {
            BOOL isCan = NO;
            for (NSString *ignoreMethod in ignoreMethods) {
//                NSLog(@"-->>:%@",ignoreMethod);
                
                if ([methodName isEqualToString:ignoreMethod] ) {
                    isCan = YES;
                    continue;
                }
            }
            if (!isCan) {
                /*
                 [LayoutConstraints] Sending -viewForBaselineLayout to a member of _UIModernBarButton in lieu of -viewForLastBaselineLayout. Please adopt the iOS 9 API.
                 */
                
//                if(![methodName containsString:@"viewForBaselineLayout"] || ![methodName containsString:@"viewForLastBaselineLayout"]) {
                    SEL selector = NSSelectorFromString(methodName);
                    replaceMethod(class,selector,method_copyReturnType(method));
//                }
                
                //NSLog(@"success hook method:%@ types:%s", NSStringFromSelector(selector), method_getDescription(method)->types);
            }
        }
    }
    free(methodList);
}

BOOL replaceMethod(Class cls,SEL originSelector,char * returnType) {
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    if (nil == originMethod) {
        return NO;
    }
    const char *originTypes = method_getTypeEncoding(originMethod);
    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
    // 判断是否为结构体
    if (originTypes[0] == '{') {
        //In some cases that returns struct, we should use the '_stret' API:
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:originTypes];
        if ([methodSignature.debugDescription rangeOfString:@"is special struct return? YES"].location != NSNotFound) {
            msgForwardIMP = (IMP)_objc_msgForward_stret;
        }
    }
#endif
    IMP originIMP = method_getImplementation(originMethod);
    if (nil == originMethod || msgForwardIMP == originIMP) {
        return NO;
    }
    
    //把原方法的IMP换成_objc_msgForward，使之触发forwardInvocation方法
    class_replaceMethod(cls, originSelector, msgForwardIMP, originTypes);
    
    //把方法forwardInvocation的IMP换成myForwardInvocation
    if (class_getMethodImplementation(cls, @selector(forwardInvocation:)) != (IMP)MSForwardInvocation) {
        class_replaceMethod(cls, @selector(forwardInvocation:), (IMP)MSForwardInvocation, originTypes);
    }
    
    if (class_respondsToSelector(cls, originSelector)) {
        NSString * oldSelectorName = NSStringFromSelector(originSelector);
        NSString * newSelectorName = [NSString stringWithFormat:@"MS_%@",oldSelectorName];
        SEL newSelector = NSSelectorFromString(newSelectorName);
        
        if(!class_respondsToSelector(cls, newSelector)){
            class_addMethod(cls, newSelector, originIMP, originTypes);
        }
    }
    
    return YES;
}
void MSForwardInvocation(id target,SEL selector ,NSInvocation * invocation) {
    if (![NSThread currentThread].isMainThread) {
//        NSLog(@"\n#####################\n非主线程中更新UI:%@\n#####################",[NSThread callStackSymbols]);
        // 主动报错
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
    }
    NSString *selectorName = NSStringFromSelector(invocation.selector);
    NSString *origSelectorName = [NSString stringWithFormat:@"MS_%@", selectorName];
    SEL origSelector = NSSelectorFromString(origSelectorName);
    invocation.selector = origSelector;
    invocation.target = target;
    [invocation invoke];
}





@end
