//
//  FilterViewController.m
//  PictureHandleDemo
//
//  Created by AlienJunX on 15/6/3.
//  Copyright (c) 2015年 Shanghai Metis IT Co.,Ltd. All rights reserved.
//

#import "FilterViewController.h"
#import "FilteredImageView.h"

@interface FilterViewController ()
@property (strong, nonatomic) FilteredImageView *filteredImageView;
@property (strong, nonatomic) FilteredImageView *filteredImageView1;
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) UIImage *inputImage;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputImage = [UIImage imageNamed:@"t4"];
    //滤镜
    self.filter =[CIFilter filterWithName:@"CITwirlDistortion"];
    [self.filter setValue:[CIVector vectorWithX:1 Y:180] forKey:kCIInputCenterKey];
    [self.filter setValue:@190 forKey:kCIInputRadiusKey];
    [self.filter setValue:@(0.01) forKey:kCIInputAngleKey];
    
    self.filteredImageView = [[FilteredImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 144)];
    self.filteredImageView.inputImage = self.inputImage;
    self.filteredImageView.filter=self.filter;
    self.filteredImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.filteredImageView.clipsToBounds = NO;
    self.filteredImageView.backgroundColor = [UIColor clearColor];
    [self.filteredImageView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view insertSubview:self.filteredImageView atIndex:0];
    
    self.filteredImageView1 = [[FilteredImageView alloc] initWithFrame:CGRectMake(150, 100, 100, 144)];
    self.filteredImageView1.inputImage = self.inputImage;
    self.filteredImageView1.filter=self.filter;
    self.filteredImageView1.contentMode = UIViewContentModeScaleAspectFit;
    self.filteredImageView1.clipsToBounds = NO;
    self.filteredImageView1.backgroundColor = [UIColor clearColor];
    [self.filteredImageView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view insertSubview:self.filteredImageView1 atIndex:0];
    
//    [self cc:0.1];
    
    NSLog(@"%@",[self.filter valueForKey:kCIInputRadiusKey]);
}

- (IBAction)valueChange:(UISlider *)sender {
//    NSLog(@"%@", [self.filter attributes]);
    CGFloat f = sender.value -0.5;
    [self cc:f];
    
    NSLog(@"%@",NSStringFromCGRect(self.filteredImageView1.frame));
}

- (void) cc:(CGFloat) f{
    if(f==0){
        f=0.01;
    }
    [self.filteredImageView.filter setValue:@(f) forKey:kCIInputAngleKey];
    [self.filteredImageView setNeedsDisplay];
    
    [self.filteredImageView1.filter setValue:@(f) forKey:kCIInputAngleKey];
    [self.filteredImageView1 setNeedsDisplay];
}

@end
