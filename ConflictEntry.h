//
//  ConflictEntry.h
//  ClickCloud
//
//  Created by Carlos Duran on 7/7/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTKMetadata;

@interface ConflictEntry : NSObject

@property (strong) NSFileVersion *version;
@property (strong) PTKMetadata *metadata;

-(id)initWithFileVersion:(NSFileVersion*)version metadata:(PTKMetadata*)metadata;

@end
