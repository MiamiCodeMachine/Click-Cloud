//
//  PTKEntry.h
//  Click Cloud
//
//  Created by Carlos Duran on 7/4/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTKMetadata;

@interface PTKEntry : NSObject

@property (strong) NSURL *fileURL;
@property (strong) PTKMetadata *metadata;
@property (assign) UIDocumentState state;
@property (strong) NSFileVersion *version;

- (id)initWithFileURL:(NSURL *)fileURL metadata:(PTKMetadata *)metadata state:(UIDocumentState)state version:(NSFileVersion *)version;
- (NSString *) description;

@end
