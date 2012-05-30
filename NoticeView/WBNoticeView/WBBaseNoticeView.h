//
//  WBBaseNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

@interface WBBaseNoticeView : WBNoticeView

- (id)initWithView:(UIView *)theView title:(NSString *)theTitle; // throws NSInvalidArgumentException is view is nil.

- (void)show;

+ (void)raiseIfObjectIsNil:(id)object named:(NSString *)name;

@property (nonatomic, readwrite) WBNoticeViewType noticeType;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *title; // default: @"Unknown Error"

@property (nonatomic, readwrite) CGFloat duration; // default: 0.5
@property (nonatomic, readwrite) CGFloat delay; // default: 2.0
@property (nonatomic, readwrite) CGFloat alpha; // default: 1.0
@property (nonatomic, readwrite) CGFloat originY; // default: 0.0

@end
