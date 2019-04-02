Pod::Spec.new do |s|

  s.name         = "APLHrefStringConverter"
  s.version      = "1.0.6"
  s.summary      = "A simple converter taking a string containing html formatted tags and creating a formatted attributed text"

  s.description  = <<-DESC
                   A simple string converter that creates an attributed text from an html formatted string. This way href can be detected and made clickable. The converter takes optional attributes and a custom htmlWrapper. 
                   DESC

  s.homepage     = "https://github.com/apploft/APLUrlTextView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Famara Kassama" => "famara.kassama@gmail.com" }
  
  s.platform     = :ios, "10.0"
  
  s.source       = { :git => "https://github.com/apploft/APLHrefStringConverter.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "Classes/**/*"
  s.exclude_files = "Classes/Exclude"
  s.resource_bundles = { "APLHrefStringConverter" => ['Resources/**/*.html'] }
  s.requires_arc = true

end
