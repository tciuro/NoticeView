//
//  WBMasterViewController.h
//  NoticeViewiPad
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Webbo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBDetailViewController;

@interface WBMasterViewController : UITableViewController

@property (strong, nonatomic) WBDetailViewController *detailViewController;

@end
