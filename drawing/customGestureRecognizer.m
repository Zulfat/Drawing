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
    objects* obj = [objects sharedObjects];
    if (obj.drawingObjects)
        obj.drawingObjects = nil;
    obj.drawingObjects = [[NSMutableArray alloc] init];
    obj.stoped = false;
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    [obj.drawingObjects addObject:[NSValue valueWithCGPoint:nowPoint]];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    objects* obj = [objects sharedObjects];
    [obj.drawingObjects addObject:[NSValue valueWithCGPoint:nowPoint]];
    if ([obj.drawingObjects count]>=3)
        self.state = UIGestureRecognizerStateChanged;
    if ([obj.drawingObjects count] >=50) {
        obj.stoped = true;
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    objects* obj  = [objects sharedObjects];
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
    [obj.drawingObjects addObject:[NSValue valueWithCGPoint:nowPoint]];
    obj.stoped = true;
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
