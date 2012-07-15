//
//  PTKData.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "PTKData.h"

@implementation PTKData
@synthesize photo = _photo;

-(id)initWithPhoto:(UIImage *)photo {
    if ((self = [super init])) {
        self.photo = photo;
    }
    return self;
}

-(id)init {
    return [self initWithPhoto:nil];
}

#pragma mark  NSCoding

#define kVersionKey @"Version"
#define kPhotoKey @"Photo"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:1 forKey:kVersionKey];
    NSData *photoData = UIImagePNGRepresentation(self.photo);
    [aCoder encodeObject:photoData forKey:kPhotoKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    [aDecoder decodeIntForKey:kVersionKey];
    NSData *photoData = [aDecoder decodeObjectForKey:kPhotoKey];
    UIImage *photo = [UIImage imageWithData:photoData];
    
    return [self initWithPhoto:photo];
}

@end
