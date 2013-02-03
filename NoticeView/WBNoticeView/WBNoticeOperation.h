//
//  WBNoticeOperation.h
//  NoticeView
//
//  Created by Johannes Plunien on 1/30/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBNoticeView.h"

@interface WBNoticeOperation : NSOperation

@property (nonatomic, assign) BOOL dismissedInteractively;
@property (nonatomic, strong) WBNoticeView *noticeView;

@end
