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
    
    _graphView = [[GraphView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [_graphView setDefaultColor:[UIColor whiteColor]];
    graphArray = [[NSMutableArray alloc] initWithCapacity:55];
    
    //request - set array
    //[_graphView setDefaultArray:_array];
    
    [_graphView setDefaultGradientBool:YES];
    
    [_graphView setDefaultDashWidth:2.0f];
    [self.view addSubview:_graphView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initial{
    hostingView = (CPTGraphHostingView *) GraphView;
    //!!  hostingView.allowPinchScaling = NO;
    //!!  hostingView.userInteractionEnabled = NO;
    
    graph = [[CPTXYGraph alloc] initWithFrame:hostingView.bounds];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
	[graph applyTheme:theme];
    
    
    
    // graph.imageOfLayer = [UIImage imageNamed:@"Default.png"];
	hostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
	hostingView.hostedGraph		= graph;
    
	graph.paddingLeft	= 5.0;
	graph.paddingTop	= 5.0;
	graph.paddingRight	= 5.0;
	graph.paddingBottom = 5.0;
    
	// Setup plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
    
    //графа по х от, сколько
	plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(2.0)];
    //графа по у от, сколько
	plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1.0) length:CPTDecimalFromFloat(6.0)];
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
    //деление
	x.majorIntervalLength		  = CPTDecimalFromString(@"0.5");
    
    //где проходит ось х относительно у
	//x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
	x.minorTicksPerInterval		  = 0;
    
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    
    
	CPTXYAxis *y = axisSet.yAxis;
    //деление
	y.majorIntervalLength		  = CPTDecimalFromString(@"0.3");
	y.minorTicksPerInterval		  = 10;
    
    
    
    //где проходит ось у относительно х
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"-2");
    //y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"3");
    
	// Create a green plot area
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
	CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
	//lineStyle						 = [CPTMutableLineStyle lineStyle];
	lineStyle.lineWidth				 = 3.f;
	lineStyle.lineColor				 = [CPTColor redColor];
	dataSourceLinePlot.dataLineStyle = lineStyle;
	dataSourceLinePlot.identifier	 = @"Green Plot";
	dataSourceLinePlot.dataSource	 = self;
    
    
    
	// Animate in the new plot, as an example
	dataSourceLinePlot.opacity = 0.0f;
	[graph addPlot:dataSourceLinePlot];
    
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration			= 1.0f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode			= kCAFillModeForwards;
	fadeInAnimation.toValue				= [NSNumber numberWithFloat:1.0];
	[dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
    y.majorGridLineStyle = gridLineStyle;
    
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
    // NSInteger majorIncrement = 3;
	//NSInteger minorIncrement = 1;
	CGFloat yMax = 5.0f;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	for (float j=0; j<=yMax; j+=0.5f){
        NSDecimal location = CPTDecimalFromInteger(j);
        [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        NSLog(@"%f",j);
	}
    
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;

}

- (void) generator{
        // Add some initial data
        
        // NSLog(@"size yCrd = %i", [yCrd count]);
        [yCrd removeObjectAtIndex:0];
        // NSLog(@"size yCrd = %i", [yCrd count]);
        [yCrd addObject:[NSNumber numberWithFloat:1.2 * rand() / (float)RAND_MAX + 1.2]];
        [contentArray removeAllObjects];
        for (NSInteger i = 0; i < 39; i++ ) {
            id y =[yCrd objectAtIndex:i+1];
            [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[xCrd objectAtIndex:i], @"x", y, @"y", nil]];
        }
        
        self.dataForPlot = contentArray;
        //  NSLog(@"%@",dataForPlot);
        [graph reloadData];
}

@end
