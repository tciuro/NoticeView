//
//  WBViewController.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/15/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBViewController.h"
#import "WBNoticeView.h"

@interface WBViewController ()

@end

@implementation WBViewController

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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Action Methods


- (IBAction)showSmallErrorNotice:(id)sender
{
    WBNoticeView *nm = [WBNoticeView defaultManager];
    [nm showErrorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection."];
}

- (IBAction)showLargeErrorNotice:(id)sender
{
    WBNoticeView *nm = [WBNoticeView defaultManager];
    [nm showErrorNoticeInView:self.view title:@"Network Error" message:@"Check your network connection. Twitter could also be down."];
}

- (IBAction)showSmallSuccessNotice:(id)sender
{
    WBNoticeView *nm = [WBNoticeView defaultManager];
    [nm showSuccessNoticeInView:self.view message:@"Link Saved Successfully"];
}

@end
