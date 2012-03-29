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

@end


@implementation IconGridView


@synthesize cells = _cells;
@synthesize datasource = _datasource;
@synthesize gridDelegate = _gridDelegate;
@synthesize cellSize = _cellSize;
@synthesize spacing = _spacing;
@synthesize autoSpacing = _autoSpacing;
@synthesize selectedCell = _selectedCell;
@synthesize orientation = _orientation;


- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfIcons:0 orientation:IconGridOrientationVertical];
}


- (id)initWithFrame:(CGRect)frame numberOfIcons:(NSInteger)numberOfIcons orientation:(IconGridOrientation)orientation {
    self = [super initWithFrame:frame];
    if (self) {
        _orientation = orientation;
        _autoSpacing = NO;        
        _spacing = 8;
        _cellSize = CGSizeMake(44, 44);
        
        [self setNumberOfIcons:numberOfIcons];
    }
    return self;
}


- (void)layoutSubviews {
    
    NSInteger verticalSpacing = self.spacing;
    NSInteger horizontalSpacing = self.spacing;    
    
    // calculate the number of columns in each row
    NSInteger columns = floor((self.bounds.size.width / (self.cellSize.width + verticalSpacing)));      
    
    // calculate the number of rows in each column
    NSInteger rows = floor((self.bounds.size.height / (self.cellSize.height + horizontalSpacing)));    
    
    if (self.autoSpacing) {
        verticalSpacing = floor((self.bounds.size.width - (columns * self.cellSize.width)) / columns-1);
        horizontalSpacing = floor((self.bounds.size.height - (rows * self.cellSize.height)) / rows-1);
    }    
    
    if (self.orientation == IconGridOrientationVertical) {
        
        if (!self.pagingEnabled) {
            horizontalSpacing = verticalSpacing;
        }
        
        // reposition cells
        for (int i = 0; i < self.cells.count; i++) {
            
            IconButton *button = (IconButton *)[self.cells objectAtIndex:i];
            
            // calculate x and y coordinate for cell
            NSInteger x = ((i % columns) * ((int)self.cellSize.width + verticalSpacing)) + verticalSpacing;
            NSInteger y = ((i / columns) * ((int)self.cellSize.height + horizontalSpacing)) + horizontalSpacing;
            
            button.frame = CGRectMake(x, y, self.cellSize.width, self.cellSize.height);
            
            if ([(id)self.datasource respondsToSelector:@selector(iconGridView:imageForCellWithIndex:)]) {
                UIImage *cellImage = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self imageForCellWithIndex:i];
                button.image = cellImage;
            }
            
            if ([(id)self.datasource respondsToSelector:@selector(iconGridView:titleForCellWithIndex:)]) {
                NSString *label = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self titleForCellWithIndex:i];
                button.label = label;
            }              
        } 
        
        // calculate content height
        CGFloat height = ceil(((self.cells.count/columns)+1) * (self.cellSize.height + horizontalSpacing));
        if (self.pagingEnabled) {
            height = (ceil(height / self.frame.size.height) * (self.frame.size.height)) - horizontalSpacing;
        }
        
        self.contentSize = CGSizeMake(self.bounds.size.width, height);
    }
    else {
        
        if (!self.pagingEnabled) {
            verticalSpacing = horizontalSpacing;
        }
        
        
        if (self.pagingEnabled) {
            
            
            NSEnumerator *enumerator = [self.cells objectEnumerator];
            

            int i = 0;
            int p = 0; // page index
            
            // iterate through each row
            for (int r = 0; r < rows; r++) {
                
                BOOL hasBraked = NO;
                
                // iterate through each column
                for (int c = 0; c < columns; c++) {
                    
                    NSLog(@"page: %i, row: %i, column: %i", p, r, c);
                    
                    IconButton *button;
                    if (button = (IconButton *)[enumerator nextObject]) {
                        
                        
                        
                        // calculate x and y coordinate for cell
                        NSInteger x = (c * ((int)self.cellSize.width + verticalSpacing)) + verticalSpacing  + (p * self.bounds.size.width);
                        NSInteger y = (r * ((int)self.cellSize.height + horizontalSpacing)) + horizontalSpacing;
                        
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
                
                if (r == rows-1) {
                    r = -1;
                    p++;
                }
                
            }            
            
            
            
            
            
            
        } else {
        
        
        
        
            
            // reposition cells
            for (int i = 0; i < self.cells.count; i++) {
                
                IconButton *button = (IconButton *)[self.cells objectAtIndex:i];
                
                // calculate x and y coordinate for cell
                NSInteger x = ((i / rows) * ((int)self.cellSize.width + verticalSpacing)) + verticalSpacing;
                NSInteger y = ((i % rows) * ((int)self.cellSize.height + horizontalSpacing)) + horizontalSpacing;
                
                button.frame = CGRectMake(x, y, self.cellSize.width, self.cellSize.height); 
                
                if ([(id)self.datasource respondsToSelector:@selector(iconGridView:imageForCellWithIndex:)]) {
                    UIImage *cellImage = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self imageForCellWithIndex:i];
                    button.image = cellImage;
                }
                
                if ([(id)self.datasource respondsToSelector:@selector(iconGridView:titleForCellWithIndex:)]) {
                    NSString *label = [((id <IconGridViewDataSource>)self.datasource) iconGridView:self titleForCellWithIndex:i];
                    button.label = label;
                }                
            }
            
            
            
            
            
        }
        
        CGFloat width = ceil(((self.cells.count/rows)+1) * (self.cellSize.width + verticalSpacing));
        if (self.pagingEnabled) {
            width = (ceil(width / self.frame.size.width) * (self.frame.size.width)) - verticalSpacing;
        }
        
        self.contentSize = CGSizeMake(width, self.bounds.size.height);        
    }
    
    NSLog(@"-----------------------");
    NSLog(@"Cell size: w = %f, h = %f", self.cellSize.width, self.cellSize.height);
    NSLog(@"Frame: w = %f, h = %f", self.frame.size.width, self.frame.size.height);
    NSLog(@"Vertical spacing: %i", verticalSpacing);
    NSLog(@"Horizonal spacing: %i", horizontalSpacing);    
    NSLog(@"Content size: w = %f, h = %f", self.contentSize.width, self.contentSize.height);
    NSLog(@"Columns: %i", columns);
    NSLog(@"Rows: %i", rows);
}


