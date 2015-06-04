//
//  ViewController.m
//  MSender
//
//  Created by Martin on 15/6/2.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

#import "ViewController.h"
#import "FilteredImageView.h"
#import "pop.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>



@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scview;
@property (strong, nonatomic) IBOutlet UIImageView *mo1;
@property (strong, nonatomic) IBOutlet UIImageView *mo2;
@property (strong, nonatomic) IBOutlet UIImageView *mo3;
@property (strong, nonatomic) IBOutlet UIImageView *plane;
@property (strong, nonatomic) IBOutlet UIImageView *BBtn;

//全局声明
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIFilter *filter2;
@property (strong, nonatomic) UIImage *t1;
@property (strong, nonatomic) UIImage *t2;
@property (strong, nonatomic) UIImage *t3;
@property (strong, nonatomic) UIImage *t4;
@property (strong, nonatomic) UIImage *t5;
@property (strong, nonatomic) IBOutlet UIImageView *LNew;
@property (strong, nonatomic) IBOutlet UIImageView *L1;
@property (strong, nonatomic) IBOutlet UIImageView *L2;
@property (strong, nonatomic) IBOutlet UIImageView *L3;
@property (strong, nonatomic) IBOutlet UIImageView *L4;
@property (strong, nonatomic) IBOutlet UIImageView *L5;
@property (strong, nonatomic) IBOutlet UIImageView *L6;



@property (strong, nonatomic) FilteredImageView *t1v;
@property (strong, nonatomic) FilteredImageView *t2v;
@property (strong, nonatomic) FilteredImageView *t3v;
@property (strong, nonatomic) FilteredImageView *t4v;
@property (strong, nonatomic) FilteredImageView *t5v;


