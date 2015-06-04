//
//  FilteredImageView.m
//  PictureHandleDemo
//
//  Created by AlienJunX on 15/6/3.
//  Copyright (c) 2015年 Shanghai Metis IT Co.,Ltd. All rights reserved.
//

#import "FilteredImageView.h"

@implementation FilteredImageView

-(void)setFilter:(CIFilter *)filter
{
    _filter=filter;
    [self setNeedsDisplay];
}

- (void)setInputImage:(UIImage *)inputImage
{
    _inputImage=inputImage;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.context= [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        _cIContext = [CIContext contextWithEAGLContext:self.context];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.clipsToBounds = NO;
        
        self.context= [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        _cIContext = [CIContext contextWithEAGLContext:self.context];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CIImage *image = [[CIImage alloc] initWithCGImage:self.inputImage.CGImage options:nil];
    [self.filter setValue:image forKey:kCIInputImageKey];
    
    CIImage* output = [self.filter outputImage];

    [self clearBackground];
    CGRect inputBounds = [output extent];
    CGRect drawableBounds = CGRectMake(0, 0, self.drawableWidth, self.drawableHeight);
    CGRect targetBounds = [self imageBoundsForContentMode:inputBounds toRect:drawableBounds];
    
//    NSLog(@"targetBounds:%@",NSStringFromCGRect(targetBounds));
//    NSLog(@"inputBounds:%@",NSStringFromCGRect(inputBounds));
//    NSLog(@"image.extent:%@",NSStringFromCGRect(image.extent));
    [self.cIContext drawImage:self.filter.outputImage inRect:targetBounds fromRect:inputBounds];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGFloat f = [[_filter valueForKey:kCIInputRadiusKey] floatValue];
    bounds.size = CGSizeMake(f, f);
    self.bounds = bounds;
    
    [self setNeedsDisplay];
}

-(void) clearBackground{
    const CGFloat *colorValues = CGColorGetComponents([[self backgroundColor] CGColor]);
    glClearColor(colorValues[0], colorValues[1], colorValues[2], colorValues[3]);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // setup GL blend mode if needed
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
}

- (CGRect ) aspectFit:(CGRect)fromRect toRect:(CGRect)toRect {
    CGFloat fromAspectRatio = fromRect.size.width / fromRect.size.height;
    CGFloat toAspectRatio = toRect.size.width / toRect.size.height;
    
    CGRect fitRect = toRect;
    
    if (fromAspectRatio > toAspectRatio) {
        fitRect.size.height = toRect.size.width / fromAspectRatio;
        fitRect.origin.y += (toRect.size.height - fitRect.size.height) * 0.5;
    } else {
        fitRect.size.width = toRect.size.height  * fromAspectRatio;
        fitRect.origin.x += (toRect.size.width - fitRect.size.width) * 0.5;
    }
    
    return CGRectIntegral(fitRect);
}

- (CGRect) aspectFill:(CGRect)fromRect toRect:(CGRect)toRect {
    CGFloat fromAspectRatio = fromRect.size.width / fromRect.size.height;
    CGFloat toAspectRatio = toRect.size.width / toRect.size.height;
    
    CGRect fitRect = toRect;
    
    if (fromAspectRatio > toAspectRatio) {
        fitRect.size.width = toRect.size.height  * fromAspectRatio;
        fitRect.origin.x += (toRect.size.width - fitRect.size.width) * 0.5;
    } else {
        fitRect.size.height = toRect.size.width / fromAspectRatio;
        fitRect.origin.y += (toRect.size.height - fitRect.size.height) * 0.5;
    }
    
    return CGRectIntegral(fitRect);
}

- (CGRect ) imageBoundsForContentMode:(CGRect)fromRect toRect: (CGRect)toRect {
    switch (self.contentMode) {
    case UIViewContentModeScaleToFill:
            return [self aspectFill:fromRect toRect:toRect];
    case UIViewContentModeScaleAspectFit:
            return [self aspectFit:fromRect toRect:toRect];
    default:
            return fromRect;
    }
}
@end
