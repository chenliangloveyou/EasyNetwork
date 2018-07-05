//
//  ViewController.m
//  EasyNetworkDemo
//
//  Created by nf on 2018/2/24.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "ViewController.h"
#import "EasyNetworkEnvironment.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //test  dsafsfa
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[EasyNetworkEnvironment shareEnvironment] switchEnvironment];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
