//
//  ViewController.m
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import "ViewController.h"
#import "drawingClass.h"
#import "customGestureRecognizer.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize recognizer,simple;
- (void)viewDidLoad
{
    [super viewDidLoad];
    simple  = [[drawingClass alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:simple];
    recognizer = [[customGestureRecognizer alloc] initWithTarget:self action:@selector(DrawLine)];
    [self.view addGestureRecognizer:recognizer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) DrawLine{
    CGPoint bezierHelper1;
    CGPoint bezierHelper2;
    CGPoint startPoint;
    CGPoint endPoint;
    if ([recognizer.points count]>=4) {
        endPoint = [[recognizer.points objectAtIndex:[recognizer.points count]-1] CGPointValue];
        
        bezierHelper2 = [[recognizer.points objectAtIndex:[recognizer.points count]-2] CGPointValue];
        
        bezierHelper1 = [[recognizer.points objectAtIndex:[recognizer.points count]-3] CGPointValue];
        
        startPoint = [[recognizer.points objectAtIndex:[recognizer.points count]-4] CGPointValue];
        simple.bezierHelper1=bezierHelper1;
        simple.bezierHelper2=bezierHelper2;
        simple.startPoint=startPoint;
        simple.endPoint=endPoint;
    }
    [simple setNeedsDisplay];
}
@end
