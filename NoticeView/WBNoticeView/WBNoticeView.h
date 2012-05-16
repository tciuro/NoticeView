//
//  WBNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBNoticeView : NSObject

+ (WBNoticeView *)defaultManager;

// Error notice methods

- (void)showErrorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message;
- (void)showErrorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message duration:(float)duration delay:(float)delay;

// Success notice methods

- (void)showSuccessNoticeInView:(UIView *)view message:(NSString *)message;
- (void)showSuccessNoticeInView:(UIView *)view message:(NSString *)message duration:(float)duration delay:(float)delay;

@end
