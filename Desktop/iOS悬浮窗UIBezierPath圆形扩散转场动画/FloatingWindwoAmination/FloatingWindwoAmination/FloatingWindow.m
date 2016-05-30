//
//  FloatingWindow.m
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//
#import "FloatingWindow.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


static const float timeSplit = 1.f / 3.f;
@interface FloatingWindow ()
@property (nonatomic ,strong) UILabel *timeLable;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,copy) NSString *imageNameString;
@property (nonatomic ,strong) UIView *presentView;
@property (nonatomic ,strong) CAAnimation *samllAnimation;
@property (nonatomic ,assign) BOOL isExit;
@property (assign, nonatomic) BOOL timeStart;
@end

@implementation FloatingWindow
{
    UIImageView * _phoneFlowImageView1;
    UIImageView * _phoneFlowImageView2;
    UIImageView * _phoneFlowImageView3;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 1;
        [self makeKeyAndVisible];
        _imageView = [[UIImageView alloc]initWithFrame:(CGRect){0, 0,frame.size.width, frame.size.height}];
        _imageView.image = [UIImage imageNamed:name];
        _imageView.alpha = 1.0;
        self.imageNameString = name;
        [self addSubview:_imageView];
        
        _phoneFlowImageView1 = [[UIImageView alloc] initWithImage : [UIImage imageNamed:@"fsav_phone_flow1"]];
        _phoneFlowImageView1.frame = CGRectMake(76 - 21 - _phoneFlowImageView1.frame.size.width,
                                                12,
                                                _phoneFlowImageView1.frame.size.width,
                                                _phoneFlowImageView1.frame.size.height);
        [self addSubview:_phoneFlowImageView1];
        
        _phoneFlowImageView2 = [[UIImageView alloc] initWithImage : [UIImage imageNamed:@"fsav_phone_flow2"]];
        _phoneFlowImageView2.frame = CGRectMake(76 - 21 - _phoneFlowImageView2.frame.size.width,
                                                12,
                                                _phoneFlowImageView2.frame.size.width,
                                                _phoneFlowImageView2.frame.size.height);
        [self addSubview:_phoneFlowImageView2];
        
        _phoneFlowImageView3 = [[UIImageView alloc] initWithImage : [UIImage imageNamed:@"fsav_phone_flow3"]];
        _phoneFlowImageView3.frame = CGRectMake(76 - 21 - _phoneFlowImageView3.frame.size.width,
                                                12,
                                                _phoneFlowImageView3.frame.size.width,
                                                _phoneFlowImageView3.frame.size.height);
        [self addSubview:_phoneFlowImageView3];
        
        _phoneFlowImageView1.alpha = 0.f;
        _phoneFlowImageView2.alpha = 0.f;
        _phoneFlowImageView3.alpha = 0.f;
        
        UILabel *timelable = [[UILabel alloc ] initWithFrame:CGRectMake(0, 0, 60, 10)];
        timelable.center = CGPointMake(frame.size.width /2, frame.size.height / 2 + 12);
        timelable.font = [UIFont systemFontOfSize:12];
        timelable.textColor = [UIColor whiteColor];
        timelable.textAlignment = NSTextAlignmentCenter;
        
        self.timeLable = timelable;
        [self addSubview:timelable];
        //添加移动的手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        //添加点击的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        self.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(convStartHere) name:@"FSAVConvStartNotification" object:nil];
        
    }
    return self;
}

#pragma mark--- 开始和结束
- (void)startWithTime:(NSInteger) time presentview:(UIView *)presentView inRect:(CGRect) rect{
    self.hidden = NO;
    _imageView.hidden = YES;
    self.timeLable.hidden = YES;
    self.startFrame = rect;
    [self circleSmallerWithView:presentView];
    self.time = time;
    self.presentView = presentView;
    
    if(time == 0) {
        _timeStart = NO;
    } else {
        _timeStart = YES;
    }
}

