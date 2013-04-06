//
//  WBScrollViewController.m
//  NoticeView
//
//  Created by Johannes Plunien on 3/31/13.
//  Copyright (c) 2013 Tito Ciuro. All rights reserved.
//

#import "WBErrorNoticeView.h"
#import "WBScrollViewController.h"

@interface WBScrollViewController ()

@end

@implementation WBScrollViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self scrollToRow:2];
    [self performBlock:^{
        [self showNoticeView];
        [self performBlock:^{
            [self scrollToRow:1];
        } afterDelay:1.0];
    } afterDelay:0.31];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	int64_t delta = (int64_t)(1.0e9 * delay);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

- (void)scrollToRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (void)showNoticeView
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view
                                                               title:@"Network Error"
                                                             message:@"Check your network connection."];
    notice.sticky = YES;
    notice.tapToDismissEnabled = YES;
    notice.floating = self.floating;
    [notice show];
}

@end
