//
//  water.m
//  WaterRipple
//
//  Created by youxin on 2018/3/7.
//  Copyright © 2018年 YST. All rights reserved.
//

#import "water.h"






static const CGFloat kExtraHeight = 10;     // 保证水波波峰不被裁剪，增加部分额外的高度


@interface water()


@property (assign,nonatomic) CGFloat offxset;   //波的偏移量，用于设置波的移动效果


@property (nonatomic, strong) CADisplayLink *displayLink;    //线程的使用


@property (strong,nonatomic) CAShapeLayer *shape;     //波形图的绘制,第一重


@property (strong,nonatomic) CAGradientLayer *gradientLayer;   //波形图的颜色绘制，水波纹色彩绘制,第一重


@property (assign,nonatomic) CGFloat speedx;   //波在x轴方向上的移动速度


@property (nonatomic, assign) CGFloat waveCycle;      // 波纹周期，T = 2π/ω


@property (assign,nonatomic) CGFloat waveStartY;  //水波纹Y轴的起始位置
@property (assign,nonatomic) CGFloat percent;
@property (assign,nonatomic) CGFloat waveAmplitude;
@end

@implementation water


- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect rect = frame;
    
    CGFloat min = frame.size.width > frame.size.height ? frame.size.height : frame.size.width;
    
    rect.size.height = min;
    
    rect.size.width = min;
    
    self = [super initWithFrame:rect];
    
    if (self) {
        
        [self defalute];
        
        [self setBackgroundColor:[UIColor colorWithRed:4 / 255.0 green:181 / 255.0 blue:108 / 255.0 alpha:1]];
        
        //        self.clipsToBounds = YES;  //设置默认将超出父视图的部分进行裁剪
        
    }
    
    return self;
    
}


/**
 
 配置一些常量
 
 */

- (void) defalute{
    
    _speedx = 0.2 / M_PI;    //设置移动速度
    
    _offxset = 0;    //设置最开始的偏移量
    
    _percent = 0.3;   //设置波浪上升的百分比
    
    _waveAmplitude = 4.f;  //波峰默认为10
    
}


/**
 
 设置该波形色彩layer的色彩占比
 
 */

- (void) setLoactions{
    
    NSInteger count = [self.gradientLayer.colors count];
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        
        NSNumber *num = @(1.0/count + 1.0/count * i);
        
        [locations addObject:num];
        
    }
    
    NSNumber *lastNum = @(1.0f);
    
    [locations addObject:lastNum];
    
    _gradientLayer.locations = locations;
    
}


-(void) initLayer{
    
    if (self.shape)
        
    {
        
        [self.shape removeFromSuperlayer];
        
        self.shape = nil;
        
    }
    
    self.shape = [CAShapeLayer layer];
    
    self.shape.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}


-(void) initGraditent:(CAGradientLayer *) layer shape:(CAShapeLayer *) shape colors:(NSArray*) colors{
    
    if (layer)
        
    {
        
        [layer removeFromSuperlayer];
        
        layer = nil;
        
    }
    
    layer = [CAGradientLayer layer];
    
    layer.colors = colors;
    
    
    
    layer.startPoint = CGPointMake(0.5, 0.5);
    
    layer.endPoint = CGPointMake(0.5,1);
    
    
    
    layer.frame = [self gradientLayerFrame];
    
    
    
    //当将self.shape做为self.gradientLayer的裁剪时，self.shape的路径坐标系是以self.gradientLayer的坐标为准的
    
    [layer setMask:shape];
    
    [self.layer addSublayer:layer];
    
}


- (void) setLayerConfig{
    
    [self initLayer];
    
    
    
    [self initGraditent:self.gradientLayer shape:self.shape colors:[self defaultColors]];
    
}


- (void)drawRect:(CGRect)rect{
    
    _waveStartY = CGRectGetHeight(self.frame) * (1-self.percent);  //默认波浪的起始
    
    _waveCycle = 4 * M_PI / CGRectGetWidth(self.frame);
    
    
    
    [self setLayerConfig];
    
    //设置成圆形
    
    self.layer.cornerRadius = rect.size.width/2;
    
    
    
    if (self.displayLink)
        
    {
        
        [self.displayLink invalidate];
        
        self.displayLink = nil;
        
    }
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setCurrentWave:)];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}


- (CGRect)gradientLayerFrame

{
    
    // gradientLayer在上升完成之后的frame值，如果gradientLayer在上升过程中不断变化frame值会导致一开始绘制卡顿，所以只进行一次赋值
    
    
    
    CGFloat gradientLayerHeight = CGRectGetHeight(self.frame) * self.percent + kExtraHeight;
    
    
    
    if (gradientLayerHeight > CGRectGetHeight(self.frame))
        
    {
        
        gradientLayerHeight = CGRectGetHeight(self.frame);
        
    }
    
    
    
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame) - gradientLayerHeight, CGRectGetWidth(self.frame), gradientLayerHeight);
    
    return frame;
    
}


/**
 
 获取第一重浪的颜色数组
 
 @return 返回颜色数组
 
 */

- (NSArray *)defaultColors

{
    
    // 默认的渐变色
    
    UIColor *color0 = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1];
    
    UIColor *color1 = [UIColor colorWithRed:105 / 255.0 green:192 / 255.0 blue:154 / 255.0 alpha:1];
    
    
    
    NSArray *colors = @[(__bridge id)color0.CGColor, (__bridge id)color1.CGColor];
    
    return colors;
    
}


- (CGMutablePathRef) drawSin:(CGFloat) offset{
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置起始位置
    
    CGPathMoveToPoint(path, nil, 0, self.waveStartY);
    
    CGFloat width = self.frame.size.width;
    
    for (float x = 0; x <= width ; x++) {
        
        CGFloat y2 = self.waveAmplitude * sin(self.waveCycle * x + offset+3*M_PI/4)  + self.waveAmplitude;
        
        CGPathAddLineToPoint(path, nil, x, y2);
        
        CGFloat y1 = self.waveAmplitude * sin(self.waveCycle/1.5 * x + offset+3*M_PI/4)  + self.waveAmplitude*1.2;
        
        CGPathAddLineToPoint(path, nil, x, y1);
        
        CGFloat y = self.waveAmplitude * sin(self.waveCycle/2 * x + offset)  + self.waveAmplitude*1.4;
        
        CGPathAddLineToPoint(path, nil, x, y);
        
    }
    
    CGPathAddLineToPoint(path, nil, width, self.frame.size.height);
    
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    
    
    
    CGPathCloseSubpath(path);
    
    self.shape.path = path;
    
    
    CGPathRelease(path);
    
    return path;
    
}


- (void)setCurrentWave:(CADisplayLink *)displayLink{
    
    self.offxset = self.offxset + self.speedx;
    
    [self drawSin:self.offxset];
    
}


@end


