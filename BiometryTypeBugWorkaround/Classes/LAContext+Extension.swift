// Copyright (c) 2018 Manabu Nakazawa <mshibanami+git@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import LocalAuthentication

public extension LAContext {
    /// biometryType that works properly even on iOS 11.0.x devices.
    ///
    /// - Parameter error: a error of `canEvaluatePolicy(_:error:)`.
    ///   Set `nil` if the method was succeeded.
    ///
    /// - Returns: The type of biometric authentication supported by the device.
    @available(iOS, introduced: 11.0, deprecated: 11.1, message: "This method is a workaround for iOS 11.0.x's bug. So now you can just use `biometryType`. Yep, it's time to remove the library 'BiometryTypeBugWorkaround'!")
    public func biometryTypeForWorkaround(with error: LAError? = nil) -> LABiometryType {
        let iPhoneXHeight: CGFloat = 2436

        if #available(iOS 11.1, *) {
            return biometryType
        }

        if let error = error,
            error.code == .biometryNotAvailable {
            return .LABiometryNone
        }

        let isiPhoneX
            = (UIScreen.main.nativeBounds.height == iPhoneXHeight)

        if isiPhoneX {
            return .faceID
        } else {
            return .touchID
        }
    }
}
