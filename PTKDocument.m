//
//  PTKDocument.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "PTKDocument.h"
#import "PTKData.h"
#import "PTKMetadata.h"
#import "UIImageExtras.h"

#define METADATA_FILENAME @"photo_metadata"
#define DATA_FILENAME @"photo.data"

@interface PTKDocument()
@property (nonatomic, strong) PTKData *data;
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@end

@implementation PTKDocument
@synthesize data = _data;
@synthesize fileWrapper = _fileWrapper;
@synthesize metadata = _metadata;

- (void)encodeObject:(id<NSCoding>)object toWrappers:(NSMutableDictionary *)wrappers preferredFilename:(NSString *)preferredFilename {
    @autoreleasepool {            
        NSMutableData * data = [NSMutableData data];
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:object forKey:@"data"];
        [archiver finishEncoding];
        NSFileWrapper * wrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
        [wrappers setObject:wrapper forKey:preferredFilename];
    }
}

-(id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    if (self.metadata == nil || self.data == nil) {
        return nil;
    }
    
    NSMutableDictionary *wrappers = [NSMutableDictionary dictionary];
    [self encodeObject:self.metadata toWrappers:wrappers preferredFilename:METADATA_FILENAME];
    [self encodeObject:self.data toWrappers:wrappers preferredFilename:DATA_FILENAME];
    NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:wrappers];
    
    return fileWrapper;
}
-(id)decodeObjectFromWrapperWithPreferredFileName:(NSString *)preferredFilename {
    NSFileWrapper *fileWrapper = [self.fileWrapper.fileWrappers objectForKey:preferredFilename];
    if (!fileWrapper) {
        NSLog(@"Unexpected error: Couldn't find %@ in file wrapper!", preferredFilename);
        return nil;
    }
    
    NSData *data = [fileWrapper regularFileContents];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    return [unarchiver decodeObjectForKey:@"data"];
    
}

-(PTKMetadata *)metadata {
    if (_metadata == nil) {
        if (self.fileWrapper != nil) {
            self.metadata = [self decodeObjectFromWrapperWithPreferredFileName:METADATA_FILENAME];
        } else {
            self.metadata = [[PTKMetadata alloc] init];
        }
    }
return _metadata;
}

-(PTKData *)data {
    if (_data == nil) {
        if (self.fileWrapper != nil) {
            self.data = [self decodeObjectFromWrapperWithPreferredFileName:DATA_FILENAME];
        } else {
            self.data = [[PTKData alloc] init];
        }
    }
    return _data;
}

-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    self.fileWrapper = (NSFileWrapper *)contents;
    
    // The rest will be lazy loaded
    self.data = nil;
    self.metadata = nil;
    
    return YES;
}

-(NSString *)description {
    return [[self.fileURL lastPathComponent] stringByDeletingPathExtension];
}

#pragma mark Accessors

-(UIImage*)photo {
    return self.data.photo;
}

-(void)setPhoto:(UIImage *)photo {

    if ([self.data.photo isEqual:photo]) return;
    
    UIImage *oldPhoto = self.data.photo;
    self.data.photo = photo;
    self.metadata.thumbnail = [self.data.photo imageByScalingAndCroppingForSize:CGSizeMake(145, 145)];
    
    [self.undoManager setActionName:@"Image Change"];
    [self.undoManager registerUndoWithTarget:self selector:@selector(setPhoto) object:oldPhoto];
}




































@end
