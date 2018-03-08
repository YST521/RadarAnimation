//
//  RadarViewController.h
//  WaterRipple
//
//  Created by youxin on 2018/3/7.
//  Copyright © 2018年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRadarView.h"

@interface RadarViewController :UIViewController<XHRadarViewDataSource, XHRadarViewDelegate>
@property (nonatomic, strong)XHRadarView *radarView;
@end