-(void)didSelectCell:(IconButton *)cell {
    
    self.selectedCell.selected = NO;
    
    if ([(id)self.gridDelegate respondsToSelector:@selector(iconGridView:didSelectRowAtCellIndex:)]) {
        [((id <IconGridViewDelegate>)self.gridDelegate) iconGridView:self didSelectRowAtCellIndex:cell.tag];
    }  
    
    _selectedCell = cell;
    self.selectedCell.selected = YES;
}


-(void)setSpacing:(NSInteger)spacing {
    _spacing = spacing;
    [self setNeedsDisplay];
}


-(void)setAutoSpacing:(BOOL)autoSpacing {
    _autoSpacing = autoSpacing;
    [self setNeedsDisplay];
}


-(void)setCellSize:(CGSize)cellSize {
    _cellSize = cellSize;
   [self setNeedsDisplay]; 
}


-(void)setOrientation:(IconGridOrientation)orientation {
    _orientation = orientation;
   [self setNeedsDisplay]; 
}


-(void)setNumberOfIcons:(NSInteger)numberOfIcons {
    _selectedCell = nil;
    _cells = [NSMutableArray array];
    
    // create cell views for each icon
    for (int i = 0; i < numberOfIcons; i++) {
        
        IconButton *button = [[IconButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        [button addTarget:self action:@selector(didSelectCell:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [_cells addObject:button];
    }
    
    [self layoutSubviews];    
}

@end