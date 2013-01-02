//
//  WBStickyNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 6/4/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBStickyNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"
#import "WBGrayGradientView.h"

@implementation WBStickyNoticeView

+ (WBStickyNoticeView *)stickyNoticeInView:(UIView *)view title:(NSString *)title
{
    WBStickyNoticeView *notice = [[WBStickyNoticeView alloc]initWithView:view title:title];

    notice.sticky = YES;
    
    return notice;
}

- (void)show
{
    // Obtain the screen width
    CGFloat viewWidth = self.view.bounds.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"up.png"];
    
    NSInteger numberOfLines = 1;
    CGFloat messageLineHeight = 30.0;
    
    // Make and add the title label
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 8.0, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    self.titleLabel.shadowColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = self.title;
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    if (frame.size.width > 260) {
        frame.size.width = 260;
        self.titleLabel.frame = frame;
    }
    
    // Calculate the notice view height
    float noticeViewHeight = 40.0;
    float hiddenYOrigin = 0.0;
    if (numberOfLines > 1) {
        noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
    }
    
    // Make sure we hide completely the view, including its shadow
    hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.gradientView = [[WBGrayGradientView alloc] initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, 32)];
    [self.view addSubview:self.gradientView];
    
    // Center the message in the middle of the notice
    frame = self.titleLabel.frame;
    frame.origin.x = (self.gradientView.frame.size.width - frame.size.width) / 2;
    self.titleLabel.frame = frame;
    
    // Make and add the icon view
    UIImageView *iconView = nil;
    CGFloat labelLeftPos = self.titleLabel.frame.origin.x;
    iconView = [[UIImageView alloc]initWithFrame:CGRectMake(labelLeftPos - 25, 9.0, 18, 13.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0.8;
    [self.gradientView addSubview:iconView];
    
    // Add the title label
    [self.gradientView addSubview:self.titleLabel];
    
    // Add the drop shadow to the notice view
    CALayer *noticeLayer = self.gradientView.layer;
    noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
    noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
    noticeLayer.shadowOpacity = 0.50;
    noticeLayer.masksToBounds = NO;
    noticeLayer.shouldRasterize = YES;
    
    self.hiddenYOrigin = hiddenYOrigin;
    
    [self displayNotice];
}

@end
