//
//  ViewController.m
//  UIBackView
//
//  Created by leotao on 16/4/11.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ViewController.h"
#import "BackViewController.h"
#import "UIViewController+NJKFullScreenSupport.h"

#define IS_RUNNING_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIView  * headView;

@property (nonatomic) NJKScrollFullScreen *scrollProxy;

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_scrollProxy reset];
    [self showNavigationBar:animated];
    [self showToolbar:animated];
}


-(UIView *)headView{

    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _headView.backgroundColor = [UIColor redColor];
    }
    
    return _headView;
}
-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}

-(UIButton *)backButton{
    
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 400, 40, 40)];
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        [_backButton setBackgroundColor:[UIColor redColor]];
        _backButton.alpha = 0.6;
        [_backButton addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
        self.backButton.hidden = YES;
    }
    return _backButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self]; // UIScrollViewDelegate and UITableViewDelegate methods proxy to ViewController
    
    self.tableView.delegate = (id)_scrollProxy; // cast for surpress incompatible warnings
    
    _scrollProxy.delegate = self;
    
    if (!IS_RUNNING_IOS7) {
        // support full screen on iOS 6
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    }

    
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backButton];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 26;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *idenf = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idenf forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSLog(@"%ld", (long)indexPath.row);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 160) {
        self.backButton.hidden = NO;
    } else {
    
        self.backButton.hidden = YES;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    BackViewController *backView = [[BackViewController alloc] init];
    
    [self.navigationController pushViewController:backView animated:YES];
    
}

-(void)backTop{
    
     [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
 
}

#pragma mark -
#pragma mark NJKScrollFullScreenDelegate

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
    [self moveToolbar:-deltaY animated:YES]; // move to revese direction
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
    [self moveToolbar:-deltaY animated:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
    [self hideNavigationBar:YES];
    [self hideToolbar:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showNavigationBar:YES];
    [self showToolbar:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_scrollProxy reset];
    [self showNavigationBar:YES];
    [self showToolbar:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
