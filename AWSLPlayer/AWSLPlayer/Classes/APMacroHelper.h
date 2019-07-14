#ifndef _APMACROHELPER_HEADER_
#define _APMACROHELPER_HEADER_

#define weakSelf(obj) __weak typeof(obj) weakSelf = obj

#define MAKE_CLASS_SINGLETON(className, staticInstanceName, methodName) \
static className *staticInstanceName = nil;\
+ (instancetype)methodName {\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        if (staticInstanceName == nil) {\
            staticInstanceName = [[self alloc] init];\
        }\
    });\
    return manager;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
    static dispatch_once_t token;\
    dispatch_once(&token, ^{\
        if(staticInstanceName == nil) {\
            staticInstanceName = [super allocWithZone:zone];\
        }\
    });\
    return manager;\
}\
- (id)copy {\
    return self;\
}\
- (id)mutableCopy {\
     return self;\
}
#endif
