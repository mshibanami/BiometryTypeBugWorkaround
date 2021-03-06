# BiometryTypeBugWorkaround

[![CI Status](http://img.shields.io/travis/mshibanami/BiometryTypeBugWorkaround.svg?style=flat)](https://travis-ci.org/mshibanami/BiometryTypeBugWorkaround)
[![Version](https://img.shields.io/cocoapods/v/BiometryTypeBugWorkaround.svg?style=flat)](http://cocoapods.org/pods/BiometryTypeBugWorkaround)
[![License](https://img.shields.io/cocoapods/l/BiometryTypeBugWorkaround.svg?style=flat)](http://cocoapods.org/pods/BiometryTypeBugWorkaround)
[![Platform](https://img.shields.io/cocoapods/p/BiometryTypeBugWorkaround.svg?style=flat)](http://cocoapods.org/pods/BiometryTypeBugWorkaround)

`LAContext` of `LocalAuthentication` framework has a property called `biometryType`.
It has a type of biometric authentication supported by the device.
It's supporsed to be set after called `LAContext`'s `canEvaluatePolicy(_:error:)`.
But in some cases, it isn't set. It's a bug of iOS 11.0.x.

Futhermore, iOS devices would be crash if you call biometryType on iOS 11.0.

(See more details of bugs: <http://www.openradar.me/radar?id=5061720007507968>)

This library provides a workaround for these bugs.

## Usage

This library provides just 1 method as `LAContext`'s extension.
It's `biometryTypeForWorkaround(with:)`.
It's a replacement of `LAContext`'s `biometryType` property. You can use it like this:

```swift
let context = LAContext()
var error: NSError?
let canEvaluate = context.canEvaluatePolicy(
    .deviceOwnerAuthenticationWithBiometrics,
    error: &error)

let biometryType = context.biometryTypeForWorkaround(
    with: error as? LAError)
```

## Caution

* Don't call this method before calling `canEvaluatePolicy(_:error:)`.
    It doesn't have the default value (`none`).
* This library is unnecessary if your app's deployment target is iOS 11.1 or later.
Because this library is for the bug of 11.0 and 11.0.x.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BiometryTypeBugWorkaround is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BiometryTypeBugWorkaround'
```

## Author

Manabu Nakazawa ([@mshibanami](https://twitter.com/mshibanami))

## License

BiometryTypeBugWorkaround is available under the MIT license. See the LICENSE file for more info.
