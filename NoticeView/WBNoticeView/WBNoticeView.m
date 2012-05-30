//
//  WBNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"
#import "WBNoticeView_Private.h"
#import "UILabel+WBExtensions.h"

#import <QuartzCore/QuartzCore.h>

@interface WBNoticeView ()

@property(nonatomic, strong) UIView *noticeView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

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
                      alpha:0.8
                    yOrigin:0.0];
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
                      alpha:alpha
                    yOrigin:0.0];
}

- (void)showErrorNoticeInView:(UIView *)view
                        title:(NSString *)title
                      message:(NSString *)message
                     duration:(float)duration
                        delay:(float)delay
                        alpha:(float)alpha
                      yOrigin:(CGFloat)origin
{
    [self _showNoticeOfType:WBNoticeViewTypeError
                       view:view
                      title:title
                    message:message
                   duration:duration
                      delay:delay
                      alpha:alpha
                    yOrigin:origin];
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
                      alpha:0.8
                    yOrigin:0.0];
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
                      alpha:alpha
                    yOrigin:0.0];
}

- (void)showSuccessNoticeInView:(UIView *)view
                        message:(NSString *)message
                       duration:(float)duration
                          delay:(float)delay
                          alpha:(float)alpha
                        yOrigin:(CGFloat)origin
{
    [self _showNoticeOfType:WBNoticeViewTypeSuccess
                       view:view
                      title:message
                    message:nil
                   duration:duration
                      delay:delay
                      alpha:alpha
                    yOrigin:origin];
}

#pragma mark - Private Section

- (void)_showNoticeOfType:(WBNoticeViewType)noticeType
                     view:(UIView *)view
                    title:(NSString *)title
                  message:(NSString *)message
                 duration:(float)duration
                    delay:(float)delay
                    alpha:(float)alpha
                  yOrigin:(CGFloat)origin
{
    if (nil == self.noticeView) {
        // Sanity check
        if (nil == view) {
            [[NSException exceptionWithName:NSInvalidArgumentException
                                     reason:[NSString stringWithFormat:@"*** -[%@ %@]: 'view' cannot be nil.", [self class], NSStringFromSelector(_cmd)]
                                   userInfo:nil]raise];  
        }
        
        // Set default values if needed
        if (nil == title) title = @"Unknown Error";
        if (nil == message) message = @"Information not provided.";
        if (0.0 == duration) duration = 0.5;
        if (0.0 == delay) delay = 2.0;
        if (0.0 == alpha) alpha = 1.0;

        // Obtain the screen width
        CGFloat viewWidth = view.frame.size.width;
        
        // Locate the images
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
        NSString *noticeBackgroundImageName = [path stringByAppendingPathComponent:(WBNoticeViewTypeError == noticeType ? @"notice_error.png" : @"notice_success.png")];
        NSString *noticeIconImageName = [path stringByAppendingPathComponent:(WBNoticeViewTypeError == noticeType ? @"notice_error_icon.png" : @"notice_success_icon.png")];
        NSInteger numberOfLines = 1;
        CGFloat messageLineHeight = 30.0;
        
        // Make and add the title label
        float titleYOrigin = (WBNoticeViewTypeError == noticeType ? 10.0 : 18.0);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.text = title;
        
        if (WBNoticeViewTypeError == noticeType) {
            // Make the message label
            self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 10.0 + 10.0, viewWidth - 70.0, messageLineHeight)];
            self.messageLabel.font = [UIFont systemFontOfSize:13.0];
            self.messageLabel.textColor = [UIColor colorWithRed:239.0/255.0 green:167.0/255.0 blue:163.0/255.0 alpha:1.0];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.text = message;
            
            // Calculate the number of lines it'll take to display the text
            numberOfLines = [[self.messageLabel lines]count];
            self.messageLabel.numberOfLines = numberOfLines;
            CGRect r = self.messageLabel.frame;
            r.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;//(1 == numberOfLines) ? self.titleLabel.frame.origin.y : self.titleLabel.frame.origin.y - 11.0;
            
            // This step is needed to avoid having the UILabel center the text in the middle
            [self.messageLabel sizeToFit];
            
            // Now we can determine the height of one line of text
            messageLineHeight = self.messageLabel.frame.size.height;
            r.size.height = self.messageLabel.frame.size.height * numberOfLines;
            r.size.width = viewWidth - 70.0;
            self.messageLabel.frame = r;
        }
        
        // Calculate the notice view height
        float noticeViewHeight = (WBNoticeViewTypeError == noticeType ? 50.0 : 40.0);
        float hiddenYOrigin = 0.0;
        if (numberOfLines > 1) {
            noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
        }
        
        // Make sure we hide completely the view, including its shadow
        hiddenYOrigin = -noticeViewHeight - 20.0;
        
        // Make and add the notice view
        self.noticeView = [[UIView alloc]initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
        [view addSubview:self.noticeView];
        
        // Make and add the image view
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, viewWidth, noticeViewHeight + 10.0)];
        [self.imageView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        self.imageView.image = [UIImage imageWithContentsOfFile:noticeBackgroundImageName];
        [self.noticeView addSubview:self.imageView];
        
        // Make and add the icon view
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 30.0, 30.0)];
        iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconView.alpha = 0.8;
        [self.noticeView addSubview:iconView];
        
        // Add the title label
        [self.noticeView addSubview:self.titleLabel];
        
        // Add the message label if it's an error notice
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
            newFrame.origin.y = origin;
            self.noticeView.frame = newFrame;
            self.noticeView.alpha = alpha;
        } completion:^ (BOOL finished) {
            if (finished) {
                // Display for a while, then hide it again
                [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
                    CGRect newFrame = self.noticeView.frame;
                    newFrame.origin.y = hiddenYOrigin;
                    self.noticeView.frame = newFrame;
                } completion:^ (BOOL finished) {
                    if (finished) {                        
                        // Cleanup
                        [self.noticeView removeFromSuperview];
                        self.noticeView = nil;
                        self.imageView = nil;
                        self.titleLabel = nil;
                        self.messageLabel = nil;
                    }
                }];
            }
        }];
    }
}

@end
