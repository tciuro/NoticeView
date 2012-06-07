//
//  WBNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBNoticeView : NSObject

typedef enum {
    WBNoticeViewTypeError = 0,
    WBNoticeViewTypeSuccess,
    WBNoticeViewTypeSticky
} WBNoticeViewType;

+ (WBNoticeView *)defaultManager;

// Error notice methods

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message;

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message
                     duration:(float)duration
                        delay:(float)delay
                        alpha:(float)alpha;

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message
                     duration:(float)duration
                        delay:(float)delay
                        alpha:(float)alpha
                      yOrigin:(CGFloat)origin;

// Success notice methods

- (void)showSuccessNoticeInView:(UIView *)view
                        message:(NSString *)message;

- (void)showSuccessNoticeInView:(UIView *)view
                        message:(NSString *)message
                       duration:(float)duration
                          delay:(float)delay
                          alpha:(float)alpha
                        yOrigin:(CGFloat)origin;

// Sticky notice methods

- (void)showStickyNoticeInView:(UIView *)view
                       message:(NSString *)message
                      duration:(float)duration
                         alpha:(float)alpha
                       yOrigin:(CGFloat)origin;

@end
