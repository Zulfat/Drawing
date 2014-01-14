//
//  drawingClass.m
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import "drawingClass.h"
#import "objects.h"
#import <QuartzCore/QuartzCore.h>
#include <math.h>
@implementation drawingClass
@synthesize penWidth, color,firstrender;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        firstrender = true;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // получаем контекст для рисования и объект рисования
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect); // Очистим context
    objects* obj = [objects sharedObjects];
    
    // три точки по которым рисуется кривая
    CGPoint middlePoint;
    CGPoint startPoint;
    CGPoint endPoint;
    
    //инициализация context
    CGFloat red, green, blue,alpha;
    [color getRed:&red green:&green blue:&blue  alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red,green, blue, 0.8);
    CGContextSetLineWidth(context, penWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    // загрузка фона
    if (_image) {
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, rect, _image);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);

    }
    
    //прорисовка точек как кривой
    NSArray* pointsArray = obj.drawingObjects;
    int k = [pointsArray count];
    for (int j=1;pointsArray && j<k-3;j++) {
        startPoint = [[pointsArray objectAtIndex:j-1] CGPointValue];
        endPoint = [[pointsArray objectAtIndex:j+1] CGPointValue];
        middlePoint = [[pointsArray objectAtIndex:j] CGPointValue];
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, (middlePoint.x + startPoint.x)/2, (middlePoint.y + startPoint.y)/2);
        
            CGContextAddQuadCurveToPoint(context, middlePoint.x,middlePoint.y,
                                (endPoint.x + middlePoint.x)/2, (endPoint.y + middlePoint.y)/2);
        CGContextStrokePath(context);
    }
    
    // случай когда нарисована точка
    if (k==1 || k==2 ) {
        CGContextAddArc(context,[[pointsArray objectAtIndex:0] CGPointValue].x, [[pointsArray objectAtIndex:0] CGPointValue].y, 1, 0, 2*M_PI, YES);
        CGContextStrokePath(context);
    }
    
    //если участок кривой отрисован, то сохраняем результат в self.image и загружаем последние точки в drawingObjects для непрырывности кривой
    if (obj.stoped) {
        if (_image)
            CFRelease(_image);
        _image = nil;
        [self.layer renderInContext:context];
        _image = CGBitmapContextCreateImage(context);
        obj.drawingObjects=nil;
        obj.stoped = false;
        obj.drawingObjects = [[NSMutableArray alloc] init];
        if (k>=4) {
            [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-4]];
            [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-3]];
            [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-2]];
            [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-1]];
        }
    }
}

@end
