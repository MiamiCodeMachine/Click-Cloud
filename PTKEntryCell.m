//
//  PTKEntryCell.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/5/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "PTKEntryCell.h"
#import "CommonDrawing.h"

@implementation PTKEntryCell
@synthesize photoImageView;
@synthesize titleTextField;
@synthesize subtitleLabel;
@synthesize warningImageView;

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [UIView animateWithDuration:0.1 animations:^{
        if (editing) {
            titleTextField.enabled = YES;
            titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        } else {
            titleTextField.enabled = NO;
            titleTextField.borderStyle = UITextBorderStyleNone;
        }
    }];
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGColorRef redColor = 
//    [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
//    
//    CGContextSetFillColorWithColor(context, redColor);
//    CGContextFillRect(context, self.bounds);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef whiteColor = [UIColor colorWithRed:1.0
                                            green:1.0
                                             blue:1.0 alpha:1.0].CGColor;
    CGColorRef lightGrayColor = [UIColor colorWithRed:230.0/255.0
                                                green:230.0/255.0
                                                 blue:230.0/255.0
                                                alpha:1.0].CGColor;
//    CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1].CGColor;
    CGColorRef separatorColor = [UIColor colorWithRed:208.0/255 
                                               green:208.0/255
                                                blue:208.0/255
                                               alpha:1.0].CGColor;

    
    CGRect paperRect = self.bounds;
    drawLinearGradient(context, paperRect, whiteColor, lightGrayColor);
    
    // Stroking Paths
    
    // Add down at the bottom
//    CGRect strokeRect = CGRectInset(paperRect, 5.0, 5.0);
    CGRect strokeRect = paperRect;
    strokeRect.size.height -= 1;
    strokeRect = rectFor1PxStroke(strokeRect);

    CGContextSetStrokeColorWithColor(context, whiteColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
    
    // Separator line
    CGPoint startPoint = CGPointMake(paperRect.origin.x, 
                                     paperRect.origin.y+paperRect.size.height-1);
    CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width-1, 
                                   paperRect.origin.y + paperRect.size.height-1);
    draw1PxStroke(context, startPoint, endPoint, separatorColor);
    
    
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
