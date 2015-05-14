Reachability简介

Reachablity 是一个iOS下检测,iOS设备网络环境用的库。
监视目标网络是否可用
监视当前网络的连接方式
监测连接方式的变更
苹果官方提供的Doc
http://developer.apple.com/library/ios/#samplecode/Reachability/Introduction/Intro.html
 
Github上的文档
https://github.com/tonymillion/Reachability

###使用
在项目中添加 SystemConfiguration.framework 库

方式1： block监听
<pre><code>
  //设置监听的网址
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    //block 响应的方法
    reachability.reachableBlock = ^(Reachability * reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络通畅");
        });
    };
    
    //当没网络的时候会走进这个方法
    reachability.unreachableBlock = ^(Reachability * reachability){
        NSLog(@"网络不通");
    };
    
    [reachability startNotifier];

</code></pre>


方式2： 通知监听
<pre><code> 

  //设置监听的网址
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    //设置监听 监听网络状态的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [reachability startNotifier];
    
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


</code></pre>