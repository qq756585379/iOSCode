
// .h文件
#define HMSingletonH +(instancetype)sharedInstance;

// .m文件
#define HMSingletonM \
static id _instance = nil; \
+(id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+(instancetype)sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
-(id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
