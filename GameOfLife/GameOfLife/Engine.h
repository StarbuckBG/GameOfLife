//
//  Engine.h
//  GameOfLife
//
//  Created by Martin Kuvandzhiev on 8/29/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject
#define DEAD false
#define ALIVE true

@property (atomic, assign) bool ** cells;
@property (nonatomic, assign) NSInteger numberOfXCells;
@property (nonatomic, assign) NSInteger numberOfYCells;

- (id) initWithXCells:(NSInteger) xCells andYCells:(NSInteger) yCells;
- (void) calculateNextFrame;
- (void) randomize;


@end
