//
//  objects.m
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import "objects.h"

@implementation objects
+(objects *)sharedObjects {
    
    static objects  * instance;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[objects alloc] init];
            //[instance prepareInstance];
        }
    }
    
    return instance;
}

-(void) addObject:(NSMutableArray *)pointsArray {
    if (!_drawingObjects) {
        _drawingObjects =[[NSMutableArray alloc] init];
    }
    [_drawingObjects addObject:pointsArray];
}
@end
