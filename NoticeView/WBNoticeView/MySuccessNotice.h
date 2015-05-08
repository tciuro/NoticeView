//
//  MySuccessNotice.h

//
//  Created by Abuzar Amin on 25/02/2015.

#import "WBNoticeView.h"

@interface MySuccessNotice : WBNoticeView

+ (MySuccessNotice*)successNoticeInView:(UIView *)view title:(NSString *)title message:(NSString *)message languageDirection: (LanguageDirection) direction;
@end
