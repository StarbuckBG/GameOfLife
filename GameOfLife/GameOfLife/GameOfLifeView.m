//
//  GameOfLifeView.m
//  GameOfLife
//
//  Created by Martin Kuvandzhiev on 8/29/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import "GameOfLifeView.h"

@interface GameOfLifeView()
@property (nonatomic, strong) Engine * engine;
@end


@implementation GameOfLifeView

#pragma mark - UIView overridden methods
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.sizeOfPixel = 20;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if(self.engine == nil)
    {
        self.engine = [[Engine alloc] initWithXCells:rect.size.width/self.sizeOfPixel andYCells:rect.size.height/self.sizeOfPixel];
    }
    [self drawGrid];
}

#pragma mark - custom getters/setters
- (void) setSizeOfPixel:(NSInteger)sizeOfPixel
{
    _sizeOfPixel = sizeOfPixel;
    self.engine = nil; // in order to force reinit of the engine
    [self setNeedsDisplay];
}


#pragma mark - custom methods

- (void) calculateAndPresentNextGeneration
{
    [self.engine calculateNextFrame];
    [self drawGrid];
}

- (void) drawGrid
{
    UIBezierPath * alivePaths = [[UIBezierPath alloc] init];
    UIBezierPath * deadPaths = [[UIBezierPath alloc] init];
    
    
    for(int currentXCell = 0; currentXCell < self.engine.numberOfXCells; ++currentXCell)
    {
        for(int currentYCell = 0; currentYCell < self.engine.numberOfYCells; ++currentYCell)
        {
            UIBezierPath * drawingPaths;
            if(self.engine.cells[currentXCell][currentYCell] == ALIVE)
            {
                drawingPaths = alivePaths;
                [[UIColor blackColor] setFill];
            }
            else
            {
                drawingPaths = deadPaths;
                [[UIColor redColor] setFill];
            }
            
            [drawingPaths setLineWidth:1];
            
            [drawingPaths moveToPoint:CGPointMake(currentXCell*self.sizeOfPixel, currentYCell*self.sizeOfPixel)];
            [drawingPaths addLineToPoint:CGPointMake((currentXCell+1)*self.sizeOfPixel, currentYCell*self.sizeOfPixel)];
            [drawingPaths addLineToPoint:CGPointMake((currentXCell+1)*self.sizeOfPixel, (currentYCell+1)*self.sizeOfPixel)];
            [drawingPaths addLineToPoint:CGPointMake((currentXCell)*self.sizeOfPixel, (currentYCell+1)*self.sizeOfPixel)];
            [drawingPaths closePath];
            [drawingPaths fill];
        }
    }
    [self setNeedsDisplay];
}

- (void) randomize
{
    [self.engine randomize];
    [self setNeedsDisplay];
}





@end
