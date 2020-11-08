//
//  CJLCountDownButton.m
//  CJL_GCDTimer
//
//  Created by - on 2020/11/8.
//  Copyright © 2020 CJL. All rights reserved.
//

#import "CJLCountDownButton.h"

@interface CJLCountDownButton()

@property(nonatomic, strong) dispatch_source_t timer;

@property(nonatomic, assign) NSInteger currentSecond;

@property(nonatomic, assign) NSInteger totalSecond;

@property(nonatomic, strong) CJLCountDownTouched touched;
@property(nonatomic, strong) CJLCountDownChanging changing;
@property(nonatomic, strong) CJLCountDownFinished finished;

@end

@implementation CJLCountDownButton


#pragma mark ~~~~~~~~~~~~~ public
//倒计时按钮点击回调 - 倒计时时间改变回调 - 倒计时结束回调
- (void)CJLCountDownBtnTouched:(CJLCountDownTouched)touched Changing:(CJLCountDownChanging)changing Finished:(CJLCountDownFinished)finished{
    self.touched = touched;
    self.changing = changing;
    self.finished = finished;
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)touched:(CJLCountDownButton *)sender{
    if (self.touched) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.touched(sender,sender.tag);
        });
    }
}


//开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second{
    
    self.totalSecond = second;
    self.currentSecond = second;
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    
//    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        
        
        
        if (self.currentSecond <= 0.0) {
            [self stopCountDown];
        }else{
            
            self.currentSecond = self.totalSecond--;
            NSLog(@"倒计时 - %zd", self.currentSecond);
            
            if (self.changing) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = self.changing(self, self.currentSecond);
                    [self setTitle:title forState:UIControlStateNormal];
                    [self setTitle:title forState:UIControlStateDisabled];
                });
            }else{
                NSString *title = [NSString stringWithFormat:@"%zd秒", self.currentSecond];
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            }
        }
    });
    
    dispatch_resume(self.timer);
}

//停止倒计时
- (void)stopCountDown{
    
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        
        self.currentSecond = self.totalSecond;
        
        if (self.finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = self.finished(self, self.totalSecond);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }else{
            NSString *title = @"重新获取";
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
    }
}


@end
