//
//  PagedGridController.m
//  gridview
//
//  Created by Cameron Cooke on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PagedGridController.h"

// private interface
@interface PagedGridController ()
@property (weak, nonatomic) IconGridView *gridView1;
@property (weak, nonatomic) IconGridView *gridView2;
@end


@implementation PagedGridController


@synthesize gridView1 = _gridView1;
@synthesize gridView2 = _gridView2;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Paged Grid";
    }
    return self;
}


-(void)loadView {
    
    UIView *rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    
    
    CGRect grid1Frame = CGRectMake(10, 10, 300, 168);
    
    IconGridView *gridView1 = [[IconGridView alloc] initWithFrame:grid1Frame numberOfIcons:28 orientation:IconGridOrientationHorizontal];
    gridView1.datasource = self;
    gridView1.gridDelegate = self;
    gridView1.delegate = self;
    gridView1.pagingEnabled = YES;
    gridView1.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
    [self.view addSubview:gridView1];    
    self.gridView1 = gridView1;    
    
    
    CGRect grid2Frame = CGRectMake(10, 188, 300, 168);
    
    IconGridView *gridView2 = [[IconGridView alloc] initWithFrame:grid2Frame numberOfIcons:34 orientation:IconGridOrientationVertical];
    gridView2.datasource = self;
    gridView2.gridDelegate = self;
    gridView2.delegate = self;
    gridView2.pagingEnabled = YES;
    gridView2.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0];
  
    [self.view addSubview:gridView2];    
    self.gridView2 = gridView2;     
}


- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
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