//
//  WBSuccessNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBSuccessNoticeView.h"
#import "WBNoticeView_Private.h"

@implementation WBSuccessNoticeView

@synthesize title;

+ (WBSuccessNoticeView *)successNoticeInView:(UIView *)view title:(NSString *)title
{
    WBSuccessNoticeView *notice = [[WBSuccessNoticeView alloc]initWithView:view title:title];

    notice.sticky = NO;

    return notice;
}

- (void)show
{
    [self _showNoticeOfType:WBNoticeViewTypeSuccess
                       view:self.view
                      title:self.title
                    message:nil
                   duration:self.duration
                      delay:self.delay
                      alpha:self.alpha
                    yOrigin:self.originY];
}

@end
