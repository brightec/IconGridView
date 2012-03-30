//
//  IconGridView.m
//  probation
//
//  Created by Cameron Cooke on 28/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IconGridView.h"
#import <QuartzCore/QuartzCore.h>


// private interface
@interface IconGridView ()

@property (nonatomic, strong) NSMutableArray *cells;

-(void)didSelectCell:(UIButton *)cell;
-(void)createCellsForNumberOfIcons:(NSInteger)numberOfIcons;
-(UIEdgeInsets)marginForNumberOfColumns:(NSInteger)columnCount andRows:(NSInteger)rowCount;

@end


@implementation IconGridView


@synthesize cells = _cells;
@synthesize datasource = _datasource;
@synthesize gridDelegate = _gridDelegate;
@synthesize cellSize = _cellSize;
@synthesize selectedCell = _selectedCell;
@synthesize orientation = _orientation;
@synthesize minimumMargin = _miniumMargin;


- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfIcons:0 orientation:IconGridOrientationVertical];
}


- (id)initWithFrame:(CGRect)frame numberOfIcons:(NSInteger)numberOfIcons orientation:(IconGridOrientation)orientation {
    self = [super initWithFrame:frame];
    if (self) {
        _orientation = orientation;    
        _cellSize = CGSizeMake(44, 44);
        _miniumMargin = 1;
        
        [self createCellsForNumberOfIcons:numberOfIcons];
    }
    return self;
}


// Returns the calculated margin per cell based on the remaining space
// after accounting x rows and columns of the visible view.bounds
-(UIEdgeInsets)marginForNumberOfColumns:(NSInteger)columnCount andRows:(NSInteger)rowCount {
    
    // calculate margins based on whitespace
    CGFloat rightWhiteSpace = (self.bounds.size.width - (columnCount * self.cellSize.width));
    CGFloat bottomWhiteSpace = (self.bounds.size.height - (rowCount * self.cellSize.height));
    
    CGFloat marginRight = (rightWhiteSpace / (columnCount-1));
    CGFloat marginBottom = (bottomWhiteSpace / (rowCount-1));    
    
//    NSLog(@"Whitespace: r=%f, b=%f", rightWhiteSpace, bottomWhiteSpace);
//    NSLog(@"Margin: r=%f, b=%f", marginRight, marginBottom);
    
    return UIEdgeInsetsMake(0, 0, marginBottom, marginRight);
}


