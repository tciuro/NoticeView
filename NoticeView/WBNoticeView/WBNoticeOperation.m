//
//  WBNoticeOperation.m
//  NoticeView
//
//  Created by Johannes Plunien on 1/30/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import "WBNoticeOperation.h"

@interface WBNoticeOperation ()

@property (nonatomic, assign, getter = isExecuting) BOOL executing;
@property (nonatomic, assign, getter = isFinished) BOOL finished;

@end

@implementation WBNoticeOperation

- (void)start
{
    self.executing = YES;
    self.finished = NO;
    __weak __typeof(&*self)weakSelf = self;
    self.noticeView.dismissalBlock = ^(BOOL dismissedInteractively) {
        [weakSelf willChangeValueForKey:@"isFinished"];
        [weakSelf willChangeValueForKey:@"isExecuting"];
        weakSelf.executing = NO;
        weakSelf.finished = YES;
        weakSelf.dismissedInteractively = dismissedInteractively;
        [weakSelf didChangeValueForKey:@"isExecuting"];
        [weakSelf didChangeValueForKey:@"isFinished"];
    };
    [self.noticeView show];
}

@end
