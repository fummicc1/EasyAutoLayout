#
#  Be sure to run `pod spec lint EasyAutoLayout.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
Pod::Spec.new do |s|
  s.name         = "EasyAutoLayout"
  s.version      = "1.0.3"
  s.summary      = "EasyAutoLayout aims to be able to implement AutoLayout easily especially for developers who are not good at or have learned AutoLayout."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/fummicc1/EasyAutoLayout"
  s.author       = { "fummicc1" => "fumiya.tennis1@gmail.com" }
  s.source       = { :git => "https://github.com/fummicc1/EasyAutoLayout.git", :tag => "1.0.3" }
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.source_files = 'EasyAutoLayout/**/*.{swift}'
  s.swift_version = "5.0"
  end