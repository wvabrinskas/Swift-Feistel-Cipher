
Pod::Spec.new do |s|
  s.name         = "Feistel"
  s.version      = "1.0"
  s.summary      = "A feistel cipher algorithm written in Swift"
  s.description  = "A feistel cipher algorithm used to encrypt and decrypt data"

  s.swift_versions = "5.0"
  s.homepage     = "https://github.com/wvabrinskas/Swift-Feistel-Cipher"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "William Vabrinskas" => "wvabrinskas@gmail.com" }

  s.platforms = { :ios => "13.0" }
  s.source = { :git => "git@github.com:wvabrinskas/Swift-Feistel-Cipher.git" , :tag => "#{s.version}" }

  s.frameworks = 'UIKit' , 'Foundation', 'CommonCrypto'
  s.source_files  = "Feistel/Feistel.swift"
end
