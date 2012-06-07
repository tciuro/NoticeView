//
//  WBNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"
#import "WBNoticeView_Private.h"
#import "WBRedGradientView.h"
#import "WBBlueGradientView.h"
#import "WBGrayGradientView.h"
#import "UILabel+WBExtensions.h"

#import <QuartzCore/QuartzCore.h>

@interface WBNoticeView ()

@property(nonatomic, strong) UIView *noticeView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

@property(nonatomic, assign) CGFloat _duration;
@property(nonatomic, assign) CGFloat _delay;
@property(nonatomic, assign) CGFloat _alpha;
@property(nonatomic, assign) CGFloat _hiddenYOrigin;
@property(nonatomic, strong) WBNoticeView *_currentNotice;

- (void)_showErrorNoticeInView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(float)duration
                         delay:(float)delay
                         alpha:(float)alpha
                       yOrigin:(CGFloat)origin;

- (void)_showSuccessNoticeInView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(float)duration
                         delay:(float)delay
                         alpha:(float)alpha
                         yOrigin:(CGFloat)origin;

- (void)_showStickyNoticeInView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(float)duration
                         delay:(float)delay
                         alpha:(float)alpha
                       yOrigin:(CGFloat)origin;

- (void)displayNoticeOfType:(WBNoticeViewType)noticeType
                   duration:(CGFloat)duration
                      delay:(CGFloat)delay
                     origin:(CGFloat)origin
              hiddenYOrigin:(CGFloat)hiddenYOrigin
                      alpha:(CGFloat)alpha;

- (void)dismissNoticeOfType:(WBNoticeViewType)noticeType
                   duration:(CGFloat)duration
                      delay:(CGFloat)delay
              hiddenYOrigin:(CGFloat)hiddenYOrigin;

- (void)cleanup;

@end

@implementation WBNoticeView

@synthesize noticeView, titleLabel, messageLabel;
@synthesize _duration;
@synthesize _delay;
@synthesize _alpha;
@synthesize _hiddenYOrigin;
@synthesize _currentNotice;

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

#pragma mark -

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

#pragma mark -

- (void)showStickyNoticeInView:(UIView *)view
                       message:(NSString *)message
                      duration:(float)duration
                         alpha:(float)alpha
                       yOrigin:(CGFloat)origin
{
    [self _showNoticeOfType:WBNoticeViewTypeSticky
                       view:view
                      title:message
                    message:nil
                   duration:duration
                      delay:0.0
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
        
        // Set default values if needed
        if (nil == title) title = @"Unknown Error";
        if (nil == message) message = @"Information not provided.";
        if (0.0 == duration) duration = 0.5;
        if ((0.0 == delay) && (WBNoticeViewTypeSticky != noticeType)) delay = 2.0;
        if (0.0 == alpha) alpha = 1.0;
        if (origin < 0.0) origin = 0.0;
        
        switch (noticeType) {
            case WBNoticeViewTypeError:
                [self _showErrorNoticeInView:view title:title message:message duration:duration delay:delay alpha:alpha yOrigin:origin];
                break;
                
            case WBNoticeViewTypeSuccess:
                [self _showSuccessNoticeInView:view title:title message:message duration:duration delay:delay alpha:alpha yOrigin:origin];
                break;
                
            case WBNoticeViewTypeSticky:
                [self _showStickyNoticeInView:view title:title message:message duration:duration delay:delay alpha:alpha yOrigin:origin];
                break;
        }
    }
}

#pragma mark -

- (void)_showErrorNoticeInView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(float)duration
                         delay:(float)delay
                         alpha:(float)alpha
                       yOrigin:(CGFloat)origin
{
    // Obtain the screen width
    CGFloat viewWidth = view.frame.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"notice_error_icon.png"];
    
    NSInteger numberOfLines = 1;
    CGFloat messageLineHeight = 30.0;
    
    // Make and add the title label
    float titleYOrigin = 10.0;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = title;
    
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
    
    // Calculate the notice view height
    float noticeViewHeight = 50.0;
    float hiddenYOrigin = 0.0;
    if (numberOfLines > 1) {
        noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
    }
    
    // Make sure we hide completely the view, including its shadow
    hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.noticeView = [[WBRedGradientView alloc]initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
    [view addSubview:self.noticeView];
    
    // Make and add the icon view
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0.8;
    [self.noticeView addSubview:iconView];
    
    // Add the title label
    [self.noticeView addSubview:self.titleLabel];
    
    // Add the message label
    [self.noticeView addSubview:self.messageLabel];
    
    // Add the drop shadow to the notice view
    CALayer *noticeLayer = self.noticeView.layer;
    noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
    noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
    noticeLayer.shadowOpacity = 0.50;
    noticeLayer.masksToBounds = NO;
    noticeLayer.shouldRasterize = YES;
    
    self._duration = duration;
    self._delay = delay;
    self._alpha = alpha;
    self._hiddenYOrigin = hiddenYOrigin;
    
    [self displayNoticeOfType:WBNoticeViewTypeError duration:duration delay:delay origin:origin hiddenYOrigin:hiddenYOrigin alpha:alpha];
}

