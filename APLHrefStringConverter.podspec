Pod::Spec.new do |s|

  s.name         = "APLHrefStringConverter"
  s.version      = "0.0.1"
  s.summary      = "A simple extension of String taking a string containing hrefs and creating clickable MutableStrings"

  s.description  = <<-DESC
                   A simple String extension that creates clickable links out of hrefs contained in the String.
                   DESC

  s.homepage     = "https://github.com/apploft/APLUrlTextView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Famara Kassama" => "famara.kassama@gmail.com" }
  
  s.platform     = :ios, "10.0"
  
  s.source       = { :git => "git@github.com:apploft/APLHrefStringConverter.git", :tag => "0.0.1" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true

end
