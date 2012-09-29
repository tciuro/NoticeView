//
//  WBStickyNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 6/4/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBStickyNoticeView.h"
#import "WBNoticeView_Private.h"

@implementation WBStickyNoticeView

@synthesize title;

+ (WBStickyNoticeView *)stickyNoticeInView:(UIView *)view title:(NSString *)title
{
    WBStickyNoticeView *notice = [[WBStickyNoticeView alloc]initWithView:view title:title];

    notice.sticky = YES;
    
    return notice;
}

- (void)show
{
    [self _showNoticeOfType:WBNoticeViewTypeSticky
                       view:self.view
                      title:self.title
                    message:nil
                   duration:self.duration
                      delay:0.0
                      alpha:self.alpha
                    yOrigin:self.originY];
}

@end
