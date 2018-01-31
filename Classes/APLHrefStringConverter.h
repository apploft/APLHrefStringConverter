//
//  APLHrefStringConverter.h
//
//  Created by Tino Rachui on 24.04.2015, extended by Famara Kassama on 20.01.2018
//  Copyright (c) 2015 apploft GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 A tuple of range and url
 */
@interface APLUrlRange : NSObject
@property (nonatomic) NSRange range;
@property (nonatomic) NSURL *url;
@end
 
 /*
 A class accepting strings with embedded 'href' links.
 E.g. "A text containing a <a href=\"http:\\\\www.apploft.de\">Apploft</a>"
 The class parses the string and produces an attributted string with the markup
 being stripped. Furthermore the class provides an array of url range objects.
 They can for instance be used in order to initialize an APLURLTextView instance.
 */
@interface APLHrefStringConverter : NSObject

+(NSMutableAttributedString*)convert:(NSString *)hrefString;

@end


