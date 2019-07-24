#ifndef _APMACROHELPER_HEADER_
#define _APMACROHELPER_HEADER_

#define weakSelf(obj) __weak typeof(self) obj = self

#define MAKE_CLASS_SINGLETON(className, staticInstanceName, methodName) \
static className *staticInstanceName = nil;\
+ (instancetype)methodName {\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        if (staticInstanceName == nil) {\
            staticInstanceName = [[self alloc] init];\
        }\
    });\
    return staticInstanceName;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
    static dispatch_once_t token;\
    dispatch_once(&token, ^{\
        if(staticInstanceName == nil) {\
            staticInstanceName = [super allocWithZone:zone];\
        }\
    });\
    return staticInstanceName;\
}\
- (id)copy {\
    return self;\
}\
- (id)mutableCopy {\
     return self;\
}
#endif
