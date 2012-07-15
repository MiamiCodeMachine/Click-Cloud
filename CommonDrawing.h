//
//  CommonDrawing.h
//  ClickCloud
//
//  Created by Carlos Duran on 7/15/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <Foundation/Foundation.h>

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor,
                        CGColorRef endColor);

CGRect rectFor1PxStroke(CGRect rect);

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint,
                   CGColorRef color);
