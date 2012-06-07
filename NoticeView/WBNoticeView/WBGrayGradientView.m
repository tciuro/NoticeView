//
//  WBGrayGradientView.m
//  GradientView
//
//  Created by Tito Ciuro on 6/3/12.
//  Copyright (c) 2012 Webbo, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "WBGrayGradientView.h"

@implementation WBGrayGradientView

- (void)drawRect:(CGRect)rect
{
    UIColor *redTop = [UIColor colorWithRed:198/255.0f green:200/255.0f blue:202/255.0f alpha:1.0];
    UIColor *redBot = [UIColor colorWithRed:225/255.0f green:228/255.0f blue:229/255.0f alpha:1.0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)redTop.CGColor,
                       (id)redBot.CGColor,
                       nil];
    gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:0.7],
                          nil];
    
    [self.layer insertSublayer:gradient atIndex:0];
    
    UIView *firstBotWhiteLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    firstBotWhiteLine.backgroundColor = [UIColor colorWithRed:236/255.0f green:238/255.0f blue:239/255.0f alpha:1.0];
    [self addSubview:firstBotWhiteLine];
    
    UIView *secondBotDarkLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height, self.frame.size.width, 1.0)];
    secondBotDarkLine.backgroundColor = [UIColor colorWithRed:113/255.0f green:114/255.0f blue:115/255.0f alpha:1.0];
    [self addSubview:secondBotDarkLine];
}

@end
