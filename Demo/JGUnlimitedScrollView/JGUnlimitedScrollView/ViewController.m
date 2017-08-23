//
//  ViewController.m
//  JGUnlimitedScrollView
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无限轮播器";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma - mark -    UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    NSString *title = @"普通自动和手动轮播";
    if (indexPath.row == 1) {
        title = @"加载网络图片和垂直滚动";
    }
    if (indexPath.row == 2) {
        title = @"自定义UIPageControl";
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

#pragma - mark -    UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DemoViewController *demoVC = [DemoViewController new];
    [self.navigationController pushViewController:demoVC animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            demoVC.title = @"普通自动和手动轮播";
            [demoVC normalAndManualStatus];
        }
            break;
        case 1:
        {
            demoVC.title = @"加载网络图片和垂直滚动";
            [demoVC loadImageUrlAndVerticalMove];
        }
            break;
        case 2:
        {
            demoVC.title = @"自定义UIPageControl";
            [demoVC customPageControl];
        }
            break;
            
        default:
            break;
    }
}

@end
