//
//  SecondViewController.h
//  DynamicPlot
//
//  Created by Елена on 18.10.12.
//  Copyright (c) 2012 Елена. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface SecondViewController : UIViewController{
    NSMutableArray *graphArray;
}

@property (strong, nonatomic) GraphView *graphView;
@end
