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
    CGPoint bezierHelper2;
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint nextPoint;
    double dx,dy;
    double Aix,Bi,Aiy;
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (int i=0; i<[obj.drawingObjects count];i++) {
        NSArray* pointsArray = [obj.drawingObjects objectAtIndex:i];
        Aix=([[pointsArray objectAtIndex:2] CGPointValue].x-[[pointsArray objectAtIndex:0] CGPointValue].x)/4;
        Aiy=([[pointsArray objectAtIndex:2] CGPointValue].y-[[pointsArray objectAtIndex:0] CGPointValue].y)/4;
        dx=1;
        dy=1;
        Bi=-0.25;
        for (int j=0;j<[pointsArray count]-2;j++) {
            startPoint = [[pointsArray objectAtIndex:j] CGPointValue];
            endPoint = [[pointsArray objectAtIndex:j+1] CGPointValue];
            nextPoint = [[pointsArray objectAtIndex:j+2] CGPointValue];
            bezierHelper1 = CGPointMake(startPoint.x - dx, startPoint.y - dy);
            Bi = -1/(4+Bi);
            Aix=(nextPoint.x-startPoint.x-Aix)/(4+Bi);
            dx=Aix+Bi*dx;
            Aiy=(nextPoint.y-startPoint.y-Aiy)/(4+Bi);
            dy=Aix+Bi*dy;
            bezierHelper2 = CGPointMake(startPoint.x+dx,startPoint.y+dy);
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
