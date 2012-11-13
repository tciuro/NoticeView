//
//  WBNoticeView.h
//  NoticeView
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `WBNoticeView` objects provides a lightweight, non-intrusive means for displaying information to the user. The `WBNoticeView` class is an abstract class that encapsulates the interface common to all notice objects.
 */
@interface WBNoticeView : NSObject

///----------------------------
/// @name Initializing a Notice
///----------------------------

/**
 Initializes the receiver with the given origin view and title.
 
 This is the designated initializer.
 
 @param view The view from which the notice will originate when displayed.
 @param title The title for the notice.
 @return The receiver, initialized with the given view and title.
 */
- (id)initWithView:(UIView *)view title:(NSString *)title;

///---------------------------------
/// @name Configuring Notice Display
///---------------------------------

/**
 The view from which the notice will be displayed.
 */
@property (nonatomic, weak) UIView *view;

/**
 The title text for the notice.
 
 **Default**: `"Unknown Error"`
 */
@property (nonatomic, copy) NSString *title;

/**
 The message for the notice. Not supported by all notice types.
 */
@property (nonatomic, copy) NSString *message;

/**
 The animation duration for the notice.
 
 **Default**: `0.5`
 */
@property (nonatomic, readwrite) NSTimeInterval duration;

/**
 The time interval in seconds that the notice will be displayed before being automatically dismissed.
 
 **Default**: `2.0`
 */
@property (nonatomic, readwrite) NSTimeInterval delay;

/**
 The amount of transparency applied to the notice. Values can range between `0.0` (transparent) and `1.0` (opaque). Values outside this range are clamped to `0.0` or `1.0`.
 
 **Default**: `1.0`
 */
@property (nonatomic, readwrite) CGFloat alpha;

/**
 The number of points that the notice will be offset vertically from the origin view when being displayed.
 
 **Default**: `0.0`
 */
@property (nonatomic, readwrite) CGFloat originY;

/**
 A Boolean value that determines if the notice supports tap to dismiss. 
 
 **Default**: `YES`
 */
@property (nonatomic, assign, getter = isTapToDismissEnabled) BOOL tapToDismissEnabled;

/**
 A Boolean value that determines if the notice will be automatically dismissed after the time interval specified by the `delay` property expires.
 
 **Default**: `NO`
 */
@property (nonatomic, readwrite, getter = isSticky) BOOL sticky;

///----------------------------------------
/// @name Showing and Dismissing the Notice
///----------------------------------------

/**
 Shows the notice.
 
 @warning The `WBNoticeView` class is abstract. Concrete subclasses must provide an implementation of the `show` method or else an exception will be raised.
 */
- (void)show;

/**
 Dismisses the notice.
 */
- (void)dismissNotice;

///----------------------------------
/// @name Setting the Dismissal Block
///----------------------------------

/**
 Sets a block to be executed when the notice is dismissed.
 
 The block accepts a single Boolean value that indicates if the notice was dismissed interactively by the user or was dismissed due to expiration of the display interval.
 
 @param block The block to be executed when the notice is dismissed.
 */
- (void)setDismissalBlock:(void (^)(BOOL dismissedInteractively))block;

@end
