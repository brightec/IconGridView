//
//  HorizontalGridController.m
//  gridview
//
//  Created by Cameron Cooke on 29/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HorizontalGridController.h"


// private interface
@interface HorizontalGridController ()
@property (weak, nonatomic) IconGridView *gridView;
@end


@implementation HorizontalGridController


@synthesize gridView = _gridView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Horizontal Grid";
    }
    return self;
}


-(void)loadView {
    IconGridView *gridView = [[IconGridView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] numberOfIcons:87 orientation:IconGridOrientationHorizontal];
    gridView.datasource = self;
    gridView.gridDelegate = self;
    gridView.delegate = self;
    gridView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.view = gridView;    
    self.gridView = gridView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.gridView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - DataSource


- (UIImage *)iconGridView:(IconGridView *)gridView imageForCellWithIndex:(NSInteger)cellIndex {
    return [UIImage imageNamed:@"piggy-bank.png"];    
}


- (NSString *)iconGridView:(IconGridView *)gridView titleForCellWithIndex:(NSInteger)cellIndex {
    return [NSString stringWithFormat:@"Icon %i", cellIndex];
}


#pragma mark - Delegate


- (void)iconGridView:(IconGridView *)gridView didSelectRowAtCellIndex:(NSInteger)cellIndex {
    NSLog(@"Did select cell: %i", cellIndex);
}


@end