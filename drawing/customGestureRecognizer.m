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
    if (!_points)
        self.points = [[NSMutableArray alloc] init];
    else
        _points=nil;//->reset
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    [_points addObject:[NSValue valueWithCGPoint:nowPoint]];
    //self.state = UIGestureRecognizerStateRecognized;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    [_points addObject:[NSValue valueWithCGPoint:nowPoint]];
    objects* obj = [objects sharedObjects];
    [obj.drawingObjects replaceObjectAtIndex:[obj.drawingObjects count]-1 withObject:_points];
    if ([_points count]>=4)
        self.state = UIGestureRecognizerStateChanged;
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