@property(nonatomic) BOOL bounces;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //imp
    _scview.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.


    self.t1 = [UIImage imageNamed:@"t1"];
    self.t2 = [UIImage imageNamed:@"t2"];
    self.t3 = [UIImage imageNamed:@"t3"];
    self.t4 = [UIImage imageNamed:@"t4"];
    self.t5 = [UIImage imageNamed:@"t5"];
    
    //filter & filterimageview
    self.filter =[CIFilter filterWithName:@"CITwirlDistortion"];
    [self.filter setValue:[CIVector vectorWithX:1 Y:100] forKey:kCIInputCenterKey];
    [self.filter setValue:@190 forKey:kCIInputRadiusKey];
    [self.filter setValue:@(0.01) forKey:kCIInputAngleKey];
    
    self.filter2 =[CIFilter filterWithName:@"CITwirlDistortion"];
    [self.filter2 setValue:[CIVector vectorWithX:1 Y:150] forKey:kCIInputCenterKey];
    [self.filter2 setValue:@190 forKey:kCIInputRadiusKey];
    [self.filter2 setValue:@(-0.01) forKey:kCIInputAngleKey];
    
    self.t1v = [[FilteredImageView alloc] initWithFrame:CGRectMake(-17, -71, 100, 144)];
    self.t1v.inputImage = self.t1;
    self.t1v.filter=self.filter;
    //self.t1v.contentMode = UIViewContentModeScaleAspectFit;
    self.t1v.clipsToBounds = NO;
    self.t1v.backgroundColor = [UIColor clearColor];
    [self.t1v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t1v setNeedsDisplay];
    [self.mo2 addSubview:self.t1v];
    
    self.t2v = [[FilteredImageView alloc] initWithFrame:CGRectMake(0, -75, 100, 144)];
    self.t2v.inputImage = self.t2;
    self.t2v.filter=self.filter;
    //self.t1v.contentMode = UIViewContentModeScaleAspectFit;
    self.t2v.clipsToBounds = NO;
    self.t2v.backgroundColor = [UIColor clearColor];
    [self.t2v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t2v setNeedsDisplay];
    [self.mo2 addSubview:self.t2v];

    self.t3v = [[FilteredImageView alloc] initWithFrame:CGRectMake(170, -73, 100, 144)];
    self.t3v.inputImage = self.t3;
    self.t3v.filter=self.filter2;
    //self.t1v.contentMode = UIViewContentModeScaleAspectFit;
    self.t3v.clipsToBounds = NO;
    self.t3v.backgroundColor = [UIColor clearColor];
    [self.t3v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t3v setNeedsDisplay];
    [self.mo1 addSubview:self.t3v];
    
    self.t4v = [[FilteredImageView alloc] initWithFrame:CGRectMake(187, -74, 100, 144)];
    self.t4v.inputImage = self.t4;
    self.t4v.filter=self.filter2;
    //self.t1v.contentMode = UIViewContentModeScaleAspectFit;
    self.t4v.clipsToBounds = NO;
    self.t4v.backgroundColor = [UIColor clearColor];
    [self.t4v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t4v setNeedsDisplay];
    [self.mo1 addSubview:self.t4v];
    
    self.t5v = [[FilteredImageView alloc] initWithFrame:CGRectMake(207, -73, 100, 144)];
    self.t5v.inputImage = self.t5;
    self.t5v.filter=self.filter2;
    //self.t1v.contentMode = UIViewContentModeScaleAspectFit;
    self.t5v.clipsToBounds = NO;
    self.t5v.backgroundColor = [UIColor clearColor];
    [self.t5v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t5v setNeedsDisplay];
    [self.mo1 addSubview:self.t5v];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.scview && self.scview.contentOffset.y < 0){
    
        //parallax

        CGFloat scrolly = self.scview.contentOffset.y;
        NSLog(@"scrolly is %f",scrolly);

        [_mo1 setFrame:CGRectMake(0, 55-(scrolly/2), 320, 234)];
        [_mo2 setFrame:CGRectMake(0, 74-(scrolly/3), 320, 242)];
        [_mo3 setFrame:CGRectMake(0, 89-(scrolly/4), 320, 228)];
        
        
        
        //btn
        CGFloat rotation = self.scview.contentOffset.y*4/568;
        CGFloat rotation2 = self.scview.contentOffset.y*2/568;
        _plane.transform = CGAffineTransformMakeRotation(M_PI * rotation  / 4.0);
        _BBtn.transform = CGAffineTransformMakeTranslation(0, -rotation * 2);
    
        //tree filter(bug fix)
        CGFloat inputAngle = -rotation2+0.03;
        CGFloat inputAngle2 = rotation2-0.03;
 
        [self.t1v.filter setValue:@(inputAngle) forKey:kCIInputAngleKey];
        [self.t1v setNeedsDisplay];
        [self.t2v.filter setValue:@(inputAngle) forKey:kCIInputAngleKey];
        [self.t2v setNeedsDisplay];
        [self.t3v.filter setValue:@(inputAngle2) forKey:kCIInputAngleKey];
        [self.t3v setNeedsDisplay];
        [self.t4v.filter setValue:@(inputAngle2) forKey:kCIInputAngleKey];
        [self.t4v setNeedsDisplay];
        [self.t5v.filter setValue:@(inputAngle2) forKey:kCIInputAngleKey];
        [self.t5v setNeedsDisplay];

      
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
 self.scview.bounces = YES;
    CGFloat scrolly = self.scview.contentOffset.y;
    if (scrolly < -100.00) {


        
        //PaintCode
        _plane.transform = CGAffineTransformMakeRotation(M_PI * -0.704  / 4.0);
        
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(40.5, 165.5)];
        [bezierPath addCurveToPoint: CGPointMake(383, -1.5) controlPoint1: CGPointMake(40.5, 165.5) controlPoint2: CGPointMake(285.25, 32.25)];
        [bezierPath addCurveToPoint: CGPointMake(434.5, 32.5) controlPoint1: CGPointMake(480.75, -35.25) controlPoint2: CGPointMake(583.87, -9.75)];
        [bezierPath addCurveToPoint: CGPointMake(-214.5, 167.5) controlPoint1: CGPointMake(262.5, 86.5) controlPoint2: CGPointMake(-120.5, 157.5)];
        [bezierPath addCurveToPoint: CGPointMake(40.5, 165.5) controlPoint1: CGPointMake(-131.5, 167.5) controlPoint2: CGPointMake(40.5, 165.5)];
        
        
        //Written by Alienjunx
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.duration = 2.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.445 : 0.5 :0.55 :0.75];
        animation.path = bezierPath.CGPath;
        animation.rotationMode = kCAAnimationRotateAuto;
        [self.plane.layer addAnimation:animation forKey:nil];
        
        
        //list
        CGPoint lnc=_LNew.center;
        _LNew.center=lnc;
        CGPoint l1c=_L1.center;
        _L1.center=l1c;
        CGPoint l2c=_L2.center;
        _L2.center=l2c;
        CGPoint l3c=_L3.center;
        _L3.center=l3c;
        CGPoint l4c=_L4.center;
        _L4.center=l4c;
        CGPoint l5c=_L5.center;
        _L5.center=l5c;
        CGPoint l6c=_L6.center;
        _L6.center=l6c;
        
        [UIView animateWithDuration:0.5 delay:2.5 options: UIViewAnimationOptionCurveEaseInOut animations:^{
            _LNew.alpha = 1;
        } completion:nil];
        
        POPSpringAnimation * LNY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        LNY.beginTime = CACurrentMediaTime() + 2.5;
        LNY.toValue = @(lnc. y+= 62);
        LNY.springBounciness = 10;
        LNY.springSpeed = 10;
        [_LNew pop_addAnimation:LNY forKey:@"LNY"];
        
        POPSpringAnimation * L1Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L1Y.beginTime = CACurrentMediaTime() + 2.5;
        L1Y.toValue = @(l1c. y+= 62);
        L1Y.springBounciness = 10;
        L1Y.springSpeed = 10;
        [_L1 pop_addAnimation:L1Y forKey:@"L1Y"];
        
        POPSpringAnimation * L2Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L2Y.beginTime = CACurrentMediaTime() + 2.5;
        L2Y.toValue = @(l2c. y+= 62);
        L2Y.springBounciness = 10;
        L2Y.springSpeed = 10;
        [_L2 pop_addAnimation:L2Y forKey:@"L2Y"];
        
        POPSpringAnimation * L3Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L3Y.beginTime = CACurrentMediaTime() + 2.5;
        L3Y.toValue = @(l3c. y+= 62);
        L3Y.springBounciness = 10;
        L3Y.springSpeed = 10;
        [_L3 pop_addAnimation:L3Y forKey:@"L3Y"];
        
        POPSpringAnimation * L4Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L4Y.beginTime = CACurrentMediaTime() + 2.5;
        L4Y.toValue = @(l4c. y+= 62);
        L4Y.springBounciness = 10;
        L4Y.springSpeed = 10;
        [_L4 pop_addAnimation:L4Y forKey:@"L4Y"];
        
        POPSpringAnimation * L5Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L5Y.beginTime = CACurrentMediaTime() + 2.5;
        L5Y.toValue = @(l5c. y+= 62);
        L5Y.springBounciness = 10;
        L5Y.springSpeed = 10;
        [_L5 pop_addAnimation:L5Y forKey:@"L5Y"];
        
        POPSpringAnimation * L6Y = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        L6Y.beginTime = CACurrentMediaTime() + 2.5;
        L6Y.toValue = @(l6c. y+= 62);
        L6Y.springBounciness = 10;
        L6Y.springSpeed = 10;
        [_L6 pop_addAnimation:L6Y forKey:@"L6Y"];
        
        }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    _LNew.alpha = 0;
      [scrollView setContentOffset:scrollView.contentOffset animated:YES];

}


@end
