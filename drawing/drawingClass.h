//
//  drawingClass.h
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawingClass : UIView <UIGestureRecognizerDelegate>
@property CGPoint bezierHelper1, bezierHelper2, startPoint, endPoint;
@property (nonatomic) UIImage* image;
@property UIColor* color;
@property float penWidth;
@end
