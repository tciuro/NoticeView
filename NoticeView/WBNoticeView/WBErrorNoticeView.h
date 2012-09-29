//
//  WBErrorNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

@interface WBErrorNoticeView : WBNoticeView

+ (WBErrorNoticeView *)errorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message;

@property (nonatomic, strong) NSString *message; // default: @"Information not provided."

@end
