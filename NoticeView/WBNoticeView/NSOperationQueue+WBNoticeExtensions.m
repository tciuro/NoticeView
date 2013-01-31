//
//  NSOperationQueue+WBNoticeExtensions.m
//  NoticeView
//
//  Created by Johannes Plunien on 1/31/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import "NSOperationQueue+WBNoticeExtensions.h"

@implementation NSOperationQueue (WBNoticeExtensions)

+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView
{
    return [self addNoticeView:noticeView filterDuplicates:NO];
}

+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView
                    filterDuplicates:(BOOL)filterDuplicates
{
    if (filterDuplicates) {
        for (NSOperation *operation in [[self mainQueue] operations]) {
            if ([operation isKindOfClass:[WBNoticeOperation class]] == NO) {
                continue;
            }
            WBNoticeOperation *noticeOperation = (WBNoticeOperation *)operation;
            if ([noticeOperation.noticeView isEqual:noticeView]) {
                return nil;
            }
        }
    }
    WBNoticeOperation *operation = [[WBNoticeOperation alloc] init];
    operation.noticeView = noticeView;
    [[self mainQueue] addOperation:operation];
    return operation;
}

@end
