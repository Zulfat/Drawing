//
//  drawingClass.h
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
@interface drawingClass : UIView <UIGestureRecognizerDelegate> {
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
}
@property CGPoint bezierHelper1, bezierHelper2, startPoint, endPoint;
@property (nonatomic) CGImageRef image;
@property UIColor* color;
@property float penWidth;
@property bool firstrender;
@end
