//
//  ViewController.m
//  Big_Picture
//
//  Created by DHANESH PATEL on 2014-07-25.
//  Copyright (c) 2014 Group A of IPCT, Lambton College. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define BIG_IMG_WIDTH  200.0
#define BIG_IMG_HEIGHT 200.0
@interface ViewController ()

{
    UIView *background;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _Picture.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removal)] autorelease];
    [_Picture addGestureRecognizer:singleTap];
}

- (void)dealloc {
    [_Picture release];
    [super dealloc];
}
- (void)magnify
{

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                               green:0.3
                                                blue:0.3
                                               alpha:0.7]];
    [self.view addSubview:bgView];
    [bgView release];

    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,BIG_IMG_WIDTH+16, BIG_IMG_HEIGHT+16)];

    borderView.layer.cornerRadius = 8;
    borderView.layer.masksToBounds = YES;
 
    borderView.layer.borderWidth = 8;
    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                    green:0.9
                                                     blue:0.9
                                                    alpha:0.7]CGColor];
    [borderView setCenter:bgView.center];
    [bgView addSubview:borderView];
    [borderView release];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"remove.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(removal) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"borderview is %@",borderView);
    [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
    [bgView addSubview:closeBtn];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    [imgView setImage:[UIImage imageNamed:@"2.jpg"]];
    [borderView addSubview:imgView];
    [self shakeToShow:borderView];
    [imgView release];
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.6];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView setAnimationDelegate:bgView];

    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

-(void)removal
{
    [background removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


@end
