//
//  IconButton.m
//  probation
//
//  Created by Cameron Cooke on 28/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IconButton.h"
#import "RRGlossCausticShader.h"
#import "CGUtils.h"


@interface IconButton ()
@end


@implementation IconButton


@synthesize image = _image;
@synthesize label = _label;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.state == UIControlStateSelected) {
        
        CGMutablePathRef path = createRoundedRectForRect(rect, 5);      
        CGContextAddPath(context, path);
        CGContextClip(context);  
        CFRelease(path);
        
        RRGlossCausticShader *shader = [[RRGlossCausticShader alloc] init];
        [shader setNoncausticColor:[UIColor colorWithRed:127.0/255.0 green:0 blue:127.0/255.0 alpha:1.0]];
        [shader update];
        [shader drawShadingFromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, rect.size.height) inContext:context];
    }
    
    NSInteger x = (rect.size.width / 2) - (self.image.size.width / 2);
    NSInteger y = (rect.size.height / 2) - (self.image.size.height / 2);
    
    CGRect imageRect = CGRectMake(x, y, self.image.size.width, self.image.size.height); 

    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, imageRect, self.image.CGImage);
    
    if (self.state == UIControlStateHighlighted) {
        
        CGContextClipToMask(context, imageRect, self.image.CGImage);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
         
        CGContextFillRect(context, imageRect);        
    }
    else if(self.state == UIControlStateSelected) {
            
        CGContextClipToMask(context, imageRect, self.image.CGImage);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, imageRect); 
    }    
    
    // label
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGRect labelRect = CGRectMake(0, rect.size.height-12, rect.size.width, 12);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 0, [UIColor whiteColor].CGColor);
    [self.label drawInRect:labelRect withFont:[UIFont systemFontOfSize:10.0f] lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
}


- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}


- (void)setLabel:(NSString *)label {
    _label = label;
    [self setNeedsDisplay];
}


- (void) setHighlighted: (BOOL) highlighted {
    [super setHighlighted: highlighted];
    [self setNeedsDisplay];
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

@end
