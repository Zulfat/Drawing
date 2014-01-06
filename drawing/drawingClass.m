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
    objects* obj = [objects sharedObjects];
    CGPoint bezierHelper1;
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint nextPoint;
    CGContextSetRGBStrokeColor(context, 255, 0, 255, 1);
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (int i=0; i<[obj.drawingObjects count];i++) {
        NSArray* pointsArray = [obj.drawingObjects objectAtIndex:i];
        for (int j=0;j<[pointsArray count]-3;j++) {
            startPoint = [[pointsArray objectAtIndex:j] CGPointValue];
//            bezierHelper1 = [[pointsArray objectAtIndex:j+1] CGPointValue];
//            bezierHelper2 = [[pointsArray objectAtIndex:j+2] CGPointValue];
            nextPoint = [[pointsArray objectAtIndex:j+2] CGPointValue];
            endPoint = [[pointsArray objectAtIndex:j+1] CGPointValue];
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            bezierHelper1 = CGPointMake(endPoint.x-(nextPoint.x-endPoint.x)/3+(startPoint.x - endPoint.x)/3, endPoint.y-(nextPoint.y-endPoint.y)/3+(startPoint.y - endPoint.y)/3);
            CGContextAddQuadCurveToPoint(context, bezierHelper1.x, bezierHelper1.y, endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
    }
}

@end
