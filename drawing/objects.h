//
//  objects.h
//  drawing
//
//  Created by Zulfat on 04.01.14.
//  Copyright (c) 2014 Zulfat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objects : NSObject
@property NSMutableArray* drawingObjects;
-(void) addObject:(NSMutableArray*)pointsArray;
+(objects*) sharedObjects;
@end
