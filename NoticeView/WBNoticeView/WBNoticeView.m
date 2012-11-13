//
//  WBNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"

@interface WBNoticeView ()

@property(nonatomic, strong) UIView *gradientView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

@property(nonatomic, assign) CGFloat hiddenYOrigin;
@property(nonatomic, strong) WBNoticeView *currentNotice;
@property(nonatomic, copy) void (^dismissalBlock)(BOOL dismissedInteractively);

- (void)dismissNoticeWithDuration:(NSTimeInterval)duration
                            delay:(NSTimeInterval)delay
                    hiddenYOrigin:(CGFloat)hiddenYOrigin
                    interactively:(BOOL)interactively;
- (void)cleanup;

@end

@implementation WBNoticeView

@synthesize gradientView = _gradientView;
@synthesize titleLabel = _titleLabel;
@synthesize messageLabel = _messageLabel;
@synthesize hiddenYOrigin = _hiddenYOrigin;
@synthesize currentNotice = _currentNotice;
@synthesize view = _view;
@synthesize title = _title;
@synthesize duration = _duration;
@synthesize delay = _delay;
@synthesize alpha = _alpha;
@synthesize originY = _originY;
@synthesize sticky = _sticky;
@synthesize dismissalBlock = _dismissalBlock;

- (id)initWithView:(UIView *)view title:(NSString *)title
{
    NSParameterAssert(view);
    self = [super init];
    if (self) {
        self.view = view;
        self.title = title ?: @"Unknown Error";
        self.message = @"Information not provided";
        self.duration = 0.5;
        self.alpha = 1.0;
        self.delay = 2.0;
    }
    return self;
}

- (NSTimeInterval)delay
{
    return [self isSticky] ? 0.0 : _delay;
}

- (void)show
{
    // Subclasses need to override this method...
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -

- (void)displayNotice
{
    // Setup accessiblity on the gradient view
    NSString *accessibilityLabel = ([self.messageLabel.text length]) ? [NSString stringWithFormat:@"%@, %@", [self.titleLabel text], [self.messageLabel text]]
                                                       : [self.titleLabel text];
    self.gradientView.accessibilityTraits = (self.isSticky || self.dismissalBlock) ? UIAccessibilityTraitButton : UIAccessibilityTraitStaticText;
    self.gradientView.accessibilityLabel = accessibilityLabel;
    
    // If the notice is sticky, add tap capabilities
    if (self.isSticky) {
        // Add an invisible button that responds to a manual dismiss
        self.currentNotice = self;
        CGRect frame = self.gradientView.frame;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.accessibilityLabel = accessibilityLabel;
        frame.origin.x = frame.origin.y = 0.0;
        button.frame = frame;
        [button addTarget:self.currentNotice action:@selector(dismissNoticeInteractively) forControlEvents:UIControlEventTouchUpInside];
        [self.gradientView addSubview:button];
    }
    
    // Go ahead, display it
    [UIView animateWithDuration:self.duration animations:^ {
        CGRect newFrame = self.gradientView.frame;
        newFrame.origin.y = self.originY;
        self.gradientView.frame = newFrame;
        self.gradientView.alpha = self.alpha;
    } completion:^ (BOOL finished) {
        if (finished) {
            // if it's not sticky, hide it automatically
            if (NO == self.isSticky) {
                // Display for a while, then hide it again
                [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin interactively:NO];
            }
        }
    }];
}

- (void)dismissNoticeWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay hiddenYOrigin:(CGFloat)hiddenYOrigin interactively:(BOOL)interactively
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
        CGRect newFrame = self.gradientView.frame;
        newFrame.origin.y = hiddenYOrigin;
        self.gradientView.frame = newFrame;
    } completion:^ (BOOL finished) {
        if (finished) {  
            if (self.dismissalBlock) {
                self.dismissalBlock(interactively);
            }
            // Cleanup
            [self cleanup];
        }
    }];
}

- (void)dismissNotice
{
    if (self.isSticky) {
        [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin interactively:NO];
    }
}

- (void)dismissNoticeInteractively
{
    [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin interactively:YES];
}

#pragma mark -

- (void)cleanup
{
    [self.gradientView removeFromSuperview];
    self.gradientView = nil;
    self.titleLabel = nil;
    self.messageLabel = nil;
    self.currentNotice = nil;
}

- (void)dealloc
{
    [self cleanup];
}

@end
