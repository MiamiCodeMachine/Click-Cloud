//
//  ConflictEntry.m
//  ClickCloud
//
//  Created by Carlos Duran on 7/7/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "ConflictEntry.h"

@implementation ConflictEntry
@synthesize version = _version;
@synthesize metadata = _metadata;

-(id)initWithFileVersion:(NSFileVersion*)version metadata:(PTKMetadata*)metadata {
    if ((self = [super init])) {
        self.version = version;
        self.metadata = metadata;
    }
    return self;
}

@end
