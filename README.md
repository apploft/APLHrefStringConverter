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
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
    ]

    let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.brown]

    let htmlFormattedString = HTMLStringConverter.convert(testString, linkAttributes: linkTextAttributes, stringAttributes: textAttributes)

#### Example using HTMLStringConverter with UITextView

UITextView has a property to detect links automatically. Therefore UITextViews can be useful in combination with this pod. The textView's property isEditable needs to be set to false for this to work.
Also, UITextView provides a property linkTextAttributes to style the links in its attributedString. This will override the converted link styles. So when using UITextViews, either use this property to style the links or set the link attributes to [:]:

    textView.attributedText = htmlFormattedString
    textView.linkTextAttributes = [:]
    textView.delegate = self
    textview.dataDetectorTypes
    textView.isEditable = false

#### Example using HTMLStringConverter with UILabel
UILabel cannot automatically detect links, but can still be used to display html tagged formatted text with this converter. 
Warning: Despite UILabel not being able to detect links automatically, links can still be displayed and formatted through linkAttributes when using the HTMLStringConverter. This can lead to a false UI when using UILabel instead of UITextView. (Example in Sample project)

    label.attributedText = htmlFormattedString

### Example using HTMLStringConverter with an HTML-Wrapper
HTML-Custom-Wrapper.html:
    
    <!DOCTYPE html>
    <html>
        <head>
        <style>
            body {
                font-family: 'Droid Sans';
                font-style: normal;
                font-weight: 400;
                margin: 50px;
                }
            h1 {
                font-size: 35px;
                font-weight: normal;
                margin-top: 5px;
                text-align: center;
                }
            li {
                background-color: #3aa5c0;
                }
        </style>
        </head>
        <body>
            <div class="Text">
                $text-content$
                </div>
        </body>
    </html>

#### Usage

    let htmlWrapperLabel = UILabel()
    let string = "<h1>Ihr Partner für Erfolg in der App Welt!</h1><br><li>apploft</li>ist eine Tech Agentur der mobilen Welt, die 2008 als Ausgründung aus Apple gestartet ist. Heute begleiten wir viele Kunden auf dem Weg zum Erfolg. Unsere Kernbereiche sind dabei iOS, Android, tvOS, Android TV, AR, VR, Bots und Skills und unser Leistungsportfolio erstreckt sich von Strategieberatung, Design Thinking, Agile Coaching, UX, UI-Design, über die Software-Entwicklung bis hin zum Aufbau und Betrieb Cloud basierter Backend-Services."

    //loading the htmlWrapper file
    let customHTMLWrapper = Bundle.main.url(forResource: "HTML-Custom-Wrapper", withExtension: ".html")
    htmlWrapperLabel.attributedText = HTMLTextConverter.convert(string, htmlWrapperURL: customHTMLWrapper, encoding: .isoLatin1)

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
