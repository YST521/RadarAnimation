//
//  CircleViewController.m
//  WaterRipple
//
//  Created by youxin on 2018/3/8.
//  Copyright © 2018年 YST. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"
#import "STLoopProgressView.h"
//#import "STLoopProgressView+BaseConfiguration.h"

@interface CircleViewController (){
    CAShapeLayer *shapeLayer;
    
}
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)STLoopProgressView *progressV;
@property(nonatomic,strong)UISlider *slider;
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  https://www.jianshu.com/p/f3754aa9dbcd
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    [self creatCircle];
    [self creastProgress];
}

-(void)creastProgress{
    
    self.progressV =[[STLoopProgressView alloc]init];
    self.progressV.frame = CGRectMake(100, 450,200,200);
    [self.view addSubview:self.progressV];
    
    self.progressV.backgroundColor =[UIColor cyanColor];
//   self.progressV.persentage = 0.2;
  self.progressV.persentage = 0.2;
    
    self.slider =[[UISlider alloc]init];
    self.slider.frame = CGRectMake(50, 650, 350, 40);
    [self.view addSubview:self.slider];
    [self.slider addTarget:self action:@selector(slider:) forControlEvents:(UIControlEventValueChanged)];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
}

-(void)slider:(UISlider*)sender{
    
  self.progressV.persentage = sender.value/100;
}

-(void)creatCircle{
    
    CircleView *circle = [[CircleView alloc] initWithFrame:CGRectMake(80, 230, 200, 200)];
    circle.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:circle];

    
}

-(void)creatView{
    
    //创建一个图层
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(100, 100, 110, 110);
    _layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:_layer];
    
    //创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(55, 55) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //圆环遮罩
 shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    [_layer setMask:shapeLayer];
    
   
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor blueColor].CGColor,[UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, 110, 55);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5].CGColor,(id)[[UIColor whiteColor] CGColor], nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = bezierPath.CGPath;
    gradientLayer1.frame = CGRectMake(0, 55, 110, 55);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [_layer addSublayer:gradientLayer]; //设置颜色渐变
    [_layer addSublayer:gradientLayer1];
    
    [self animation];
    
}

- (void)animation {
    //动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:4.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 6;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_layer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
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
