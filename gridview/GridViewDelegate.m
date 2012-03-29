//
//  GridViewDelegate.m
//  gridview
//
//  Created by Cameron Cooke on 29/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GridViewDelegate.h"

@implementation GridViewDelegate

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