# CJLCountDownButton
使用dispatch source实现倒计时按钮

## 使用方式

直接将对应文件拖入项目即可

```
CJLCountDownButton *btn = [CJLCountDownButton buttonWithType:UIButtonTypeCustom];
btn.frame = CGRectMake(80, 200, 100, 44);
[btn setTitle:@"开始" forState:UIControlStateNormal];
btn.backgroundColor = UIColor.blueColor;
[self.view addSubview:btn];
    
    
[btn CJLCountDownBtnTouched:^void (CJLCountDownButton *sender, NSUInteger tag) {
    sender.enabled = NO;
    [sender startCountDownWithSecond:10];

} Changing:^NSString *(CJLCountDownButton *sender, NSUInteger second) {
    NSString *title = [NSString stringWithFormat:@"%zd秒", second];
    return title;
} Finished:^NSString *(CJLCountDownButton *sender, NSUInteger second) {
    sender.enabled = YES;
    return @"重新获取";
}];
```

### 注意

倒计时在app进入后台后会被停止，可以利用苹果给出的三种类型的程序能够保持在后台运行：音频播放类，位置更新类等，这里采用的是`音频播放`的方式

- 在info.plist中添加`Required background modes`键，value为`App plays audio`

- 在target中导入`AVFoundation`系统库

- 在AppDelegate.m文件中写下如下代码

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSError *setCategoryErr = nil;
    NSError *activationErr = nil;
   [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: &setCategoryErr];
    [[AVAudioSession sharedInstance]
     setActive: YES
     error: &activationErr];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            bgTask = UIBackgroundTaskInvalid;
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}
```