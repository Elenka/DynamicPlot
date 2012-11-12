//
//  FirstViewController.m
//  DynamicPlot
//
//  Created by Елена on 18.10.12.
//  Copyright (c) 2012 Елена. All rights reserved.
//

#import "FirstViewController.h"

#define kUpdateFrequency	60.0
#define lastEntrie 40.0

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize dataForPlot;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dataGenerator) userInfo:nil repeats:YES];
    contentArray = [[NSMutableArray alloc] initWithCapacity:55];
    
   
    
    xCrd = [[NSMutableArray alloc] init];
    yCrd = [[NSMutableArray alloc] init];
	for (NSInteger i = 0; i < 40; i++ ) {
		id xi = [NSNumber numberWithFloat:1+i * 0.05];
        id yi = [NSNumber numberWithFloat:1];
		[xCrd addObject: xi];
        [yCrd addObject:yi];
	}
    
    NSLog(@"---graph View");
    
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *) GraphView;
    hostingView.allowPinchScaling = NO;
    hostingView.userInteractionEnabled = NO;
    
    graph = [[CPTXYGraph alloc] initWithFrame:hostingView.bounds];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
	[graph applyTheme:theme];
	
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
	plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(4.0)];
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
    //деление
	x.majorIntervalLength		  = CPTDecimalFromString(@"0.5");
    //где проходит ось х относительно у
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
	x.minorTicksPerInterval		  = 0;
    
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    
    // 2 - Get axis set
  //  CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
        
	CPTXYAxis *y = axisSet.yAxis;
    //деление
	y.majorIntervalLength		  = CPTDecimalFromString(@"2");
	y.minorTicksPerInterval		  = 5;
    //где проходит ось у относительно х
	//y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"2");
    //y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"3");
    
	// Create a green plot area
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
	CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
	lineStyle						 = [CPTMutableLineStyle lineStyle];
	lineStyle.lineWidth				 = 3.f;
	lineStyle.lineColor				 = [CPTColor greenColor];
	lineStyle.dashPattern			 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
	dataSourceLinePlot.dataLineStyle = lineStyle;
	dataSourceLinePlot.identifier	 = @"Green Plot";
	dataSourceLinePlot.dataSource	 = self;
    
	// Put an area gradient under the plot above
	CPTColor *areaColor		  = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
	CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
	areaGradient.angle				 = -90.0f;
	areaGradientFill				 = [CPTFill fillWithGradient:areaGradient];
	dataSourceLinePlot.areaFill		 = areaGradientFill;
	dataSourceLinePlot.areaBaseValue = CPTDecimalFromString(@"1.75");
    
	// Animate in the new plot, as an example
	dataSourceLinePlot.opacity = 0.0f;
	[graph addPlot:dataSourceLinePlot];
    
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration			= 1.0f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode			= kCAFillModeForwards;
	fadeInAnimation.toValue				= [NSNumber numberWithFloat:1.0];
	[dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
	
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataGenerator{
    
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
   // NSLog(@"%@",dataForPlot);
    [graph reloadData];
}


// Implement viewDidLoad to do additional setup after loading the view.


/*
 -reloadData on the Core Plot graph (or just the particular plot) to redraw the graph, passing in the array you just added a value to in response to the -numbersForPlot:field:recordIndexRange: delegate method.
 */




#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return [dataForPlot count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	
	NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
	NSNumber *num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    
	// Green plot gets shifted above the blue
	if ( [(NSString *)plot.identifier isEqualToString:@"Green Plot"] ) {
		if ( fieldEnum == CPTScatterPlotFieldY ) {
			num = [NSNumber numberWithDouble:[num doubleValue] + 1.0];
		}
	}
	return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
	static CPTTextStyle *positiveStyle = nil;
	static CPTTextStyle *negativeStyle = nil;
    
	NSNumberFormatter *formatter = axis.labelFormatter;
	CGFloat labelOffset			 = axis.labelOffset;
	NSDecimalNumber *zero		 = [NSDecimalNumber zero];
    
	NSMutableSet *newLabels = [NSMutableSet set];
    
	for ( NSDecimalNumber *tickLocation in locations ) {
		CPTTextStyle *theLabelTextStyle;
        
		if ( [tickLocation isGreaterThanOrEqualTo:zero] ) {
			if ( !positiveStyle ) {
				CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
				newStyle.color = [CPTColor greenColor];
				positiveStyle  = newStyle;
			}
			theLabelTextStyle = positiveStyle;
		}
		else {
			if ( !negativeStyle ) {
				CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
				newStyle.color = [CPTColor redColor];
				negativeStyle  = newStyle;
			}
			theLabelTextStyle = negativeStyle;
		}
        
		NSString *labelString		= [formatter stringForObjectValue:tickLocation];
		CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        
		CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
		newLabel.tickLocation = tickLocation.decimalValue;
		newLabel.offset		  = labelOffset;
        
		[newLabels addObject:newLabel];
        
	}
    
	axis.axisLabels = newLabels;
    
	return NO;
}




-(void)configureAxes {
	// 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 1.0f;
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.title = @"Day of Month";
	x.titleTextStyle = axisTitleStyle;
	x.titleOffset = 15.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
	CGFloat dateCount = [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
	NSInteger i = 0;
	for (NSString *date in [[CPDStockPriceStore sharedInstance] datesInMonth]) {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];
		}
	}
	x.axisLabels = xLabels;
	x.majorTickLocations = xLocations;
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.title = @"Price";
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -40.0f;
	y.axisLineStyle = axisLineStyle;
	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;
	y.tickDirection = CPTSignPositive;
	NSInteger majorIncrement = 100;
	NSInteger minorIncrement = 50;
	CGFloat yMax = 700.0f;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
	for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
		NSUInteger mod = j % majorIncrement;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations;
}

-(void)viewDidUnload {
	[super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:(BOOL)animated];

}

#pragma mark - View lifecycle



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




/*
 
 -(void) accelerometerReciver:(NSNotification*)theNotice{
 [self graphDrow:( (CMAccelerometerData*)[theNotice.userInfo objectForKey:@"accel"] ).acceleration];
 }
 
 -(void) motionReciver:(NSNotification*)theNotice{
 CMAcceleration acc;
 acc.x=( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).gravity.x+( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).userAcceleration.x;
 acc.y=( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).gravity.y+( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).userAcceleration.y;
 acc.z=( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).gravity.z+( (CMDeviceMotion*)[theNotice.userInfo objectForKey:@"motion"]).userAcceleration.z;
 [self graphDrow:acc];
 }
 
 */









@end
