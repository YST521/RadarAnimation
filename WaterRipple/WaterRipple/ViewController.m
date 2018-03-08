//
//  ViewController.m
//  WaterRipple
//
//  Created by youxin on 2018/3/7.
//  Copyright © 2018年 YST. All rights reserved.
//

#import "ViewController.h"
#import "ShowController.h"
#import "water.h"
#import "Radar.h"
#import "RadarViewController.h"
#import "RadarAnimationView.h"
#import "RadarTwoViewController.h"
#import "WaveView.h"
#import "MoreRadarViewController.h"
#import "RadarTViewController.h"
#import "CircleViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tabV;
@property(nonatomic,strong) NSArray *dataArry;
@property (nonatomic,strong) WaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    
    self.tabV = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabV];
    self.tabV.dataSource = self;
    self.tabV.delegate   = self;
    [self.tabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.dataArry = @[@"水波纹",@"同心圆波纹",@"雷达扫描",@"雷达波",@"雷达波2",@"点击位置出现放大圈",@"多种圆脉冲动画",@"圆环脉冲",@"渐变圆环"];

   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tabV dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataArry[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowController *showVC =[[ShowController alloc]init];
    
    switch (indexPath.row) {
            
            
        case 0:{
            //水波纹
            
                water *ww = [[water alloc]init];
                ww.frame = self.view.bounds;
                [showVC.view addSubview:ww];
             [self presentViewController:showVC animated:YES completion:nil];
        }
            break;
        case 1:{
            //同心圆
            Radar *centerRadarView = [[Radar alloc] initWithFrame:CGRectMake(0, 0, 135, 135)];
            //centerRadarView.frame = self.view.bounds;;
            centerRadarView .backgroundColor =[UIColor redColor];
            centerRadarView.center = self.view.center;
            [showVC.view addSubview:centerRadarView];
             [self presentViewController:showVC animated:YES completion:nil];
        }
            break;
        case 2:{
            //雷达
            RadarViewController *dadarVC = [[RadarViewController alloc]init];
        //这个地方用模态跳转 下一页动画不走 需要加延时
         [self presentViewController:dadarVC animated:YES completion:nil];
            
            
            //[self.navigationController pushViewController:dadarVC animated:YES];
           
        }
            break;
            
        case 3:{
            //雷达
         //demo   https://www.jianshu.com/p/c99bea074aad
            
            self.view.backgroundColor = [UIColor whiteColor];
            RadarAnimationView *rader = [[RadarAnimationView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
            
            rader.center = self.view.center;
            
            rader.backgroundColor = [UIColor redColor];
            rader.image = [UIImage imageNamed:@"IMG_1314.JPG"];
            
            rader.block = ^{
                
                NSLog(@"1");
            };
            
            rader.selectBlock = ^{
                
                NSLog(@"2");
            };
            
        
            [showVC.view addSubview:rader];
            [self presentViewController:showVC animated:YES completion:nil];
        }
            break;
            
        case 4:{
            //雷达
            RadarTwoViewController *radarV = [[ RadarTwoViewController alloc]init];
            [self presentViewController:radarV animated:YES completion:nil];
            
        }
            break;
        case 5:{
           
            self.view.backgroundColor = [UIColor whiteColor];
//            [self.view addSubview:self.waveView];
            [showVC.view addSubview:self.waveView];
            [self presentViewController:showVC animated:YES completion:nil];
            
        }
            break;
            
        case 6:{
            
            MoreRadarViewController *moreVC =[[MoreRadarViewController alloc]init];
            //用模态 需要加延时
//            [self presentViewController:moreVC animated:YES completion:nil];
            [self.navigationController pushViewController:moreVC animated:YES];
            
        }
            break;
        
        case 7:{
            
           RadarTViewController *tVC =[[RadarTViewController alloc]init];
         
            [self.navigationController pushViewController:tVC  animated:YES];
            
        }
            break;
        
        case 8:{
            
            CircleViewController *circleVC =[[CircleViewController alloc]init];
            
            [self.navigationController pushViewController:circleVC  animated:YES];
            
        }
            break;
            
        default:
            break;
    }
   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(WaveView*)waveView
{
    if (!_waveView) {
        _waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _waveView.backgroundColor = [UIColor whiteColor];
    }
    return _waveView;
}

@end
