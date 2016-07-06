//
//  BackViewController.m
//  UIBackView
//
//  Created by leotao on 16/4/11.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "BackViewController.h"
#import "UIView+Extension.h"

@interface BackViewController ()
@property (nonatomic, assign) BOOL isDraging;
@property (nonatomic, weak, readonly) UIView *mainView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, weak, readonly) UIView *rightView;

@property (nonatomic ,assign ) CGPoint startPoint;//触摸起始点
@property (nonatomic ,assign ) CGPoint endPoint;//触摸结束点
@property (nonatomic ,assign ) NSInteger moveDirection;//触摸移动方向 0为未移动 1为左右移动 2为上下移动

@end

@implementation BackViewController

//-(void)setPlayer{
//    //设置凤凰
//    UIImage *playerImage = [UIImage imageNamed:@"player"];
//    UIImageView *player = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, playerImage.size.width, playerImage.size.height)];
//    player.image = playerImage;
//    player.center = CGPointMake(160, 300);
//    [self.view addSubview:player];
//    
//    //打开可交互性
//    player.userInteractionEnabled = YES;
//    
//    player.tag = 10;
//    
//    //添加动作
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panPlayer:)];
//    //将手势添加给player
//    [player addGestureRecognizer:pan];
//}
//-(void)panPlayer:(UIPanGestureRecognizer *)pan{
//    UIImageView *player = (UIImageView *) [self.view viewWithTag:10];
//    //获取的是图像视图所在的界面的点
//    CGPoint point = [pan locationInView:self.view];
//    
//    player.center = point;
//}
//-(UIView *)leftView{
//
//    if (!_leftView) {
//        _leftView = [[UIView alloc] initWithFrame:CGRectMake(-200, 0, 200, self.view.bounds.size.height)];
//        _leftView.backgroundColor = [UIColor redColor];
//        _leftView.userInteractionEnabled = YES;
//        
//    }
//    return _leftView;
//}

//- (void)tap:(UITapGestureRecognizer *)tap{
//    [self.view addSubview:self.leftView];
//    //获取的是图像视图所在的界面的点
//    CGPoint point = [tap locationInView:self.view];
//    
//    if (point.x > 100) {
//    
//        self.leftView.center = CGPointMake(100, self.view.bounds.size.height/2);
//
//    } else{
//    
//        self.leftView.center = CGPointMake(point.x, self.view.bounds.size.height/2);
//
//    }
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  //  self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // 1.添加子控件
//    [self addChildView];
//
//    [self setPlayer];
//    
//    
//    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tap];

    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    //得到触摸点
//    UITouch *startTouch = [touches anyObject];
//    //返回触摸点坐标
//    self.startPoint = [startTouch locationInView:self.view];
//    
//    //初始化结束坐标
//    self.endPoint = self.startPoint;
//    
//    //滑动方向初始化
//    self.moveDirection = 0;
//    
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    // 获取UITouch对象
////    UITouch *touch = [touches anyObject];
////    // 获取当前点
////    CGPoint currentPoint = [touch locationInView:self.view];
////    
////    NSLog(@"%lf, %lf", currentPoint.x, currentPoint.y);
////    // 获取上一个点
////    CGPoint prePoint = [touch previousLocationInView:self.view];
////    
////    // x轴偏移量：当手指移动一点的时候，x偏移多少
////    CGFloat offsetX = currentPoint.x - prePoint.x;
////    NSLog(@"%lf", offsetX);
//   
//    //得到触摸点
//    
//    UITouch *endTouch = [touches anyObject];
//    
//    //返回触摸点坐标
//    
//    self.endPoint = [endTouch locationInView:self.view];
//    
//    
//    //左右滑动
//    
//    if (self.moveDirection == 1 || self.moveDirection == 0) {
//        
//        //左右滑动判定
//        
//        if ( self.startPoint.x - self.endPoint.x > 10 || self.startPoint.x - self.endPoint.x < - 10 ) {
//            
//            NSLog(@"%lf",self.endPoint.x);
//            //设置移动方向为左右移动
//          //  NSLog(@"%lf", self.endPoint.x-self.startPoint.x);
//            self.moveDirection = 1;
//            
//        }
//        
//        //允许左右滑动
//        
//        if (self.moveDirection == 1) {
//        
//            if (self.startPoint.x < self.endPoint.x ) {
//                
//                [self.view addSubview:self.leftView];
//                
//                [UIView animateWithDuration:3.0 animations:^{
//                
//                    if (self.endPoint.x-self.startPoint.x<80) {
//                        _leftView.center = CGPointMake((self.endPoint.x-self.startPoint.x), self.view.bounds.size.height/2);
//                    } else{
//                    
//                        _leftView.center = CGPointMake(100, self.view.bounds.size.height/2);
//                    }
//                    
//                } completion:^(BOOL finished) {
//                    
//                    _leftView.frame = CGRectMake(0, 0, 200, self.view.bounds.size.height);
//                }];
//                //右滑动
//                NSLog(@"右滑动...");
//                
//            } else if (self.startPoint.x > self.endPoint.x ) {
//                
//                //左滑动
//                NSLog(@"左滑动...");
//                
//                [UIView animateWithDuration:3.0 animations:^{
//                    
//                    if (self.endPoint.x-self.startPoint.x<100) {
//                        _leftView.center = CGPointMake(-20, self.view.bounds.size.height/2);
//                    } else{
//                        
//                        _leftView.center = CGPointMake(-60, self.view.bounds.size.height/2);
//                    }
//                    
//                } completion:^(BOOL finished) {
//                    
//                    _leftView.frame = CGRectMake(-200, 0, 200, self.view.bounds.size.height);
//                }];
//                //右滑动
//
//            }
//            
//            
//        }
//        
//        
//    }
//
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    
//    // 复位
//    if (_isDraging == NO && _mainView.frame.origin.x != 0) {
//        [UIView animateWithDuration:0.25 animations:^{
//            
//            _mainView.frame = self.view.bounds;
//        }];
//    }
//    
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    
//    CGFloat target = 0;
//    
//    _isDraging = NO;
//    
//}
//



@end
