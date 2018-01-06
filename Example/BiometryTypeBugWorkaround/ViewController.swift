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

import UIKit
import LocalAuthentication
import BiometryTypeBugWorkaround

class ViewController: UIViewController {
    @IBOutlet private weak var canEvaluatePolicyLabel: UILabel!
    @IBOutlet private weak var biometryTypeLabel: UILabel!
    @IBOutlet private weak var biometryTypeForWorkaroundLabel: UILabel!
    @IBOutlet private weak var runCanEvaluatePolicyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.runCanEvaluatePolicyButton.titleLabel?
            .adjustsFontForContentSizeCategory = true
        self.runCanEvaluatePolicyButton.titleLabel?
            .textAlignment = .center
    }

    private func runCanEvaluatePolicy() {
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context
            .canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error)

        self.canEvaluatePolicyLabel.text = "\(canEvaluate)"
        self.biometryTypeLabel.text = context.biometryType.text
        self.biometryTypeForWorkaroundLabel.text
            = context.biometryTypeForWorkaround(
                with: error as? LAError)
                .text
    }

    @IBAction private func onTapRunCanEvaluatePolicyButton(_ sender: UIButton) {
        runCanEvaluatePolicy()
    }
}

private extension LABiometryType {
    var text: String {
        switch self {
        case .none:
            return ".none"
        case .touchID:
            return ".touchID"
        case .faceID:
            return ".faceID"
        }
    }
}
