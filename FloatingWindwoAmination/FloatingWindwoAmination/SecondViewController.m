//
//  SecondViewController.m
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//

#import "SecondViewController.h"
#import "FloatingWindow.h"
#import "AppDelegate.h"

@interface SecondViewController () <FloatingWindowTouchDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *callBackButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 50, 40)];
    [callBackButton setTitle:@"缩小" forState:UIControlStateNormal];
    [callBackButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [callBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:callBackButton];
}

- (void) click {
    
    
    AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    deleage.floatWindow.isCannotTouch = NO;
    __weak typeof (self) weakSelf = self;
    deleage.floatWindow.floatDelegate = weakSelf;
    
    [deleage.floatWindow startWithTime:30 presentview:self.view inRect:CGRectMake(100, 100, 100, 100)];
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        
    }];


}




-(void)assistiveTocuhs {
    
    AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    deleage.floatWindow.isCannotTouch = YES;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
//    navigationController.navigationBar.hidden = YES;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navigationController animated:NO completion:^{
//        
//    }];
//    [deleage.floatWindow close];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
