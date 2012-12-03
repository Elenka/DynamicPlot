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
    [super viewDidLoad];
    _graphView = [[GraphView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [_graphView setDefaultColor:[UIColor whiteColor]];
    //request - set array
    //[_graphView setDefaultArray:_array];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
