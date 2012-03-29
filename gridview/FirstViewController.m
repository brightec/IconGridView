//
//  FirstViewController.m
//  gridview
//
//  Created by Cameron Cooke on 29/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "GridViewDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize gridView = _gridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    GridViewDelegate *delegate = [[GridViewDelegate alloc] init];
    
    self.gridView.delegate = delegate;
    self.gridView.datasource = delegate;
    self.gridView.gridDelegate = delegate;
    self.gridView.pagingEnabled = NO;
    self.gridView.autoSpacing = YES;
    self.gridView.spacing = 10;
    self.gridView.orientation = IconGridOrientationVertical;
    
    [self.gridView setNumberOfIcons:5];
}

- (void)viewDidUnload
{
    [self setGridView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end