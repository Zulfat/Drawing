//
//  ViewController.h
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customGestureRecognizer.h"
#import "drawingClass.h"
@interface ViewController : UIViewController
@property (nonatomic) customGestureRecognizer* recognizer;
@property drawingClass* simple;
-(void) DrawLine;
@end
