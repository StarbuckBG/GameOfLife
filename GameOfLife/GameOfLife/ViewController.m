//
//  ViewController.m
//  GameOfLife
//
//  Created by Martin Kuvandzhiev on 8/29/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

#import "ViewController.h"
#import "GameOfLifeView.h"

#define SLIDER_VALUE_MULTIPLIER 8
@interface ViewController ()
@property (weak, nonatomic) IBOutlet GameOfLifeView *GameOfLifeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.GameOfLifeView randomize];
    [self.GameOfLifeView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextGenButtonClicked:(UIButton *)sender {
    [self.GameOfLifeView calculateAndPresentNextGeneration];
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.GameOfLifeView.sizeOfPixel = (int)sender.value * SLIDER_VALUE_MULTIPLIER;
}

@end
