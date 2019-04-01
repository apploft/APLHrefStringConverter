HTMLStringConverter
=========
A simple converter class that takes a string containing html element text, such as 'href' strings and tags <br>, and returns an attributed String with the converted elements. 
I.e. a 'href' string will be converted to a string with the links at the corresponding places. The converter uses a html wrapper template and inserts the text inside the document. The converter accepts NSAttributes for each text and link styling. 

The converter takes the NSAttributes, converts them into CSS-Styles, and inserts these into the HTML-Wrapper at the corresponding placeholders "$text-style$" for the regular text-Styling and "$link-style$" to style the links. 

Also, the converter accepts a custom HTML-Wrapper. The URL to the wrapper just needs to be provided.
The converter uses "$text-content$" as placeholder in the HTML-Wrapper. This is where the text input will be inserted in the HTML-Wrapper. Therefore, a custom wrapper needs to use this placeholder in the body of the HTML-Document. For styling the placeholders are "$text-style$" for the text and "$link-style$" for the links. The custom wrapper does not need to use these but could. 

## Installation
Install via cocoapods by adding this to your Podfile:

pod 'APLHrefStringConverter', '1.0.0'

## Usage
import APLHrefStringConverter

### Use HTMLStringConverter like this:

    import HTMLStringConverter

    let testString = "A string with <a href=\"http://www.apploft.de\">a link</a>"
    
    let linkTextAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
    NSAttributedString.Key.foregroundColor: UIColor.white,
    NSAttributedString.Key.underlineColor: UIColor.white,
    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]

    let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.brown]

    let stringWithLink = HTMLStringConverter.convert(testString, linkAttributes: linkTextAttributes, stringAttributes: attributes)

#### Using HTMLStringConverter with UITextView

UITextView has a property to detect links automatically. Therefore UITextViews can be useful in combination with this pod. The textView's property isEditable needs to be set to false for this to work.
Also, UITextView provides a property linkTextAttributes to style the links in its attributedString. This will override the converted link styles. So when using UITextViews, either use this property to style the links or set the link attributes to [:]:

    textView.attributedText = stringWithLink
    textView.linkTextAttributes = [:]
    textView.delegate = self
    textview.dataDetectorTypes
    textView.isEditable = false

#### Using HTMLStringConverter with UILabel
UILabel cannot automatically detect links, but can still be used to display html tagged formatted text with this converter.

    label.attributedText = stringWithLink

### Example using an HTML-Wrapper
    


APLHrefStringConverter(deprecated)
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
	
	NSString *testString = @"A string with <a href=\"http://www.apploft.de\">a link</a>";
   	NSMutableAttributedString *mutableStringWithHref = [APLHrefStringConverter convert:testString];
   
	self.textView.attributedString = mutableStringWithHref;
	self.textView.dataDetectorTypes = UIDataDetectorTypeLink;

	...
	
	// Implement the delegate method extending the UITextViewDelegate method
	// in order to be informed about URLs being touched by the user
	-(void)textView:(APLUrlTextView *)label didSelectLinkWithURL:(NSURL *)url {
	  ...
    }
    
Swift-Version:
            
        import APLHrefStringConverter
            
        self.textView.delegate = self
        let testString = "A string with <a href=\"http://www.apploft.de\">a link</a>"
        let stringWithLink = APLHrefStringConverter.convert(testString, linkAttributes: linkTextAttributes, stringAttributes: attributes)
        textView.linkTextAttributes = [:]
