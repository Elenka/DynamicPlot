//
//  SecondViewController.m
//  DynamicPlot
//
//  Created by Елена on 18.10.12.
//  Copyright (c) 2012 Елена. All rights reserved.
//

#import "SecondViewController.h"



@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize graphView = _graphView;

- (void)viewDidLoad
{
    [self dataGenerator];
    _graphView = [[GraphView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 500, 700)];
    [_graphView setDefaultColor:[UIColor redColor]];
    
    
    //request - set array
    [_graphView setDefaultArray: graphArray];
    
    [_graphView setDefaultGradientBool: YES];
    
    [_graphView setDefaultDashWidth:0.0f];

    [self.view addSubview:_graphView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataGenerator{
    graphArray = [[NSMutableArray alloc] initWithCapacity:20];
    for (NSInteger i = 0; i < 19; i++ ) {
        [graphArray addObject:[NSNumber numberWithFloat:0.5]];
	}

}



@end
