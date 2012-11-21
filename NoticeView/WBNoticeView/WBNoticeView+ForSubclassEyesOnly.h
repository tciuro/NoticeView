//
//  WBNoticeView+ForSubclassEyesOnly.h
//  NoticeView
//
//  Created by Blake Watters on 11/12/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WBNoticeView.h"
#import "UILabel+WBExtensions.h"

@interface WBNoticeView (ForSubclassEyesOnly)

@property(nonatomic, strong) UIView *gradientView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@property(nonatomic, assign) CGFloat hiddenYOrigin;

/**
 Tells the superclass to display the notice.
 */
- (void)displayNotice;

@end
