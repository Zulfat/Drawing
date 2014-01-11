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
@synthesize penWidth, color;
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
-(void) initContext: (CGContextRef) context {
    float red, green, blue,alpha;
    [color getRed:&red green:&green blue:&blue  alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red,green, blue, alpha);
    CGContextSetLineWidth(context, penWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect); // Очистим context
    objects* obj = [objects sharedObjects];
    CGPoint middlePoint;
    CGPoint startPoint;
    CGPoint endPoint;
    [self initContext:context];
    CGContextSetFillColorWithColor(context,[[UIColor whiteColor] CGColor]);
    if (_image) {
      CGContextSetFillColorWithColor(context, [[UIColor colorWithPatternImage:_image] CGColor]);
    }
    CGContextFillRect(context, rect);
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
    if (k==1 || k==2 ) {
        CGContextAddArc(context,[[pointsArray objectAtIndex:0] CGPointValue].x, [[pointsArray objectAtIndex:0] CGPointValue].y, 1, 0, 2*M_PI, YES);
        CGContextStrokePath(context);
    }
    if (obj.stoped) {
        UIGraphicsBeginImageContext(rect.size);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        _image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        obj.drawingObjects=nil;
        obj.stoped = false;
        obj.drawingObjects = [[NSMutableArray alloc] init];
        [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-4]];
        [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-3]];
        [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-2]];
        [obj.drawingObjects addObject:[pointsArray objectAtIndex:[pointsArray count]-1]];
        //UIImageWriteToSavedPhotosAlbum(_image, self, nil, nil);
    }
}

@end
