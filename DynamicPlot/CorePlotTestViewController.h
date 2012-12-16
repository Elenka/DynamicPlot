//
//  CorePlotTestViewController.h
//  CorePlotTest
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface CorePlotTestViewController : UIViewController <CPPlotDataSource>
{
	CPXYGraph *graph;
}

@end

