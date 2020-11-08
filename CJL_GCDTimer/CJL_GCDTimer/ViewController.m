//
//  ViewController.m
//  CJL_GCDTimer
//
//  Created by - on 2020/11/8.
//  Copyright © 2020 CJL. All rights reserved.
//

#import "ViewController.h"
#import "CJLCountDownButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
//    [btn CJLCountDownBtnTouched:^void *(CJLCountDownButton *sender, NSUInteger tag) {
//
//
//        [sender CJLCountDownBtnChanging:^NSString *(CJLCountDownButton *countDownBtn, NSUInteger second) {
//            NSString *title = [NSString stringWithFormat:@"%zd秒", second];
//            return title;
//        }];
//
//        [sender CJLCountDownBtnFinished:^NSString *(CJLCountDownButton *countDownBtn, NSUInteger second) {
//
//        }];
//
//    }];
    
}


@end