- (void)_showSuccessNoticeInView:(UIView *)view
                           title:(NSString *)title
                         message:(NSString *)message
                        duration:(float)duration
                           delay:(float)delay
                           alpha:(float)alpha
                         yOrigin:(CGFloat)origin
{
    // Obtain the screen width
    CGFloat viewWidth = view.frame.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"notice_success_icon.png"];
    
    NSInteger numberOfLines = 1;
    CGFloat messageLineHeight = 30.0;
    
    // Make and add the title label
    float titleYOrigin = 18.0;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = title;
    
    // Calculate the notice view height
    float noticeViewHeight = 40.0;
    float hiddenYOrigin = 0.0;
    if (numberOfLines > 1) {
        noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
    }
    
    // Make sure we hide completely the view, including its shadow
    hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.noticeView = [[WBBlueGradientView alloc]initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
    [view addSubview:self.noticeView];
    
    // Make and add the icon view
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0.8;
    [self.noticeView addSubview:iconView];
    
    // Add the title label
    [self.noticeView addSubview:self.titleLabel];
    
    // Add the drop shadow to the notice view
    CALayer *noticeLayer = self.noticeView.layer;
    noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
    noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
    noticeLayer.shadowOpacity = 0.50;
    noticeLayer.masksToBounds = NO;
    noticeLayer.shouldRasterize = YES;
    
    self._duration = duration;
    self._delay = delay;
    self._alpha = alpha;
    self._hiddenYOrigin = hiddenYOrigin;
    
    [self displayNoticeOfType:WBNoticeViewTypeSuccess duration:duration delay:delay origin:origin hiddenYOrigin:hiddenYOrigin alpha:alpha];
}

- (void)_showStickyNoticeInView:(UIView *)view
                          title:(NSString *)title
                        message:(NSString *)message
                       duration:(float)duration
                          delay:(float)delay
                          alpha:(float)alpha
                        yOrigin:(CGFloat)origin
{
    // Obtain the screen width
    CGFloat viewWidth = view.frame.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"up.png"];
    
    NSInteger numberOfLines = 1;
    CGFloat messageLineHeight = 30.0;
    
    // Make and add the title label
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 8.0, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.titleLabel.shadowColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    if (frame.size.width > 260) {
        frame.size.width = 260;
        self.titleLabel.frame = frame;
    }
    
    // Calculate the notice view height
    float noticeViewHeight = 40.0;
    float hiddenYOrigin = 0.0;
    if (numberOfLines > 1) {
        noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
    }
    
    // Make sure we hide completely the view, including its shadow
    hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.noticeView = [[WBGrayGradientView alloc]initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, 32)];
    [view addSubview:self.noticeView];
    
    // Center the message in the middle of the notice
    frame = self.titleLabel.frame;
    frame.origin.x = (self.noticeView.frame.size.width - frame.size.width) / 2;
    self.titleLabel.frame = frame;
    
    // Make and add the icon view
    UIImageView *iconView = nil;
    CGFloat labelLeftPos = self.titleLabel.frame.origin.x;
    iconView = [[UIImageView alloc]initWithFrame:CGRectMake(labelLeftPos - 25, 9.0, 18, 13.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0.8;
    [self.noticeView addSubview:iconView];
    
    // Add the title label
    [self.noticeView addSubview:self.titleLabel];
    
    // Add the drop shadow to the notice view
    CALayer *noticeLayer = self.noticeView.layer;
    noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
    noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
    noticeLayer.shadowOpacity = 0.50;
    noticeLayer.masksToBounds = NO;
    noticeLayer.shouldRasterize = YES;
    
    // Add an invisible button that responds to a manual dismiss
    self._currentNotice = self;
    frame = self.noticeView.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    frame.origin.x = frame.origin.y = 0.0;
    button.frame = frame;
    [button addTarget:self._currentNotice action:@selector(dismissStickyNotice:) forControlEvents:UIControlEventTouchUpInside];
    [self.noticeView addSubview:button];
    
    self._duration = duration;
    self._delay = delay;
    self._alpha = alpha;
    self._hiddenYOrigin = hiddenYOrigin;
    
    NSLog(@"%@", self.noticeView.subviews);
    
    [self displayNoticeOfType:WBNoticeViewTypeSticky duration:duration delay:delay origin:origin hiddenYOrigin:hiddenYOrigin alpha:alpha];
}

#pragma mark -

- (void)displayNoticeOfType:(WBNoticeViewType)noticeType duration:(CGFloat)duration delay:(CGFloat)delay origin:(CGFloat)origin hiddenYOrigin:(CGFloat)hiddenYOrigin alpha:(CGFloat)alpha
{
    // Go ahead, display it
    [UIView animateWithDuration:duration animations:^ {
        CGRect newFrame = self.noticeView.frame;
        newFrame.origin.y = origin;
        self.noticeView.frame = newFrame;
        self.noticeView.alpha = alpha;
    } completion:^ (BOOL finished) {
        if (finished) {
            // if it's not sticky, hide it automatically
            if (WBNoticeViewTypeSticky != noticeType) {
                // Display for a while, then hide it again
                [self dismissNoticeOfType:noticeType duration:duration delay:delay hiddenYOrigin:hiddenYOrigin];
            }
        }
    }];
}

- (void)dismissNoticeOfType:(WBNoticeViewType)noticeType duration:(CGFloat)duration delay:(CGFloat)delay hiddenYOrigin:(CGFloat)hiddenYOrigin
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
        CGRect newFrame = self.noticeView.frame;
        newFrame.origin.y = hiddenYOrigin;
        self.noticeView.frame = newFrame;
    } completion:^ (BOOL finished) {
        if (finished) {  
            // Cleanup
            [self cleanup];
        }
    }];
}

- (IBAction)dismissStickyNotice:(id)sender
{
    // Triggered manually by the sticky notice
    [self dismissNoticeOfType:WBNoticeViewTypeSticky duration:self._duration delay:self._delay hiddenYOrigin:self._hiddenYOrigin];
}

#pragma mark -

- (void)cleanup
{
    [self.noticeView removeFromSuperview];
    self.noticeView = nil;
    self.titleLabel = nil;
    self.messageLabel = nil;
    self._currentNotice = nil;
}

- (void)dealloc
{
    [self cleanup];
}

@end
