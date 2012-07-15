//
//  Wifihotspot.m
//  TestFfmpeg
//
//  Created by Carlos Duran on 5/4/12.
//  Copyright (c) 2012 Legis Marketing. All rights reserved.
// 
// http://stackoverflow.com/questions/4712535/how-do-i-use-captivenetwork-to-get-the-current-wifi-hotspot-name

#import <SystemConfiguration/CaptiveNetwork.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#import "Wifihotspot.h"

@implementation Wifihotspot 

+(NSString*)getWifiList
{
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));

    NSDictionary *wifiDict = (__bridge NSDictionary*)myDict;
    NSString *hostspotName = [wifiDict objectForKey:@"SSID"];
    
    if (myArray) CFRelease(myArray);
    if (myDict) CFRelease(myDict);
    
    return hostspotName;
}


@end
