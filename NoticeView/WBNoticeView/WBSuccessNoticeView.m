//
//  WBSuccessNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBSuccessNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"
#import "WBBlueGradientView.h"

@implementation WBSuccessNoticeView

+ (WBSuccessNoticeView *)successNoticeInView:(UIView *)view title:(NSString *)title
{
    WBSuccessNoticeView *notice = [[WBSuccessNoticeView alloc]initWithView:view title:title];

    notice.sticky = NO;

    return notice;
}

- (void)show
{
    // Obtain the screen width
    CGFloat viewWidth = self.view.bounds.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"notice_success_icon.png"];
    
    NSInteger numberOfLines = 1;
    CGFloat messageLineHeight = 30.0;
    
    // Make and add the title label
    float titleYOrigin = 18.0;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = self.title;
    
    // Calculate the notice view height
    float noticeViewHeight = 40.0;
    float hiddenYOrigin = 0.0;
    if (numberOfLines > 1) {
        noticeViewHeight += (numberOfLines - 1) * messageLineHeight;
    }
    
    // Make sure we hide completely the view, including its shadow
    hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.gradientView = [[WBBlueGradientView alloc] initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
    [self.view addSubview:self.gradientView];
    
    // Make and add the icon view
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
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
