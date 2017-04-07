//
//  ViewController.m
//  ZXAnimationRefresh
//
//  Created by zhang on 2017/4/7.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "ViewController.h"
#import "XXFreshAnimationHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XXFreshAnimationHeader *header = [XXFreshAnimationHeader new];
    header.center = CGPointMake(200, 200);
    [self.view addSubview:header];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
