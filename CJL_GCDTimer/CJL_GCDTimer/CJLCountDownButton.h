//
//  CJLCountDownButton.h
//  CJL_GCDTimer
//
//  Created by - on 2020/11/8.
//  Copyright © 2020 CJL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJLCountDownButton;
typedef NSString* (^CJLCountDownChanging)(CJLCountDownButton *countDownBtn, NSUInteger second);
typedef NSString* (^CJLCountDownFinished)(CJLCountDownButton *countDownBtn, NSUInteger second);
typedef void (^CJLCountDownTouched)(CJLCountDownButton *countDownBtn, NSUInteger tag);

NS_ASSUME_NONNULL_BEGIN

@interface CJLCountDownButton : UIButton

@property(nonatomic, strong) id userInfo;

//倒计时按钮点击回调
- (void)CJLCountDownBtnTouched:(CJLCountDownTouched)touched Changing:(CJLCountDownChanging)changing Finished:(CJLCountDownFinished)finished;

//开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;

//停止倒计时
//- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
