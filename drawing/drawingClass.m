//
//  drawingClass.m
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import "drawingClass.h"
#import "objects.h"
@implementation drawingClass
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect); // Очистим context
    
//    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
//    CGContextFillRect(context, CGRectMake(20, 20, 100, 100));
//    CGContextSetRGBStrokeColor(context, 255, 0, 255, 1);
//    CGContextBeginPath(context);
//        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
//        CGContextAddCurveToPoint(context,
//                             bezierHelper1.x, bezierHelper1.y,
//                             bezierHelper2.x, bezierHelper2.y,
//                             endPoint.x, endPoint.y);
//        CGContextStrokePath(context);
    objects* obj = [objects sharedObjects];
    CGPoint bezierHelper1;
    CGPoint bezierHelper2;
    CGPoint startPoint;
    CGPoint endPoint;
    for (int i=0; i<[obj.drawingObjects count];i++) {
        NSArray* pointsArray = [obj.drawingObjects objectAtIndex:i];
        for (int j=0;j<[pointsArray count]-3;j+=3) {
            startPoint = [[pointsArray objectAtIndex:j] CGPointValue];
            bezierHelper1 = [[pointsArray objectAtIndex:j+1] CGPointValue];
            bezierHelper2 = [[pointsArray objectAtIndex:j+2] CGPointValue];
            endPoint = [[pointsArray objectAtIndex:j+3] CGPointValue];
            CGContextSetRGBStrokeColor(context, 255, 0, 255, 1);
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            CGContextAddCurveToPoint(context,
                                     bezierHelper1.x, bezierHelper1.y,
                                     bezierHelper2.x, bezierHelper2.y,
                                     endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
    }
}

@end
