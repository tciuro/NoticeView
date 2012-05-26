//
//  WBBaseNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

@interface WBBaseNoticeView : WBNoticeView

- (void)show;

@property (nonatomic, readwrite) WBNoticeViewType noticeType;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, readwrite) CGFloat duration;
@property (nonatomic, readwrite) CGFloat delay;
@property (nonatomic, readwrite) CGFloat alpha;
@property (nonatomic, readwrite) CGFloat originY;

@end
