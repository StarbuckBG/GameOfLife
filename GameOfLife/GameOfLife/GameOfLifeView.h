//
//  GameOfLifeView.h
//  GameOfLife
//
//  Created by Martin Kuvandzhiev on 8/29/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Engine.h"


@interface GameOfLifeView : UIView


@property (nonatomic, assign) NSInteger sizeOfPixel;
- (void) calculateAndPresentNextGeneration;
- (void) randomize;
@end
