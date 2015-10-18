//
//  LifeContainerBridge.m
//  reactconway
//
//  Created by Andy Bartholomew on 10/17/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(LifeController, NSObject)

RCT_EXTERN_METHOD(nextBoardAsync:(NSArray *)cells completion:(RCTResponseSenderBlock)completion)

@end