//
//  WBDetailViewController.h
//  NoticeViewiPad
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Webbo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

- (IBAction)showNotice:(id)sender;

@end
