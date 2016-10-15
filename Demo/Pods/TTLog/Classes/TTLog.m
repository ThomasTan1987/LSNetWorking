//
//  TTLog.m
//  TutorTalk
//
//  Created by ThoamsTan on 16/8/3.
//  Copyright © 2016年 TutorABC. All rights reserved.
//

#import "TTLog.h"
#import <UIKit/UIKit.h>
@interface TTLog()
@property (nonatomic, strong)NSMutableString *logText;
@property (nonatomic, strong)UIView *logView;
@property (nonatomic, strong)UITextView *textView;
@end
@implementation TTLog
static TTLog *instance = nil;
+ (TTLog*)sharedLog
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TTLog alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _logText = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)log:(NSString *)fmt,...
{
    if (self.enableLog) {
        va_list args;
        va_start(args, fmt);
        //写到文件
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MM-dd hh:mm:ss"];
        NSString *dateString = [format stringFromDate:[NSDate date]];
        NSString *logString = [[NSString alloc] initWithFormat:fmt arguments:args];
        [self.logText appendFormat:@"[%@] %@\n",dateString,logString];
        if (self.logView.superview) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = self.logText;
            });
        }
        va_end(args);
    }
}
- (BOOL)isShowLog
{
    if (self.logView && self.logView.superview) {
        return YES;
    }else{
        return NO;
    }
}
- (void)showLogView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!self.logView) {
        self.logView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [window addSubview:self.logView];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.logView.bounds];
        self.textView = textView;
        self.textView.textColor = [UIColor whiteColor];
        self.textView.backgroundColor = [UIColor blackColor];
        textView.text = self.logText;
        [self.logView addSubview:textView];
        textView.editable = NO;
        
        
        UIButton *btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnReset setTitle:@"清除" forState:UIControlStateNormal];
        btnReset.backgroundColor = [UIColor grayColor];
        btnReset.frame = CGRectMake(0, self.logView.bounds.size.height - 30, 50, 30);
        [self.logView addSubview:btnReset];
        [btnReset addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    }
    self.textView.text = self.logText;
    [window addSubview:self.logView];
}
- (void)reset
{
    self.logText = [[NSMutableString alloc] init];
    self.textView.text = @"";
}
- (void)hideLogView
{
    [self.logView removeFromSuperview];
}
#pragma private

@end
