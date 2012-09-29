//
//  WBNoticeView_Private.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#ifndef NoticeView_WBNoticeView_Private_h
#define NoticeView_WBNoticeView_Private_h

#import "WBNoticeView.h"

@interface WBNoticeView (Private)

+ (void)_raiseIfObjectIsNil:(id)object named:(NSString *)name;

- (void)_showNoticeOfType:(WBNoticeViewType)noticeType
                     view:(UIView *)view
                    title:(NSString *)title
                  message:(NSString *)message
                 duration:(float)duration
                    delay:(float)delay
                    alpha:(float)alpha
                  yOrigin:(CGFloat)origin;

@end

#endif
