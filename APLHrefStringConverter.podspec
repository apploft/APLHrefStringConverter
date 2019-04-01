Pod::Spec.new do |s|

  s.name         = "APLHrefStringConverter"
  s.version      = "1.0.3"
  s.summary      = "A simple extension of String taking a string containing hrefs and creating clickable MutableStrings"

  s.description  = <<-DESC
                   A simple String extension that creates clickable links out of hrefs contained in the String. The result is a mutableString that contains the text and the clickable hrefs at the right positions.
                   DESC

  s.homepage     = "https://github.com/apploft/APLUrlTextView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Famara Kassama" => "famara.kassama@gmail.com" }
  
  s.platform     = :ios, "10.0"
  
  s.source       = { :git => "https://github.com/apploft/APLHrefStringConverter.git", :tag => "0.0.4" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true

end
