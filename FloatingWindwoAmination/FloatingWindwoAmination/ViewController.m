//
//  ViewController.m
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *presentButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    [presentButton setTitle:@"进入" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [presentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:presentButton];

}

- (void)click:(id)sender{
    UIButton *button = sender;
    button.userInteractionEnabled = NO;
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    UINavigationController *navigationcontoller = [[UINavigationController alloc]initWithRootViewController:secondViewController];
    navigationcontoller.navigationBar.hidden = YES;
    [self presentViewController:navigationcontoller animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
