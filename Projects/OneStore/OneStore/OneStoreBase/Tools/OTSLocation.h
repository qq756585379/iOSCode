//
//  OTSLocation.h
//  OneStoreFramework
//

#import <Foundation/Foundation.h>
@class CLPlacemark;
@class CLLocation;

//加个addressDictionary方便模拟数据
typedef void (^OTSCLManagerCompleteBlock)(CLPlacemark *mark, NSDictionary *addressDictionary, CLLocation *aLocation);

@interface OTSLocation : NSObject

- (void)start;
- (void)startWithCompleteBlock:(OTSCLManagerCompleteBlock)block;
- (void)stop;

@end
