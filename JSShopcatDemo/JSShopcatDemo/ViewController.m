//
//  ViewController.m
//  JSShopcatDemo
//
//  Created by Macx on 16/8/25.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "ViewController.h"

#import "WTShopcatViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"click me " forState:0];
    button.backgroundColor =[UIColor greenColor];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(enterShopcat) forControlEvents:UIControlEventTouchUpInside];
}
- (void)enterShopcat {
    WTShopcatViewController *vc = [[WTShopcatViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
