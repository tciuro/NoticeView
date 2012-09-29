//
//  WBStickyNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 6/4/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

@interface WBStickyNoticeView : WBNoticeView

+ (WBStickyNoticeView *)stickyNoticeInView:(UIView *)view title:(NSString *)title;

@end
