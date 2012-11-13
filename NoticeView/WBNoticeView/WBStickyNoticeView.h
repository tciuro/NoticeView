//
//  WBStickyNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 6/4/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

/**
 The `WBStickyNoticeView` class is a `WBNoticeView` subclass suitable for displaying a sticky informational message to a user. The notice is presented on a gray gradient background with a vertical error icon on the left hand side of the notice. It supports the display of a title only.
 */
@interface WBStickyNoticeView : WBNoticeView

///-------------------------------
/// @name Creating a Sticky Notice
///-------------------------------

/**
 Creates and returns a sticky notice in the given view with the specified title.
 
 @param view The view to display the notice in.
 @param title The title of the notice.
 @return The newly created sticky notice object.
 */
+ (WBStickyNoticeView *)stickyNoticeInView:(UIView *)view title:(NSString *)title;

@end
