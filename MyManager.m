//
//  MobilitureUtilities.m
//  voicesync
//
//  Created by Carlos Duran on 5/7/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//
// http://iphone.galloway.me.uk/iphone-sdktutorials/singleton-classes/

#import "MyManager.h"
#import "Constants.h"

static MyManager *sharedMyManager = nil;

@implementation MyManager

@synthesize deviceType = _deviceType;
@synthesize wifiName = _wifiName;

-(void)getDeviceName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iOS 3.2 or later.
        self.deviceType = kiPad;
    }
    else {
        // The device is an iPhone or iPod touch.
        self.deviceType = kiPhone;
    }
}


#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {

        if (sharedMyManager == nil) 
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
} 

-(id)init {
    if (self = [super init]) {
        self.wifiName = [Wifihotspot getWifiList];
        [self getDeviceName];
    }
    return self;
}

-(void)dealloc
{
    // should never be called
    
}

@end
