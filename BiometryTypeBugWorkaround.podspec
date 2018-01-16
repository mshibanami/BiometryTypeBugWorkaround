Pod::Spec.new do |s|
  s.name             = 'BiometryTypeBugWorkaround'
  s.version          = '1.0.0'
  s.summary          = 'A workaround for iOS 11\'s bug about LAContext.biometryType.'

  s.description      = <<-DESC
                        `LAContext` of `LocalAuthentication` framework has a property called `biometryType`.
                        It has a type of biometric authentication supported by the device.
                        It is supporsed to be set after called `LAContext`'s `canEvaluatePolicy(_:error:)`.
                        But in some cases, it isn't set. It's a bug of iOS 11.0.x.
                        (See more details: http://www.openradar.me/radar?id=5061720007507968)
                        This library provides a workaround for the bug.
                      DESC

  s.homepage         = 'https://github.com/mshibanami/BiometryTypeBugWorkaround'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Manabu Nakazawa' => 'mshibanami+git@gmail.com' }
  s.source           = { git: 'https://github.com/mshibanami/BiometryTypeBugWorkaround.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/mshibanami'
  s.ios.deployment_target = '11.0'
  s.source_files = 'BiometryTypeBugWorkaround/Classes/**/*'
  # s.public_header_files = 'Pod/Classes/**/*.h'
end