- (void)close {
    
    self.hidden = YES;
    
    self.presentView = nil;
    [self.timer invalidate];
    self.showImageView = nil;
    self.showImage = nil;
    self.timer = nil;
}
- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeTimeLable) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)changeTimeLable {
    self.timeLable.text = [self changeTimeFormater:self.time];
    if(_timeStart) {
        self.time++;
    }
    
    static BOOL oem = false;
    oem = !oem;
    if(oem && _timeStart) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView1.alpha = 1.f;
            } completion:^(BOOL finished) {
                ;
            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * timeSplit * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView1.alpha = 0.f;
            } completion:^(BOOL finished) {
                ;
            }];
            ;
        });
        
        //_fimageView2
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * timeSplit * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView2.alpha = 1.f;
            } completion:^(BOOL finished) {
                ;
            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * timeSplit * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView2.alpha = 0.f;
            } completion:^(BOOL finished) {
                ;
            }];
        });
        
        //_fimageView3
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * timeSplit * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView3.alpha = 1.f;
            } completion:^(BOOL finished) {
                ;
            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * timeSplit * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self duration:timeSplit options:UIViewAnimationOptionCurveLinear animations:^{
                _phoneFlowImageView3.alpha = 0.f;
            } completion:^(BOOL finished) {
                ;
            }];
        });
    }
}


#pragma mark ---进去和出去动画
- (void)makeIntoAnimation {
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.image = self.showImage;
    _imageView.hidden = YES;
    self.showImageView = showImageView;
    self.frame = self.startFrame;
    showImageView.frame = CGRectMake(0, 0, self.startFrame.size.width,self.startFrame.size.height);
    [self addSubview:showImageView];
    self.frame = self.startFrame;
    [UIView animateWithDuration:0.5f animations:^{
        showImageView.frame = CGRectMake(0, 0, 76, 76);
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 200, 76, 76);
    } completion:^(BOOL finished) {
        
        [self start];
        showImageView.hidden = YES;
        _imageView.hidden = NO;
        _timeLable.hidden = NO;
        [self showPhoneImages];
        _imageView.image = [UIImage imageNamed:self.imageNameString];
    }];
}


- (void)makeOuttoAnimation {
    self.showImageView.hidden = NO;
    _imageView.hidden = YES;
    self.timeLable.hidden = YES;
    [self hidePhoneImages];
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = self.startFrame;
        self.showImageView.frame = CGRectMake(0, 0, self.startFrame.size.width, self.startFrame.size.height);
    } completion:^(BOOL finished) {
        self.showImageView.hidden = YES;
        [self circleBigger];
        
    }];
}


/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    
    if (self.isExit) {
        self.isExit = NO;
        self.presentView.layer.mask = nil;
        [self.floatDelegate assistiveTocuhs];
    } else {
        [self clipcircleImageFromView:self.presentView inRect:self.startFrame];
        [self.presentView removeFromSuperview];
        [self makeIntoAnimation];
        
    }
    
    
    
}

- (void)circleSmallerWithView:(UIView *)view {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGRect startFrame = self.startFrame;
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
    CGFloat radius = [UIScreen mainScreen].bounds.size.height - 100;
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startFrame, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskStartBP.CGPath;
    maskLayer.backgroundColor = (__bridge CGColorRef )([UIColor whiteColor]);
    view.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskStartBP.CGPath));
    maskLayerAnimation.duration = 0.5f;
    maskLayerAnimation.delegate = self;
    self.samllAnimation = maskLayerAnimation;
    //    maskLayerAnimation.fillMode = kCAFillModeForwards;
    maskLayerAnimation.removedOnCompletion = NO;
    [self addSubview:view];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}



- (void)circleBigger {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self addSubview:self.presentView];
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:self.startFrame];
    CGFloat radius = [UIScreen mainScreen].bounds.size.height - 100;
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.startFrame, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
    self.presentView.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = 0.5f;
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}





#pragma mark -触摸事件监听
-(void)locationChange:(UIPanGestureRecognizer*)p
{
    //[[UIApplication sharedApplication] keyWindow]
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    if(p.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if (p.state == UIGestureRecognizerStateEnded)
    {
        
    }
    if(p.state == UIGestureRecognizerStateChanged)
    {
        //        if(panPoint.x > [UIScreen mainScreen].bounds.size.width - WIDTH/2){
        //            panPoint.x = [UIScreen mainScreen].bounds.size.width - WIDTH/2;
        //        }
        //        if(panPoint.x < WIDTH/2){
        //            panPoint.x = WIDTH/2;
        //        }
        //        if(panPoint.y > [UIScreen mainScreen].bounds.size.height - HEIGHT/2) {
        //            panPoint.y = [UIScreen mainScreen].bounds.size.height - HEIGHT/2;
        //        }
        //        if (panPoint.y < HEIGHT/2) {
        //            panPoint.y = HEIGHT/2;
        //        }
        //
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2+25);
                }];
            }
            else if(panPoint.y >= kScreenHeight-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2-25);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > kScreenHeight-HEIGHT/2)
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(WIDTH/2+25, kScreenHeight-HEIGHT/2-25);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(WIDTH/2+25, pointy);
                }];
            }
        }
        else if(panPoint.x > kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2 + 25);
                }];
            }
            else if(panPoint.y >= kScreenHeight-40-HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2 - 25);
                }];
            }
            else if (panPoint.x > kScreenWidth-WIDTH/2 - 15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(kScreenWidth-WIDTH/2 - 25, HEIGHT/2 + 25);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > kScreenHeight-HEIGHT/2 ? kScreenHeight-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.15f animations:^{
                    self.center = CGPointMake(kScreenWidth-WIDTH/2 - 25, pointy);
                }];
            }
        }
    }
}



