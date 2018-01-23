Pod::Spec.new do |s|

#1
s.platform     = :ios
s.swift_version = "4.0"
s.name         = "AlertManager"
s.summary      = "Manages Alert or Error Display."
s.requires_arc = true

#2
s.version      = "0.0.7"

#3
s.license      = { :type => "MIT", :file => "LICENSE" }

#4
s.author             = { "Avinash Kumar" => "cursivedgreat@gmail.com" }

#5
s.homepage     = "https://github.com/cursivedgreat/AlertManager"

#6
s.source       = { :git => "https://github.com/cursivedgreat/AlertManager.git", :tag => "#{s.version}" }

#7
s.framework  = "UIKit"

#8
s.source_files  = "AlertManager/**/*.{swift}"

#9
s.resources = "AlertManager/**/*.{png,jpeg,jpg,storyboard,xib}"
s.ios.deployment_target = '9.0'
end
