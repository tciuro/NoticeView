//
//  NSOperationQueue+WBNoticeExtensions.h
//  NoticeView
//
//  Created by Johannes Plunien on 1/31/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBNoticeView.h"
#import "WBNoticeOperation.h"

@interface NSOperationQueue (WBNoticeExtensions)

+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView;
+ (WBNoticeOperation *)addNoticeView:(WBNoticeView *)noticeView
                    filterDuplicates:(BOOL)filterDuplicates;
+ (void)cancelAllNoticeViews;
+ (void)cancelAndDismissAllNoticeViews;

@end
