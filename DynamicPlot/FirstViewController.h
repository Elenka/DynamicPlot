//
//  FirstViewController.h
//  DynamicPlot
//
//  Created by Елена on 18.10.12.
//  Copyright (c) 2012 Елена. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface FirstViewController : UIViewController <CPTPlotDataSource, CPTAxisDelegate>{
    NSMutableArray *plotData;
    
}

-(void)dataGenerator;





@end
