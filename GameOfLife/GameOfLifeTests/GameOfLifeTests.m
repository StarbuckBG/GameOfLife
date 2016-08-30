//
//  GameOfLifeTests.m
//  GameOfLifeTests
//
//  Created by Martin Kuvandzhiev on 8/30/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "GameOfLifeView.h"
#import "Engine.h"

@interface GameOfLifeTests : XCTestCase
{
    UIApplication * app;
    AppDelegate * delegate;
    ViewController * viewController;
}
@end

@implementation GameOfLifeTests

- (void)setUp {
    [super setUp];
    app = [UIApplication sharedApplication];
    delegate = [app delegate];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCalculationPerformance {
    
    [self measureBlock:^{
        Engine * engine = [[Engine alloc] initWithXCells:100 andYCells:100];
        [engine randomize];
        for(int i = 0; i < 100; ++i)
        {
            [engine calculateNextFrame];
        }
        
    }];
}

- (void) testEngineWith1Cell // all the cells must be dead at the end of the test
{
    Engine * engine = [[Engine alloc] initWithXCells:2 andYCells:2];
    engine.cells[0][0] = 0;
    engine.cells[0][1] = 0;
    engine.cells[1][0] = 0;
    engine.cells[1][1] = 1;
    bool testResult = true;
    [engine calculateNextFrame];
    for(int i = 0; i < engine.numberOfXCells; ++i)
    {
        for(int j = 0; j < engine.numberOfYCells; ++j)
        {
            if(engine.cells[i][j] == ALIVE) testResult = false;
        }
    }
    XCTAssertTrue(testResult);
}

- (void) testEngineWith2Cells // all the cells must be dead at the end of the test
{
    Engine * engine = [[Engine alloc] initWithXCells:2 andYCells:2];
    engine.cells[0][0] = 0;
    engine.cells[0][1] = 1;
    engine.cells[1][0] = 0;
    engine.cells[1][1] = 1;
    bool testResult = true;
    [engine calculateNextFrame];
    for(int i = 0; i < engine.numberOfXCells; ++i)
    {
        for(int j = 0; j < engine.numberOfYCells; ++j)
        {
            if(engine.cells[i][j] == ALIVE) testResult = false;
        }
    }
    XCTAssertTrue(testResult);
}

- (void) testEngineWith3Cells // all the cells must be alive at the end of the test
{
    Engine * engine = [[Engine alloc] initWithXCells:2 andYCells:2];
    engine.cells[0][0] = 0;
    engine.cells[0][1] = 1;
    engine.cells[1][0] = 1;
    engine.cells[1][1] = 1;
    bool testResult = true;
    [engine calculateNextFrame];
    for(int i = 0; i < engine.numberOfXCells; ++i)
    {
        for(int j = 0; j < engine.numberOfYCells; ++j)
        {
            if(engine.cells[i][j] == DEAD) testResult = false;
        }
    }
    XCTAssertTrue(testResult);
}

- (void) testEngineWith4Cells // all the cells must be alive at the end of the test
{
    Engine * engine = [[Engine alloc] initWithXCells:2 andYCells:2];
    engine.cells[0][0] = 1;
    engine.cells[0][1] = 1;
    engine.cells[1][0] = 1;
    engine.cells[1][1] = 1;
    bool testResult = true;
    [engine calculateNextFrame];
    for(int i = 0; i < engine.numberOfXCells; ++i)
    {
        for(int j = 0; j < engine.numberOfYCells; ++j)
        {
            if(engine.cells[i][j] == DEAD) testResult = false;
        }
    }
    XCTAssertTrue(testResult);
}

- (bool) testEqualityBetweenCells: (bool **) cells1 andCells: (bool [10][10]) cells2 withXSize: (NSInteger) xSize andYSize: (NSInteger) ySize
{
    for(int x = 0; x < xSize; ++x)
    {
        for(int y = 0; y < ySize; ++y)
        {
            if(cells1[x][y] == cells2[x][y]) continue;
            else
            {
                return false;
            }
        }
    }
    return true;
}

- (void) testMultipleGenerations // this test will check multiple generations
{
    Engine * engine = [[Engine alloc] initWithXCells:10 andYCells:10];
    bool initialCells[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,1,0,1,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    for(int xCoord = 0; xCoord < engine.numberOfXCells; ++xCoord)
    {
        for(int yCoord = 0; yCoord < engine.numberOfYCells; ++yCoord)
        {
            engine.cells[xCoord][yCoord] = initialCells[xCoord][yCoord];
        }
    }
    
    
    [engine calculateNextFrame];
    
    bool generation1[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,1,0,1,0,0,0,
        0,0,0,1,0,0,0,1,0,0,
        0,0,0,0,1,0,1,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation1 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
    bool generation2[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,1,1,0,1,1,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation2 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
    bool generation3[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,1,0,0,0,1,0,0,
        0,0,0,1,0,0,0,1,0,0,
        0,0,0,1,0,0,0,1,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation3 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
    bool generation4[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,1,0,1,0,1,0,0,
        0,0,1,1,1,0,1,1,1,0,
        0,0,0,1,0,1,0,1,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation4 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
    bool generation5[10][10] = {
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,1,0,0,0,0,0,1,0,
        0,0,1,0,0,0,0,0,1,0,
        0,0,1,0,0,0,0,0,1,0,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation5 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
    bool generation6[10][10] = {
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,
        0,1,1,1,0,0,0,1,1,1,
        0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0,
        0,0,0,0,0,1,0,0,0,0
    };
    
    XCTAssertTrue([self testEqualityBetweenCells:engine.cells andCells:generation6 withXSize:engine.numberOfXCells andYSize:engine.numberOfYCells]);
    
    [engine calculateNextFrame];
    
}
@end
