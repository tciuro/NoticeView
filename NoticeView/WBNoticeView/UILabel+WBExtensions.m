//
//  UILabel+WBExtensions.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/15/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "UILabel+WBExtensions.h"

@implementation UILabel (WBExtensions)

- (NSArray *)lines
{
    if (! [self.text length]) return nil;
    
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:10];
    NSCharacterSet *wordSeparators = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *currentLine = self.text;
    int textLength = [self.text length];
    
    NSRange rCurrentLine = NSMakeRange(0, textLength);
    NSRange rWhitespace = NSMakeRange(0, 0);
    NSRange rRemainingText = NSMakeRange(0, textLength);
    BOOL done = NO;
    
    while (NO == done) {
        // determine the next whitespace word separator position
        rWhitespace.location = rWhitespace.location + rWhitespace.length;
        rWhitespace.length = textLength - rWhitespace.location;
        rWhitespace = [self.text rangeOfCharacterFromSet:wordSeparators options:NSCaseInsensitiveSearch range:rWhitespace];
        
        if (NSNotFound == rWhitespace.location) {
            rWhitespace.location = textLength;
            done = YES;
        }
        
        NSRange rTest = NSMakeRange(rRemainingText.location, rWhitespace.location - rRemainingText.location);
        NSString *textTest = [self.text substringWithRange:rTest];
        CGSize sizeTest = [textTest sizeWithFont:self.font forWidth:1024.0 lineBreakMode:UILineBreakModeWordWrap];
        
        if (sizeTest.width > self.bounds.size.width) {
            [lines addObject:[currentLine stringByTrimmingCharactersInSet:wordSeparators]];
            rRemainingText.location = rCurrentLine.location + rCurrentLine.length;
            rRemainingText.length = textLength-rRemainingText.location;
            continue;
        }
        
        rCurrentLine = rTest;
        currentLine = textTest;
    }
    
    [lines addObject:[currentLine stringByTrimmingCharactersInSet:wordSeparators]];
    
    return lines;
}

@end