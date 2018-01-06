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

import Quick
import Nimble
import LocalAuthentication
import BiometryTypeBugWorkaround

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("biometryTypeForWorkaround") {
            it("is none before running canEvaluatePolicy()") {
                let context = LAContext()

                let biometryType1 = context.biometryTypeForWorkaround(with: nil)
                expect(biometryType1) == LABiometryType.LABiometryNone
            }

            it("is set after calling canEvaluatePolicy()") {
                let context = LAContext()
                var error: NSError?
                let canEvaluate = context.canEvaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    error: &error)

                let biometryType = context.biometryTypeForWorkaround(
                    with: error as? LAError)

                let realBiometryType = context.biometryType

                if canEvaluate {
                    expect(biometryType) != LABiometryType.LABiometryNone
                    expect(biometryType) == realBiometryType

                    let biometryTypeErrorNotSpecified = context.biometryTypeForWorkaround()
                    expect(biometryTypeErrorNotSpecified) != LABiometryType.LABiometryNone
                    expect(biometryTypeErrorNotSpecified) == realBiometryType
                }
                else {
                    guard let error = error as? LAError else {
                        fail("error is not supposed to be nil if canEvaluate is false.")
                        return
                    }

                    if error.code == LAError.Code.biometryNotAvailable {
                        expect(biometryType) == LABiometryType.LABiometryNone
                        expect(biometryType) == realBiometryType
                    } else {
                        expect(biometryType) != LABiometryType.LABiometryNone

                        // Don't expect biometryType == realBiometryType.
                        // because realBiometryType has none for some devices.
                        // That is why this library exists.
                    }
                }
            }
        }
    }
}
