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

@property(nonatomic, strong) UIButton *dismissButton;
@property(nonatomic, strong) UIView *gradientView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

@property(nonatomic, assign, getter = isObserving) BOOL observing;
@property(nonatomic, assign) CGFloat hiddenYOrigin;
@property(nonatomic, strong) WBNoticeView *currentNotice;
@property(nonatomic, copy) void (^dismissalBlock)(BOOL dismissedInteractively);
@property(nonatomic, copy) void (^dismissalBlockWithOptionalDismiss)(BOOL dismissedInteractively, BOOL *dismissAfterBlock);
@property(nonatomic, strong) NSTimer *displayTimer;

- (void)dismissNoticeWithDuration:(NSTimeInterval)duration
                            delay:(NSTimeInterval)delay
                    hiddenYOrigin:(CGFloat)hiddenYOrigin;
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
@synthesize dismissalBlockWithOptionalDismiss = _dismissalBlockWithOptionalDismiss;
@synthesize floating = _floating;

- (id)initWithView:(UIView *)view title:(NSString *)title
{
    NSParameterAssert(view);
    self = [super init];
    if (self) {
        _view = view;
        _title = title ?: @"Unknown Error";
        _message = @"Information not provided";
        _duration = 0.5;
        _alpha = 1.0;
        _delay = 2.0;
        _tapToDismissEnabled = YES;
        _slidingMode = WBNoticeViewSlidingModeDown;
        _floating = NO;
        _contentInset = UIEdgeInsetsMake(0,0,0,0); // No insets as default
    }
    return self;
}

- (void)show
{
    // Subclasses need to override this method...
    [self doesNotRecognizeSelector:_cmd];
}

- (BOOL)isEqual:(WBNoticeView *)object
{
    return [self.title isEqual:object.title] && [self.message isEqual:object.message];
}

#pragma mark -

- (void)displayNotice
{
    self.gradientView.userInteractionEnabled = YES;

    // Add tap to dismiss capabilities if desired
    if (self.isTapToDismissEnabled) {
        // Add an invisible button that responds to a manual dismiss
        self.currentNotice = self;
        self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dismissButton.frame = self.gradientView.bounds;
        [self.dismissButton addTarget:self action:@selector(dismissNoticeInteractively) forControlEvents:UIControlEventTouchUpInside];
        [self.gradientView addSubview:self.dismissButton];
    }

    [self updateAccessibilityLabels];

    //set default originY if WBNoticeViewSlidingModeUp
    if ((self.slidingMode == WBNoticeViewSlidingModeUp) && (self.originY == 0)) {
        self.originY = self.view.bounds.size.height - self.gradientView.bounds.size.height;
        self.gradientView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    } else
    {
        self.gradientView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    }
    
    // Go ahead, display it
    [UIView animateWithDuration:self.duration animations:^ {
        CGRect newFrame = self.gradientView.frame;
        //add scroll offset if scrolled
        double scrollOffsetY = 0.0f;
        if ([self.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self.view;
            scrollOffsetY = scrollView.contentOffset.y;
        }
        newFrame.origin.y = self.originY + scrollOffsetY;
        self.gradientView.frame = newFrame;
        self.gradientView.alpha = self.alpha;
        [self registerObserver];
    } completion:^ (BOOL finished) {
        // if it's not sticky, hide it automatically
        if ((self.tapToDismissEnabled && !self.isSticky) || (!self.tapToDismissEnabled && self.isSticky)) {
            // Schedule a timer
            self.displayTimer = [NSTimer scheduledTimerWithTimeInterval:self.delay target:self selector:@selector(dismissAfterTimerExpiration) userInfo:nil repeats:NO];
        } else if (!self.isSticky) {
            // Display for a while, then hide it again
            [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin];
        }
    }];
}

- (void)dismissNoticeWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay hiddenYOrigin:(CGFloat)hiddenYOrigin
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
        [self unregisterObserver];
        CGRect newFrame = self.gradientView.frame;
        if (self.slidingMode == WBNoticeViewSlidingModeUp)  {
            newFrame.origin.y = self.gradientView.frame.origin.y + self.gradientView.bounds.size.height;
        } else
        {
            newFrame.origin.y = hiddenYOrigin;
        }
        self.gradientView.frame = newFrame;
    } completion:^ (BOOL finished) {
        
        if (self.dismissalBlock) {
            self.dismissalBlock(NO);
        }
        
        if (self.dismissalBlockWithOptionalDismiss) {
            BOOL dismissAfterBlock = YES;
            self.dismissalBlockWithOptionalDismiss(NO, &dismissAfterBlock);
        }
        
        // Cleanup
        [self cleanup];
    }];
}

- (void)dismissNotice
{
    [self.displayTimer invalidate];
    [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin];
}

- (void)dismissNoticeInteractively
{
    // TODO: Should this timer invalidate here or when the dismissalBlock is set to nil further down?
    [self.displayTimer invalidate];
    
    if (self.dismissalBlock) {
        self.dismissalBlock(YES);
    }
 
    // By default we want to dismiss after the block has been called
    BOOL dismissAfterBlock = YES;
    if (self.dismissalBlockWithOptionalDismiss) {
        self.dismissalBlockWithOptionalDismiss(YES, &dismissAfterBlock);
    }
    
    // Lets check if the block wanted us to dismiss
    if (dismissAfterBlock) {
        // Clear the reference to the dismissal block so that the animation does invoke the block a second time
        self.dismissalBlock = nil;
        self.dismissalBlockWithOptionalDismiss = nil;
        
        [self dismissNoticeWithDuration:self.duration delay:0 hiddenYOrigin:self.hiddenYOrigin];
    }
}

- (void)dismissAfterTimerExpiration
{
    [self dismissNoticeWithDuration:self.duration delay:0.0 hiddenYOrigin:self.hiddenYOrigin];
}

- (void)updateAccessibilityLabels
{
    // Setup accessiblity on the gradient view
    NSString *accessibilityLabel = ([self.messageLabel.text length]) ? [NSString stringWithFormat:@"%@, %@", [self.titleLabel text], [self.messageLabel text]]
    : [self.titleLabel text];
    self.gradientView.accessibilityTraits = (self.isTapToDismissEnabled) ? UIAccessibilityTraitButton : UIAccessibilityTraitStaticText;
    self.gradientView.accessibilityLabel = accessibilityLabel;
    self.dismissButton.accessibilityLabel = accessibilityLabel;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (self.floating && object && [object isKindOfClass:[UIScrollView class]] && [keyPath isEqualToString:@"contentOffset"]) {
        CGRect newFrame = self.gradientView.frame;
        newFrame.origin.y = ((UIScrollView *)object).contentOffset.y;
        self.hiddenYOrigin += (newFrame.origin.y - self.gradientView.frame.origin.y);
        self.gradientView.frame = newFrame;
        [self.view bringSubviewToFront:self.gradientView];
    }
    if (self.floating && self.view.window == nil) {
        [self unregisterObserver];
    }
}

- (void)registerObserver
{
    if (self.floating && [self.view isKindOfClass:[UIScrollView class]]) {
        [self.view addObserver:self
                    forKeyPath:@"contentOffset"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
        self.observing = YES;
    }
}

- (void)unregisterObserver
{
    if (self.floating && self.isObserving && [self.view isKindOfClass:[UIScrollView class]]) {
        [self.view removeObserver:self forKeyPath:@"contentOffset"];
        self.observing = NO;
    }
}

#pragma mark -

- (void)cleanup
{
    [self.displayTimer invalidate];
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
