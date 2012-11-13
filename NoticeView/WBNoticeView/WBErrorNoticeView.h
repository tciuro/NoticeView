//
//  WBErrorNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

/**
 The `WBErrorNoticeView` class is a `WBNoticeView` subclass suitable for displaying an error to a user. The notice is presented on a red gradient background with an error icon on the left hand side of the notice. It supports the display of a title and a message.
 */
@interface WBErrorNoticeView : WBNoticeView

///-------------------------------
/// @name Creating an Error Notice
///-------------------------------

/**
 Creates and returns an error notice in the given view with the specified title and message.
 
 @param view The view to display the notice in.
 @param title The title of the notice.
 @param message The message of the notice.
 @return The newly created error notice object.
 */
+ (WBErrorNoticeView *)errorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message;

@end
