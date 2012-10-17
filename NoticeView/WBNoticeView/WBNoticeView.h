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

typedef void (^WBNoticeViewDismissedBlock)(void);

@property (nonatomic, readwrite) WBNoticeViewType noticeType;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *title; // default: @"Unknown Error"

@property (nonatomic, readwrite) CGFloat duration; // default: 0.5
@property (nonatomic, readwrite) CGFloat delay; // default: 2.0
@property (nonatomic, readwrite) CGFloat alpha; // default: 1.0
@property (nonatomic, readwrite) CGFloat originY; // default: 0.0
@property (nonatomic, readwrite, getter = isSticky) BOOL sticky; // default NO (Error and Success notice); YES (Sticky notice)
@property (nonatomic, readwrite, strong) WBNoticeViewDismissedBlock dismissedBlock;


+ (WBNoticeView *)defaultManager;

- (id)initWithView:(UIView *)theView title:(NSString *)theTitle; // throws NSInvalidArgumentException is view is nil.

- (void)show; // Must be implemented in the subclasses, or else it'll raise an exception. 

- (void)dismissNotice; // Only succeeds if the notice is sticky.

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
