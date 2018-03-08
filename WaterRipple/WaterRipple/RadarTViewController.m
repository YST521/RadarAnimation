//
//  RadarTViewController.m
//  WaterRipple
//
//  Created by youxin on 2018/3/7.
//  Copyright © 2018年 YST. All rights reserved.
//

#import "RadarTViewController.h"
#import "MMPulseView.h"



@interface RadarTViewController (){
    
    MMPulseView *pulseView;
}

@end

@implementation RadarTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self cratView];
}

-(void)cratView{
    pulseView = [[MMPulseView alloc]init];
    pulseView.frame = self.view.bounds;
    
    pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    pulseView.colors = @[(__bridge id)[UIColor colorWithRed:0.996 green:0.647 blue:0.008 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:1 green:0.31 blue:0.349 alpha:1].CGColor];
      CGRect screenRect = [UIScreen mainScreen].bounds;
    
    CGFloat posY = (CGRectGetHeight(screenRect)-320)/2/CGRectGetHeight(screenRect);

    
    pulseView.startPoint = CGPointMake(0.5, posY);
    pulseView.endPoint = CGPointMake(0.5, 1.0f - posY);
    
    pulseView.minRadius = 40;  //圆的半径 最大最小值
    pulseView.maxRadius = 100 *3;
    
    pulseView.duration = 3;    // 动画时间
    pulseView.count = 4;        // 次数
    pulseView.lineWidth = 5.0f; //线宽
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [btn setTitle:@"脉冲" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = pulseView.center;
    [btn addTarget:self action:@selector(actionPulse) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pulseView];
    
    [pulseView startAnimation];
}

- (void)actionPulse
{
//    MMPulseView *pulseView = self.pulseArray[1];
//
//    pulseView.tag = 1 - pulseView.tag;
//
//    (pulseView.tag>0)?[pulseView startAnimation]:[pulseView stopAnimation];
    
    [pulseView stopAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
