//
//  APLHrefString.m
//
//  Created by Tino Rachui on 24.04.2015, extended by Famara Kassama on 20.01.2018
//  Copyright (c) 2015 apploft GmbH. All rights reserved.
//

#import "APLHrefStringConverter.h"

@implementation APLUrlRange
@end

@interface APLHrefStringConverter()

+(NSMutableAttributedString*)convert:(NSString *)hrefString;

@end

@implementation APLHrefStringConverter


+(NSString*)stringWithoutMarkup:(NSString *)stringWithHref {
    NSMutableString *markupFreeString = [stringWithHref mutableCopy];
    __block NSUInteger correction = 0;
    
    NSRegularExpression *regEx = [APLHrefStringConverter regEx];
    
    [regEx enumerateMatchesInString:stringWithHref options:0 range:NSMakeRange(0, [stringWithHref length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        /* We are iterating the string from left to right. As we are deleting characters in the
         string we need to correct the location of the capture range accordingly. So we substract
         the current correction and after replacement of a substring add the length of the replaced
         substring to the correction value. Note that we are
         */
        
        NSRange captureGroup1 = [result rangeAtIndex:1];
        
        captureGroup1.location -= correction;
        [markupFreeString deleteCharactersInRange:captureGroup1];
        
        correction += captureGroup1.length;
        
        NSRange captureGroup3 = [result rangeAtIndex:3];
        
        captureGroup3.location -= correction;
        [markupFreeString deleteCharactersInRange:captureGroup3];
        
        correction += captureGroup3.length;
    }];
    
    return markupFreeString;
}

+(NSMutableAttributedString*)convert:(NSString *)hrefString {
    NSMutableAttributedString *mutableStringWithHref;
    NSArray *urlRanges = [APLHrefStringConverter urlRanges:hrefString];
    
    
    NSString *markupFreeString = [APLHrefStringConverter stringWithoutMarkup:hrefString];
    
    if (markupFreeString != nil) {
        mutableStringWithHref = [[NSMutableAttributedString alloc] initWithString:markupFreeString];
    } else {
        mutableStringWithHref = [[NSMutableAttributedString alloc] init];
    }
    
    // Decorate the touchable substrings
    [urlRanges enumerateObjectsUsingBlock:^(APLUrlRange *urlRange, NSUInteger index, BOOL *stop) {
        NSRange range = [urlRange range];
        [mutableStringWithHref addAttribute:NSLinkAttributeName value:urlRange.url range:range];
    }];
    
    
    return mutableStringWithHref;
}

+(NSString*)extractLinkTargetFromHref:(NSString*)href {
    static NSString *kStartPattern = @"<a href=\"";
    static NSString *kEndPattern = @"\"";
    
    NSRange rangeStartPattern = [href rangeOfString:kStartPattern];
    
    NSRange rangeForEndPatternSearch = NSMakeRange(rangeStartPattern.location + rangeStartPattern.length, [href length] - rangeStartPattern.length);
    
    NSRange rangeEndPattern = [href rangeOfString:kEndPattern options:NSCaseInsensitiveSearch range:rangeForEndPatternSearch];
    NSRange urlRange = NSMakeRange(rangeStartPattern.location + rangeStartPattern.length, rangeEndPattern.location - rangeStartPattern.location - rangeStartPattern.length);
    NSString *url = [href substringWithRange:urlRange];
    
    return url;
}

+(NSArray*)urlRanges:(NSString*)stringWithHref {
    NSArray *urlRanges = nil;
    
    if (urlRanges == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        
        __block NSUInteger correction = 0;
        
        NSRegularExpression *regEx = [APLHrefStringConverter regEx];
        
        [regEx enumerateMatchesInString:stringWithHref options:0 range:NSMakeRange(0, [stringWithHref length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            APLUrlRange *touchableArea = [[APLUrlRange alloc] init];
            
            NSRange captureGroup1 = [result rangeAtIndex:1];
            NSString *substringCaptureGroup1 = [stringWithHref substringWithRange:captureGroup1];
            NSString *url = [self extractLinkTargetFromHref:substringCaptureGroup1];
            
            correction += captureGroup1.length;
            
            NSRange captureGroup2 = [result rangeAtIndex:2];
            
            captureGroup2.location -= correction;
            
            NSRange captureGroup3 = [result rangeAtIndex:3];
            
            correction += captureGroup3.length;
            
            touchableArea.range = captureGroup2;
            touchableArea.url = [NSURL URLWithString:url];
            [tempArray addObject:touchableArea];
        }];
        
        urlRanges = tempArray;
    }
    
    return urlRanges;
}

+(NSRegularExpression*)regEx {
    /* Matches strings like "I have read "<a href=\"https://www.apploft.de\">Apploft</a>" blah blah"
     The first capture group contains the '<a href="...">
     the second capture group contains the 'Link Text'
     the third capture group
     A capture group is enclosed in '()' in the regex expression.
     */
    static NSString *kRegExPattern = @"(<a href=[^>]*>)([^<]*)(</a>)";
    NSRegularExpression *regEx = nil;
    
    NSError *error = nil;
    regEx = [NSRegularExpression regularExpressionWithPattern:kRegExPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing string");
    }
    
    return regEx;
}

@end


