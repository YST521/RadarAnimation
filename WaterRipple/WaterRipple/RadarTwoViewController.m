//
//  RadarTwoViewController.m
//  WaterRipple
//
//  Created by youxin on 2018/3/7.
//  Copyright © 2018年 YST. All rights reserved.
//

#import "RadarTwoViewController.h"
#import "animation.h"

@interface RadarTwoViewController (){
    
    CGRect CGFrome;
}
//头像
@property(nonatomic,strong)UIButton *Headportrait;
//提示文字
@property(nonatomic,strong)UILabel *Prompttext;
//上下文设置圆角
@property(nonatomic,strong)CAShapeLayer *shapeLayer;

@end

@implementation RadarTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFrome=[UIScreen mainScreen].bounds;
    [self Prompttext];
    [self Headportrait];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(clickAnimation) userInfo:nil repeats:YES];
    
    
}
//搜索按钮
//- (IBAction)clickgotoButton:(id)sender {
//
//
//}
-(UIButton *)Headportrait{
    if (!_Headportrait) {
        _Headportrait=[UIButton buttonWithType:UIButtonTypeSystem];
        [_Headportrait setBackgroundColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:233/255.0 alpha:1.0]];
        _Headportrait.frame=CGRectMake(0, CGFrome.size.height-30, 60, 30) ;
        [_Headportrait setTitle:@"——>>" forState:UIControlStateNormal];
        _Headportrait.tintColor=[UIColor redColor];
        //随机颜色
        //_Headportrait.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [_Headportrait.layer addAnimation:[self moveX:0.0f X:[NSNumber numberWithFloat:CGFrome.size.width]] forKey:nil];
        [self.view addSubview:_Headportrait];
    }
    return _Headportrait;
}

-(UILabel *)Prompttext{
    if (!_Prompttext) {
        _Prompttext=[UILabel new];
        _Prompttext.frame=CGRectMake(CGFrome.size.width/2-100, 100, 200, 35);
        _Prompttext.textColor=[UIColor blueColor];
        _Prompttext.textAlignment=NSTextAlignmentCenter;
        _Prompttext.text=@"正在搜索附加人...";
        [_Prompttext.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
        _Prompttext.backgroundColor=[UIColor colorWithRed:255.0/231 green:255.0/231 blue:255.0/233 alpha:1.0];
        [self.view addSubview:_Prompttext];
    }
    return _Prompttext;
}
#pragma mark =====横向、纵向移动===========
-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x
{
    //实例化，并指定Layer的属性作为关键路径来注册
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];///.y的话就向下移动。
    //结束针
    animation.toValue = x;
    //持续时间
    animation.duration = 1.5;
    //重复次数
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = YES;//yes的话，又返回原位置了。
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    //实例化，并指定Layer的属性作为关键路径来注册
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    // 设定动画起始帧和结束帧
    animation.fromValue = [NSNumber numberWithFloat:1.0f];//起始点
    animation.toValue = [NSNumber numberWithFloat:0.0f];  //终了点。
    //动画结束时是否执行逆动画
    animation.autoreverses = YES;
    //动画时长
    animation.duration = time;
    //重复次数。永久重复的话设置为HUGE_VALF。
    animation.repeatCount = MAXFLOAT;
    //动画结束后不变回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //添加动画
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
    
}



-(void)clickAnimation{
    
    __block animation *andome=[[animation alloc] initWithFrame:CGRectMake(30, 150, CGFrome.size.width-60, CGFrome.size.width-60)];
    andome.backgroundColor=[UIColor clearColor];
    [self.view addSubview:andome];
    
    [UIView animateWithDuration:2 animations:^{
        andome.transform=CGAffineTransformScale(andome.transform, 4, 4);
        andome.alpha=0;
    } completion:^(BOOL finished) {
        [andome removeFromSuperview];
        NSLog(@"结束动画");
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