- (void)layoutSubviews {
    
    
    
    ////////////////////////////////////////
    /// Calculate columns, rows and margins
    ////////////////////////////////////////
    
    // calculate the number of columns in each row
    NSInteger columns = floor((self.bounds.size.width / (self.cellSize.width)));
    
    // calculate the number of rows in each column
    NSInteger rows = floor((self.bounds.size.height / (self.cellSize.height)));    

    UIEdgeInsets margin = [self marginForNumberOfColumns:columns andRows:rows];
    
    while (margin.right < self.minimumMargin && columns > 1) {
        columns--;
        margin = [self marginForNumberOfColumns:columns andRows:rows];        
    }
    
    while (margin.bottom < self.minimumMargin && rows > 1) {
        rows--;
        margin = [self marginForNumberOfColumns:columns andRows:rows];        
    }
    
    NSInteger p = 0;
    
    
        
    ////////////////////
    /// Position buttons
    ////////////////////
    
    NSEnumerator *enumerator = [self.cells objectEnumerator];
    int i = 0;
    
    // iterate through each column
    for (int r = 0; r < rows; r++) {
        
        BOOL hasBraked = NO;
        
        // iterate through each row
        for (int c = 0; c < columns; c++) {
            
            IconButton *button;
            if (button = (IconButton *)[enumerator nextObject]) {
                
                // calculate offsets for each page
                CGFloat pageOffsetY = 0;
                CGFloat pageOffsetX = 0;
                if (self.pagingEnabled) {
                    if (self.orientation == IconGridOrientationVertical) {
                        pageOffsetY = (p * self.bounds.size.height);
                        pageOffsetX = 0;
                    }
                    else {
                        pageOffsetY = 0;
                        pageOffsetX = (p * self.bounds.size.width);                        
                    }
                    
                }
                else {
                    if (self.orientation == IconGridOrientationVertical) {
                        pageOffsetY = (p * (rows * (self.cellSize.height+margin.bottom)));
                        pageOffsetX = 0;
                    }
                    else {
                        pageOffsetY = 0;                        
                        pageOffsetX = (p * (columns * (self.cellSize.height+margin.right)));                        
                    }
                }
                
                // calculate x and y coordinate for cell
                CGFloat x = (c * (self.cellSize.width + margin.right)) + pageOffsetX;
                CGFloat y = (r * (self.cellSize.height + margin.bottom)) + pageOffsetY;
                
//                NSLog(@"Row: x=%f, y=%f", x, y);
                
                button.frame = CGRectMake(x, y, self.cellSize.width, self.cellSize.height);   
                
                
                if ([(id)self.datasource respondsToSelector:@selector(iconGridView:imageForCellWithIndex:)]) {
                    UIImage *cellImage = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self imageForCellWithIndex:i];
                    button.image = cellImage;
                }
                
                if ([(id)self.datasource respondsToSelector:@selector(iconGridView:titleForCellWithIndex:)]) {
                    NSString *label = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self titleForCellWithIndex:i];
                    button.label = label;
                }                          
                
                i++;                        
            }
            else {
                
                hasBraked = YES;
                break;
            }
            
        } 
        
        if (hasBraked) {
            break;
        }
        
        // reset counter to start again
        if (r == rows-1) {
            r = -1;
            p++;
        }
    }       
    
        

    //////////////////////////
    /// Calculate content size 
    //////////////////////////
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (self.orientation == IconGridOrientationVertical) {
        
        width = self.bounds.size.width; 
        
        if (self.pagingEnabled) {
            height = self.bounds.size.height * (p+1);
        }
        else {
            height = (((self.cells.count/columns)+1) * (self.cellSize.height + margin.bottom)) - margin.bottom;            
        }
    }
    else {

        if (self.pagingEnabled) {
            width = self.bounds.size.width * (p+1);
        } 
        else {
            width = ceil(((self.cells.count/rows)+1) * (self.cellSize.width + margin.right)) - margin.right;            
        }
        
        height = self.bounds.size.height;
    }
    
    self.contentSize = CGSizeMake(width, height);        
    
    // debugging
//    NSLog(@"-----------------------");
//    NSLog(@"Pages: %i", p+1);
//    NSLog(@"Cell size: w = %f, h = %f", self.cellSize.width, self.cellSize.height);
//    NSLog(@"Margin bottom: %f", margin.bottom);
//    NSLog(@"Margin right: %f", margin.right);            
//    NSLog(@"Bounds: w = %f, h = %f", self.bounds.size.width, self.bounds.size.height);
//    NSLog(@"Content size: w = %f, h = %f", self.contentSize.width, self.contentSize.height);    
//    NSLog(@"Columns: %i", columns);
//    NSLog(@"Rows: %i", rows);    
//    NSLog(@"------");      
}


-(void)didSelectCell:(IconButton *)cell {
    
    self.selectedCell.selected = NO;
    
    if ([(id)self.gridDelegate respondsToSelector:@selector(iconGridView:didSelectRowAtCellIndex:)]) {
        [((id <IconGridViewDelegate>)self.gridDelegate) iconGridView:self didSelectRowAtCellIndex:cell.tag];
    }  
    
    _selectedCell = cell;
    self.selectedCell.selected = YES;
}


-(void)setMinimumMargin:(CGFloat)minimumMargin {
    _miniumMargin = minimumMargin;
    [self layoutSubviews];
}


-(void)setCellSize:(CGSize)cellSize {
    _cellSize = cellSize;
   [self layoutSubviews]; 
}


-(void)setOrientation:(IconGridOrientation)orientation {
    _orientation = orientation;
   [self layoutSubviews]; 
}


-(void)setNumberOfIcons:(NSInteger)numberOfIcons {
    [self createCellsForNumberOfIcons:numberOfIcons];
    [self layoutSubviews];    
}


-(void)createCellsForNumberOfIcons:(NSInteger)numberOfIcons {
    _selectedCell = nil;
    _cells = [NSMutableArray array];
    
    // create cell views for each icon
    for (int i = 0; i < numberOfIcons; i++) {
        
        IconButton *button = [[IconButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor redColor];
        button.tag = i;
        [button addTarget:self action:@selector(didSelectCell:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [_cells addObject:button];
    }    
}


@end