//
//  MobilitureUtilities.h
//  voicesync
//
//  Created by Carlos Duran on 5/7/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Wifihotspot.h"

@interface MyManager : NSObject
{
    DeviceType _deviceName;
    NSString *_wifiName;
}

@property (nonatomic, assign) DeviceType deviceType;
@property (nonatomic, strong) NSString *wifiName;


+(id)sharedManager;

@end
