//
//  Engine.m
//  GameOfLife
//
//  Created by Martin Kuvandzhiev on 8/29/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import "Engine.h"

@implementation Engine

- (id) initWithXCells:(NSInteger)xCells andYCells:(NSInteger)yCells
{
    if(self = [super init])
    {
        self.numberOfXCells = xCells;
        self.numberOfYCells = yCells;
        self.cells = [self initializeMatrix:self.cells withNumberOfRows:self.numberOfXCells andWithNumberOfColumns:self.numberOfYCells];
        [self randomize];
    }
    return self;
}

- (void) calculateNextFrame
{
    bool ** nextGeneration = [self initializeMatrix:nextGeneration withNumberOfRows:self.numberOfXCells andWithNumberOfColumns:self.numberOfYCells];
    for(NSInteger currentXCell = 0; currentXCell < self.numberOfXCells; ++currentXCell)
    {
        for(NSInteger currentYCell = 0; currentYCell < self.numberOfYCells; ++currentYCell)
        {
            nextGeneration[currentXCell][currentYCell] = [self nextCellStateForCellWithXCoord:currentXCell andYCoord:currentYCell];
        }
    }
    
    free(self.cells);
    self.cells = nextGeneration;
}

- (bool) nextCellStateForCellWithXCoord: (NSInteger) xCoord andYCoord: (NSInteger) yCoord
{
    bool currentCell = self.cells[xCoord][yCoord];
    NSInteger aliveNeighbours = [self aliveNeighboursForXCoord:xCoord andYCoord:yCoord];
    
    if(currentCell == ALIVE) // cell is alive
    {
        if (aliveNeighbours < 2 || aliveNeighbours > 3) {
            return DEAD;
        }
        else
        {
            return ALIVE;
        }
        
    }
    else
    {
        if(aliveNeighbours == 3)
        {
            return ALIVE;
        }
        return DEAD;
    }
}

- (NSInteger) aliveNeighboursForXCoord: (NSInteger) xCoord andYCoord: (NSInteger) yCoord
{
    NSInteger aliveNeighbours = 0;
    
    aliveNeighbours += xCoord - 1 >= 0 ? self.cells[xCoord-1][yCoord] : 0;
    aliveNeighbours += xCoord + 1 < self.numberOfXCells ? self.cells[xCoord+1][yCoord] : 0;
    aliveNeighbours += yCoord - 1 >= 0 ? self.cells[xCoord][yCoord-1] : 0;
    aliveNeighbours += yCoord + 1 < self.numberOfYCells ? self.cells[xCoord][yCoord + 1] : 0;
    aliveNeighbours += (xCoord - 1 >= 0 && yCoord - 1 >= 0) ? self.cells[xCoord-1][yCoord-1] : 0;
    aliveNeighbours += (xCoord - 1 >= 0 && yCoord + 1 < self.numberOfYCells) ? self.cells[xCoord-1][yCoord+1] : 0;
    aliveNeighbours += (xCoord + 1 < self.numberOfXCells && yCoord+1 < self.numberOfYCells) ? self.cells[xCoord + 1] [yCoord + 1] : 0;
    aliveNeighbours += (xCoord + 1 < self.numberOfXCells && yCoord -1 >= 0) ? self.cells[xCoord+1][yCoord-1] : 0;
    
    return aliveNeighbours;
}

- (void) randomize
{
    bool ** nextGeneration = [self initializeMatrix:nextGeneration withNumberOfRows:self.numberOfXCells andWithNumberOfColumns:self.numberOfYCells];
    for(NSInteger currentXCell = 0; currentXCell < self.numberOfXCells; ++currentXCell)
    {
        for(NSInteger currentYCell = 0; currentYCell < self.numberOfYCells; ++currentYCell)
        {
            nextGeneration[currentXCell][currentYCell] = arc4random()%2;
        }
    }
    
    free(self.cells);
    self.cells = nextGeneration;
}


- (bool **) initializeMatrix: (bool **) matrix withNumberOfRows: (NSInteger) numberOfRows andWithNumberOfColumns: (NSInteger) numberOfColumns
{
    matrix = malloc (sizeof *matrix * numberOfRows);
    if(matrix)
    {
        for(int i = 0; i < numberOfRows; i++)
        {
            matrix[i] = malloc(sizeof *matrix[i] * numberOfColumns);
            for(int j = 0; j < numberOfColumns; j++) matrix[i][j] = 0;
        }
    }
    return matrix;
}


@end
