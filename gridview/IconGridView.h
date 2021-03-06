//
//  IconGridView.h
//  probation
//
//  Created by Cameron Cooke on 28/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconButton.h"


typedef enum {
    IconGridOrientationVertical,
    IconGridOrientationHorizontal
} IconGridOrientation;


@protocol IconGridViewDataSource;
@protocol IconGridViewDelegate;


@interface IconGridView : UIScrollView

@property (nonatomic) CGSize cellSize;
@property (nonatomic, weak) id<IconGridViewDataSource> datasource;
@property (nonatomic, weak) id<IconGridViewDelegate> gridDelegate;
@property (nonatomic, weak, readonly) IconButton *selectedCell;
@property (nonatomic) IconGridOrientation orientation;
@property (nonatomic) CGFloat minimumMargin;

- (id)initWithFrame:(CGRect)frame numberOfIcons:(NSInteger)numberOfIcons orientation:(IconGridOrientation)orientation;
//-(void)setNumberOfIcons:(NSInteger)numberOfIcons;

@end


@protocol IconGridViewDataSource
- (UIImage *)iconGridView:(IconGridView *)gridView imageForCellWithIndex:(NSInteger)cellIndex;
@optional
- (NSString *)iconGridView:(IconGridView *)gridView titleForCellWithIndex:(NSInteger)cellIndex;
@end


@protocol IconGridViewDelegate
@optional
- (void)iconGridView:(IconGridView *)gridView didSelectRowAtCellIndex:(NSInteger)cellIndex;
@end