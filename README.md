APLHrefStringConverter
=========
A simple converter class which takes a string containing 'hrefs' as input and returns an attributed String with links at corresponding places.

## Installation
Install via cocoapods by adding this to your Podfile:

	pod 'APLHrefStringConverter', '0.0.4'

## Usage
Import header file:

	#import "APLHrefStringConverter.h"
	
Use APLHrefStringConverter like this:
	
	...APLHrefStringConverter
	self.textView.delegate = self;
	...
	
	NSString *testString = @"A string with <a href=\"http://www.apploft.de\">a link</href>";
   	NSMutableAttributedString *mutableStringWithHref = [APLHrefStringConverter convert:testString];
   
	self.textView.attributedString = mutableStringWithHref;
	self.textView.dataDetectorTypes = UIDataDetectorTypeLink;

	...
	
	// Implement the delegate method extending the UITextViewDelegate method
	// in order to be informed about URLs being touched by the user
	-(void)textView:(APLUrlTextView *)label didSelectLinkWithURL:(NSURL *)url {
	  ...
    }
    		