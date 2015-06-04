//
//  FilteredImageView.h
//  PictureHandleDemo
//
//  Created by AlienJunX on 15/6/3.
//  Copyright (c) 2015年 Shanghai Metis IT Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface FilteredImageView : GLKView
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) UIImage *inputImage;
@property (strong, nonatomic) CIContext *cIContext;
@end
