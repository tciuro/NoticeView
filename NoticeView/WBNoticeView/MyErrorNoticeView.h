//
//  MyErrorNoticeView.h
//
//
//  Created by Abuzar Amin on 12/03/2015.


#import <UIKit/UIKit.h>
#import "WBNoticeView.h"


@interface MyErrorNoticeView : WBNoticeView

+ (MyErrorNoticeView *)errorNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message languageDirection: (LanguageDirection) direction;

@end
