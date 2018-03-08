//
//  WaveView.m
//  TouchWave
//
//  Created by wangdan on 16/2/1.
//  Copyright © 2016年 wangdan. All rights reserved.
//

#import "WaveView.h"

#define MaxRadius     1500
#define MaxRepeatCnt  1000

#define AddedCntPerSec      60
#define AddedRadiusPerSec   250

@interface WaveView()

@property (nonatomic,assign) NSInteger repeatCnt;
@property (nonatomic,assign) CGPoint touchPoint;
@property (nonatomic,assign) CGFloat currentRadius;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) CADisplayLink *link;

@end


@implementation WaveView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//
//        NSTimer *tim = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(star) userInfo:nil repeats:nil];
//
//        [[NSRunLoop currentRunLoop] addTimer:tim forMode:NSRunLoopCommonModes];
        
        [self star];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSEnumerator *emumerRator =  [touches objectEnumerator];
    UITouch *touch = [emumerRator nextObject];
    CGPoint location = [touch locationInView:self];
    _touchPoint = location;
    [_link invalidate];
    _link = nil;
    _repeatCnt = 0;
    _currentRadius = 10;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)star{
//    NSEnumerator *emumerRator =  [touches objectEnumerator];
//    UITouch *touch = [emumerRator nextObject];
//    CGPoint location = [touch locationInView:self];
    _touchPoint = self.center;
    [_link invalidate];
    _link = nil;
    _repeatCnt = 0;
    _currentRadius = 10;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


-(void)beginDrawRect
{
    _repeatCnt++;
    if (_repeatCnt > MaxRepeatCnt) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    CGFloat setpFloat =  MaxRadius*1.f/MaxRepeatCnt;
    _currentRadius = setpFloat*_repeatCnt;
    [self setNeedsDisplay];
}



-(void)drawRect:(CGRect)rect
{
    UIColor *drawColor = [UIColor blackColor];
    [drawColor setStroke];
    CGRect newFrame = CGRectMake(_touchPoint.x-_currentRadius/2, _touchPoint.y-_currentRadius/2, _currentRadius, _currentRadius);
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:newFrame cornerRadius:_currentRadius];
    [bPath closePath];
    [bPath setLineWidth:1];
    [bPath stroke];
}



-(CADisplayLink*)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkHandler)];
        _link.frameInterval = 1;
    }
    return _link;
}


-(void)linkHandler
{
    _currentRadius += 1.f*AddedRadiusPerSec/AddedCntPerSec;
    if (_currentRadius > MaxRadius) {
        [_link invalidate];
        _link = nil;
    }
    [self setNeedsDisplay];
    
}


@end
