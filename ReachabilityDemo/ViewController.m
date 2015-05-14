//
//  ViewController.m
//  MantleDemo
//
//  Created by zhangyafeng on 15/5/14.
//  Copyright (c) 2015年 think. All rights reserved.
//


//Reachable adj. 可获得的；可达成的
#import "ViewController.h"
#import "Reachability.h"

//    在项目中添加 SystemConfiguration.framework 库
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置监听的网址
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    //设置监听 监听网络状态的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    
    //block 响应的方法
    reachability.reachableBlock = ^(Reachability * reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络通畅");
        });
    };
    
    //当没网络的时候会走进这个方法
//    reachability.unreachableBlock = ^(Reachability * reachability){
//        NSLog(@"网络不通");
//    };
//    
    [reachability startNotifier];
}


- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        NSLog(@"网络不可用") ;
        return;
    }
    
    NSLog(@"网络可用") ;
    
    if (reach.isReachableViaWiFi) {
        
        NSLog(@"当前通过wifi连接");
    } else {
        
        NSLog( @"wifi未开启，不能用");
    }
    
    if (reach.isReachableViaWWAN) {
        NSLog(@"当前通过2g or 3g连接");
    } else {
        NSLog(@"2g or 3g网络未使用") ;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