- (void)click:(UITapGestureRecognizer*)t
{
    self.isExit = YES;
    [self makeOuttoAnimation];
    
}



- (NSString *)changeTimeFormater:(NSInteger)time{
    NSInteger minutecount = time / 60;
    
    NSInteger secondcount = time % 60;
    NSString *timeString;
    if (minutecount > 60) {
        NSInteger hour = minutecount / 60;
        minutecount = hour % 60;
        if (hour > 10) {
            if (minutecount < 10 && secondcount < 10) {
                timeString = [NSString stringWithFormat:@"%ld:0%ld:0%ld",hour,minutecount,secondcount];
                return timeString;
            }
            if (minutecount < 10) {
                timeString = [NSString stringWithFormat:@"%ld:%ld:%ld",hour,minutecount,secondcount];
                return timeString;
            }
            if (secondcount < 10) {
                timeString = [NSString stringWithFormat:@"%ld:%ld:0%ld",hour,minutecount,secondcount];
                return timeString;
                
            }
        } else {
            if (minutecount < 10 && secondcount < 10) {
                timeString = [NSString stringWithFormat:@"0%ld:0%ld:0%ld",hour,minutecount,secondcount];
                return timeString;
            }
            if (minutecount < 10) {
                timeString = [NSString stringWithFormat:@"0%ld:%ld:%ld",hour,minutecount,secondcount];
                return timeString;
            }
            if (secondcount < 10) {
                timeString = [NSString stringWithFormat:@"0%ld:%ld:0%ld",hour,minutecount,secondcount];
                return timeString;
                
            }
        }
        
    }
    if (minutecount < 10 && secondcount < 10) {
        timeString = [NSString stringWithFormat:@"0%ld:0%ld",minutecount,secondcount];
        return timeString;
    }
    if (minutecount < 10) {
        timeString = [NSString stringWithFormat:@"0%ld:%ld",minutecount,secondcount];
        return timeString;
    }
    if (secondcount < 10) {
        timeString = [NSString stringWithFormat:@"%ld:0%ld",minutecount,secondcount];
        return timeString;
        
    }
    return [NSString stringWithFormat:@"%ld:%ld",minutecount,secondcount];
}

#pragma mark -裁剪库


- (UIImage *)imageFromView:(UIView *) theView
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(theView.frame),
                                                      CGRectGetHeight(theView.frame)), NO, 1);
    
    [theView drawViewHierarchyInRect:CGRectMake(0,0,
                                                CGRectGetWidth(theView.frame),
                                                CGRectGetHeight(theView.frame))
                  afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}



-( UIImage *)getEllipseImageWithImage:(UIImage *)originImage size:(CGSize) size frame:(CGRect) rect
{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextFillPath(UIGraphicsGetCurrentContext());
    CGRect clip = rect;
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clip];
    [clipPath addClip];
    [originImage drawAtPoint:CGPointMake(0, 0)];
    UIImage *image;
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)clipcircleImageFromView:(UIView *)view inRect:(CGRect)frame {
    UIImage *image = [self imageFromView:view];
    UIImage *secondImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], frame)];
    UIImage *thirdimage = [self getEllipseImageWithImage:secondImage size:frame.size frame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.startFrame = frame;
    self.showImage = thirdimage;
    return thirdimage;
}

-(void) hidePhoneImages {
    _phoneFlowImageView1.hidden = YES;
    _phoneFlowImageView2.hidden = YES;
    _phoneFlowImageView3.hidden = YES;
}

-(void) showPhoneImages {
    _phoneFlowImageView1.hidden = NO;
    _phoneFlowImageView2.hidden = NO;
    _phoneFlowImageView3.hidden = NO;
}

-(void) convStartHere {
    _timeStart = YES;
}


@end
