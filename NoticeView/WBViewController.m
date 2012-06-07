//
//  WBViewController.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/15/12.
//
// Copyright (c) 2012 Webbo, L.L.C. All rights reserved.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "WBViewController.h"
#import "WBNoticeView.h"
#import "WBErrorNoticeView.h"
#import "WBSuccessNoticeView.h"
#import "WBStickyNoticeView.h"

@interface WBViewController ()

@end

@implementation WBViewController

@synthesize headerView;

- (void)viewDidLoad
{
    UIImage *bkgImage = [UIImage imageNamed:@"Default.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bkgImage];
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    [self.view setOpaque:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Action Methods

- (IBAction)showSmallErrorNotice:(id)sender
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    [notice show];
}

- (IBAction)showLargeErrorNotice:(id)sender
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."];
    [notice show];
}

- (IBAction)showSmallSuccessNotice:(id)sender
{
    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Link Saved Successfully"];
    [notice show];
}

- (IBAction)showSmallStickyNotice:(id)sender
{
    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"7 New Tweets."];
    [notice show];
}

- (IBAction)showSmallErrorNoticeBelow:(id)sender
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    
    notice.alpha = 0.8;
    notice.originY = self.headerView.frame.size.height;
    
    [notice show];
}

- (IBAction)showLargeErrorNoticeBelow:(id)sender
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."];
    
    notice.alpha = 0.8;
    notice.originY = self.headerView.frame.size.height;
    
    [notice show];
}

- (IBAction)showSmallSuccessNoticeBelow:(id)sender
{
    WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Link Saved Successfully"];
    
    notice.alpha = 0.8;
    notice.originY = self.headerView.frame.size.height;
    
    [notice show];
}

- (IBAction)showSmallStickyNoticeBelow:(id)sender
{
    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"7 New Tweets arrived somewhere from the intertubes."];
    
    notice.originY = self.headerView.frame.size.height;

    [notice show];
}

- (IBAction)showSmallErrorNoticeAndPush:(id)sender
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
    [notice show];
    
    [self.navigationController pushViewController: [[WBViewController alloc] init] animated:YES];
}

- (IBAction)showStickyNoticeAndPush:(id)sender
{
    WBStickyNoticeView *notice = [WBStickyNoticeView stickyNoticeInView:self.view title:@"7 New Tweets arrived somewhere from the intertubes."];
    [notice show];
    
    [self.navigationController pushViewController: [[WBViewController alloc] init] animated:YES];
}

@end
