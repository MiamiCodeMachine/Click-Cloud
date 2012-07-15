//
//  PTKEntry.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/4/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "PTKEntry.h"

@implementation PTKEntry
@synthesize fileURL = _fileURL;
@synthesize metadata = _metadata;
@synthesize state = _state;
@synthesize version = _version;

- (id)initWithFileURL:(NSURL *)fileURL metadata:(PTKMetadata *)metadata state:(UIDocumentState)state version:(NSFileVersion *)version {
    
    if ((self = [super init])) {
        self.fileURL = fileURL;
        self.metadata = metadata;
        self.state = state;
        self.version = version;
    }
    return self;
    
}

- (NSString *) description {
    return [[self.fileURL lastPathComponent] stringByDeletingPathExtension];
}
@end
