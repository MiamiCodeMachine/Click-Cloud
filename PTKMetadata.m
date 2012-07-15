//
//  PTKMetadata.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "PTKMetadata.h"

@implementation PTKMetadata
@synthesize thumbnail = _thumbnail;

-(id)initWithThumbnail:(UIImage *)thumbnail {

    if ((self = [super init])) {
        
        self.thumbnail = thumbnail;
    }
    return self;
}

-(id)init {
    return [self initWithThumbnail:nil];
}

#pragma mark NSCoding

#define kVersioningKey  @"Version"
#define kThumbnailKey   @"Thumbnail"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:1 forKey:kVersioningKey];
    NSData *thumbnailData =  UIImagePNGRepresentation(self.thumbnail);
    [aCoder encodeObject:thumbnailData forKey:kThumbnailKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    [aDecoder decodeIntForKey:kVersioningKey];
    NSData *thumbnailData = [aDecoder decodeObjectForKey:kThumbnailKey];
    UIImage *thumbnail = [UIImage imageWithData:thumbnailData];

    return [self initWithThumbnail:thumbnail];
}



@end
