//
//  WBBaseNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBBaseNoticeView.h"

@implementation WBBaseNoticeView

@synthesize noticeType;
@synthesize view;
@synthesize title;
@synthesize duration;
@synthesize delay;
@synthesize alpha;
@synthesize originY;

- (void)show
{
    // Subclasses need to override this method...
}

@end
