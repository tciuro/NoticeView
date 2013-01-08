//
//  WBErrorNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBErrorNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"
#import "WBRedGradientView.h"

@implementation WBErrorNoticeView

+ (WBErrorNoticeView *)errorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message
{
    WBErrorNoticeView *notice = [[WBErrorNoticeView alloc]initWithView:view title:title];
    
    notice.message = message;
    notice.sticky = NO;
    
    return notice;
}

- (void)show
{
    // Obtain the screen width
    CGFloat viewWidth = self.view.bounds.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"notice_error_icon.png"];
    
    // Make and add the title label
    float titleYOrigin = 10.0;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = self.title;
    
    // Make the message label
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 20.0 + 10.0, viewWidth - 70.0, 12.0)];
    self.messageLabel.font = [UIFont systemFontOfSize:13.0];
    self.messageLabel.textColor = [UIColor colorWithRed:239.0/255.0 green:167.0/255.0 blue:163.0/255.0 alpha:1.0];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.text = self.message;
    
    // Calculate the number of lines it'll take to display the text
    NSInteger numberOfLines = [[self.messageLabel lines]count];
    self.messageLabel.numberOfLines = numberOfLines;
    [self.messageLabel sizeToFit];
    CGFloat messageLabelHeight = self.messageLabel.frame.size.height;
    
    CGRect r = self.messageLabel.frame;
    r.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
    
    float noticeViewHeight = 0.0;
    double currOsVersion = [[[UIDevice currentDevice]systemVersion]doubleValue];
    if (currOsVersion >= 6.0f) {
        noticeViewHeight = messageLabelHeight;
    } else {
        // Now we can determine the height of one line of text
        r.size.height = self.messageLabel.frame.size.height * numberOfLines;
        r.size.width = viewWidth - 70.0;
        self.messageLabel.frame = r;
        
        // Calculate the notice view height
        noticeViewHeight = 10.0;
        if (numberOfLines > 1) {
            noticeViewHeight += ((numberOfLines - 1) * messageLabelHeight);
        }
    }
    
    // Add some bottom margin for the notice view
    noticeViewHeight += 30.0;
    
    // Make sure we hide completely the view, including its shadow
    float hiddenYOrigin = -noticeViewHeight - 20.0;
    
    // Make and add the notice view
    self.gradientView = [[WBRedGradientView alloc] initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
    [self.view addSubview:self.gradientView];
    
    // Make and add the icon view
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0.8;
    [self.gradientView addSubview:iconView];
    
    // Add the title label
    [self.gradientView addSubview:self.titleLabel];
    
    // Add the message label
    [self.gradientView addSubview:self.messageLabel];
    
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
