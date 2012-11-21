//
//  WBSuccessNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBNoticeView.h"

/**
 The `WBSuccessNoticeView` class is a `WBNoticeView` subclass suitable for displaying an informational success message to a user. The notice is presented on a blue gradient background with a checkmark icon on the left hand side of the notice. It supports the display of a title only.
 */
@interface WBSuccessNoticeView : WBNoticeView

///-------------------------------
/// @name Creating a Success Notice
///-------------------------------

/**
 Creates and returns a success notice in the given view with the specified title.
 
 @param view The view to display the notice in.
 @param title The title of the notice.
 @return The newly created success notice object.
 */
+ (WBSuccessNoticeView *)successNoticeInView:(UIView *)view title:(NSString *)title;

@end
