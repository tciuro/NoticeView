//
//  NSOperationQueue+WBNoticeExtensions.m
//  NoticeView
//
//  Created by Johannes Plunien on 1/31/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import "NSOperationQueue+WBNoticeExtensions.h"

@implementation NSOperationQueue (WBNoticeExtensions)

static NSOperationQueue *_noticeQueue = nil;

+ (NSOperationQueue *)noticeQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_noticeQueue == nil) {
            _noticeQueue = [[NSOperationQueue alloc] init];
            _noticeQueue.maxConcurrentOperationCount = 1;
        }
    });
    return _noticeQueue;
}

#pragma mark - Public methods

+ (void)cancelAllNoticeViews
{
    [[self noticeQueue] cancelAllOperations];
}

+ (void)cancelAndDismissAllNoticeViews
{
    for (WBNoticeOperation *operation in [[self noticeQueue] operations]) {
        [operation.noticeView dismissNotice];
        [operation cancel];
    }
}

+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView
{
    return [self addNoticeView:noticeView filterDuplicates:NO];
}

+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView
                    filterDuplicates:(BOOL)filterDuplicates
{
    if (filterDuplicates) {
        for (NSOperation *operation in [[self noticeQueue] operations]) {
            WBNoticeOperation *noticeOperation = (WBNoticeOperation *)operation;
            if ([noticeOperation.noticeView isEqual:noticeView]) {
                return nil;
            }
        }
    }
    WBNoticeOperation *operation = [[WBNoticeOperation alloc] init];
    operation.noticeView = noticeView;
    [[self noticeQueue] addOperation:operation];
    return operation;
}

@end
