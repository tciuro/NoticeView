//
//  WBNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"
#import "UILabel+WBExtensions.h"

#import <QuartzCore/QuartzCore.h>

typedef enum {
    WBNoticeViewTypeError = 0,
    WBNoticeViewTypeSuccess
} WBNoticeViewType;

@interface WBNoticeView ()

@property(nonatomic, strong) UIView *noticeView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

- (void)_showNoticeOfType:(WBNoticeViewType)noticeType
                     view:(UIView *)view
                    title:(NSString *)title
                  message:(NSString *)message
                 duration:(float)duration
                    delay:(float)delay
                    alpha:(float)alpha;

@end

@implementation WBNoticeView

@synthesize noticeView, imageView, titleLabel, messageLabel;

+ (WBNoticeView *)defaultManager
{
    static WBNoticeView *__sWBNoticeView = nil;
    
    if (nil ==  __sWBNoticeView) {
        __sWBNoticeView = [WBNoticeView new];
    }
    
    return __sWBNoticeView;
}

#pragma mark - Error Notice Methods

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message
{
    [self _showNoticeOfType:WBNoticeViewTypeError
                       view:view
                      title:title
                    message:message
                   duration:0.0
                      delay:0.0
                      alpha:0.8];
}

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message
                     duration:(float)duration
                        delay:(float)delay
                        alpha:(float)alpha
{
    [self _showNoticeOfType:WBNoticeViewTypeError
                       view:view
                      title:title
                    message:message
                   duration:duration
                      delay:delay
                      alpha:alpha];
}

- (void)showSuccessNoticeInView:(UIView *)view
                        message:(NSString *)message
{
    [self _showNoticeOfType:WBNoticeViewTypeSuccess
                       view:view
                      title:message
                    message:nil
                   duration:0.0
                      delay:0.0
                      alpha:0.8];
}

- (void)showSuccessNoticeInView:(UIView *)view
                        message:(NSString *)message
                       duration:(float)duration
                          delay:(float)delay
                          alpha:(float)alpha
{
    [self _showNoticeOfType:WBNoticeViewTypeSuccess
                       view:view
                      title:message
                    message:nil
                   duration:duration
                      delay:delay
                      alpha:alpha];
}

#pragma mark - Private Section

- (void)_showNoticeOfType:(WBNoticeViewType)noticeType
                     view:(UIView *)view
                    title:(NSString *)title
                  message:(NSString *)message
                 duration:(float)duration
                    delay:(float)delay
                    alpha:(float)alpha
{
    if (nil == noticeView) {
        // Sanity check
        if (nil == view) {
            [[NSException exceptionWithName:NSInvalidArgumentException
                                     reason:[NSString stringWithFormat:@"*** -[%@ %@]: 'view' cannot be nil.", [self class], NSStringFromSelector(_cmd)]
                                   userInfo:nil]raise];  
        }
        
        // Set default values if needed
        if (nil == title) title = @"Unknown Error";
        if (nil == message) message = @"Information not provided.";
        if (0.0 == duration) duration = 0.3;
        if (0.0 == delay) delay = 2.0;
        
        // Locate the images
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
        NSString *noticeBackgroundImageName = [path stringByAppendingPathComponent:(WBNoticeViewTypeError == noticeType ? @"notice_error.png" : @"notice_success.png")];
        NSString *noticeIconImageName = [path stringByAppendingPathComponent:(WBNoticeViewTypeError == noticeType ? @"notice_error_icon.png" : @"notice_success_icon.png")];
        NSInteger numberOfLines = 1;
        CGRect r;

        if (WBNoticeViewTypeError == noticeType) {
            // Make the message label
            self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 19.0, 245.0, 30.0)];
            self.messageLabel.font = [UIFont systemFontOfSize:13.0];
            self.messageLabel.textColor = [UIColor colorWithRed:239.0/255.0 green:167.0/255.0 blue:163.0/255.0 alpha:1.0];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.text = message;
            
            numberOfLines = [[self.messageLabel lines]count];
            self.messageLabel.numberOfLines = (numberOfLines < 2 ? 1 : 2);
            r = self.messageLabel.frame;
        }
        
        // Gather the dimensions of the UI elements
        float noticeViewHeight = 0.0;
        float hiddenYOrigin = 0.0;
        if (numberOfLines < 2) {
            noticeViewHeight = 50.0;
            hiddenYOrigin = -60.0;
        } else {
            noticeViewHeight = 70.0;
            hiddenYOrigin = -80.0;
        }
        
        // Reposition the message label, since it may have shifted due to the number of lines change
        if (WBNoticeViewTypeError == noticeType) {
            r.origin.y = (numberOfLines < 2 ? 19.0 : 27.0);
            self.messageLabel.frame = r;
        }
        
        // Make and add the notice view
        self.noticeView = [[UIView alloc]initWithFrame:CGRectMake(0.0, -60.0, 320.0, noticeViewHeight)];
        [view addSubview:self.noticeView];
        
        // Make and add the image view
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, noticeViewHeight)];
        [self.imageView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        self.imageView.image = [UIImage imageWithContentsOfFile:noticeBackgroundImageName];
        [self.noticeView addSubview:self.imageView];
        
        // Make and add the warning icon view
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 8.0, 37.0, 34.0)];
        iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
        [self.noticeView addSubview:iconView];
        
        // Make and add the title label
        float titleYOrigin = (WBNoticeViewTypeError == noticeType ? 10.0 : 18.0);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, 255.0, 15.0)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.text = title;
        [self.noticeView addSubview:self.titleLabel];
        
        // Add the message label if it applies
        if (WBNoticeViewTypeError == noticeType) {
            [self.noticeView addSubview:self.messageLabel];
        }
        
        // Add the drop shadow to  profileImageView
        self.imageView.layer.shadowColor = [[UIColor blackColor]CGColor];
        self.imageView.layer.shadowOffset = CGSizeMake(0.0, 3);
        self.imageView.layer.shadowOpacity = 0.50;
        self.imageView.layer.masksToBounds = NO;
        self.imageView.layer.shouldRasterize = YES;
        
        // Go ahead, display it and then hide it automatically
        [UIView animateWithDuration:duration animations:^ {
            CGRect newFrame = self.noticeView.frame;
            newFrame.origin.y = 0.0;
            self.noticeView.frame = newFrame;
            self.noticeView.alpha = alpha;
        } completion:^ (BOOL finished) {
            if (finished) {
                // Display for 2 seconds, then hide it again
                [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
                    CGRect newFrame = self.noticeView.frame;
                    newFrame.origin.y = hiddenYOrigin;
                    self.noticeView.frame = newFrame;
                } completion:^ (BOOL finished) {
                    // Cleanup
                    noticeView = nil;
                    imageView = nil;
                    titleLabel = nil;
                    messageLabel = nil;
                }];
            }
        }];
    }
}

@end
