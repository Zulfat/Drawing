//
//  customGestureRecognizer.m
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import "customGestureRecognizer.h"
#import "objects.h"
@implementation customGestureRecognizer
- (void)reset {
    [super reset];
    self.points = nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_points)
        _points=nil;//->reset
    self.points = [[NSMutableArray alloc] init];
    _prevTime = [NSDate date];
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    [_points addObject:[NSValue valueWithCGPoint:nowPoint]];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    double interval = [[NSDate date] timeIntervalSinceDate:_prevTime];
    if (interval>=0.0002) {
        CGPoint nowPoint = [touches.anyObject locationInView:self.view];
        [_points addObject:[NSValue valueWithCGPoint:nowPoint]];
        objects* obj = [objects sharedObjects];
        [obj.drawingObjects replaceObjectAtIndex:[obj.drawingObjects count]-1 withObject:_points];
        if ([_points count]>=4)
            self.state = UIGestureRecognizerStateChanged;
        _prevTime = [NSDate date];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    objects* obj  = [objects sharedObjects];
    [obj addObject:_points];
    self.state = UIGestureRecognizerStateRecognized;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateRecognized;
}
-(NSArray*) points {
    return _points;
}
@end
