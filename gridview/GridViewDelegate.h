//
//  GridViewDelegate.h
//  gridview
//
//  Created by Cameron Cooke on 29/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconGridView.h"

@interface GridViewDelegate : NSObject <IconGridViewDataSource, IconGridViewDelegate, UIScrollViewDelegate>

@end
