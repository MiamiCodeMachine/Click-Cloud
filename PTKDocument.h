//
//  PTKDocument.h
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTKData;
@class PTKMetadata;

#define PTK_EXTENSION @"ptk"

@interface PTKDocument : UIDocument

// Data
-(UIImage *)photo;
-(void)setPhoto:(UIImage *)photo;

// Metadata
@property (nonatomic, strong) PTKMetadata *metadata;
-(NSString *) description;

@end
