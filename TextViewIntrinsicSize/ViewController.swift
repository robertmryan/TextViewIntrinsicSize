//
//  ViewController.swift
//  TextViewIntrinsicSize
//
//  Created by Robert Ryan on 7/26/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let shortTextView = addTextView()
        shortTextView.text = "foo bar baz"

        let longTextView = addTextView()
        longTextView.text = "This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test."

        NSLayoutConstraint.activate([
            shortTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            longTextView.topAnchor.constraint(equalTo: shortTextView.bottomAnchor, constant: 40)
        ])
    }

    /// Add text view to main view
    ///
    /// This:
    ///    1. Creates text view (with border so we can see its `frame`);
    ///    2. Adds to the main view; and
    ///    3. Adds horizontal constraints (with `lessThanOrEqual` for width to take advantage of text view’s intrinsic size).
    ///
    /// Note, even if you turn off the border, I see the same problem on physical device running iOS 16.0 Beta 3 (20A5312j).
    /// But the border lets you see what's going on.

    func addTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor

        view.addSubview(textView)

        let widthConstraint = NSLayoutConstraint(
            item: textView,
            attribute: .width,
            relatedBy: .lessThanOrEqual,
            toItem: view,
            attribute: .width,
            multiplier: 0.8,
            constant: 0
        )

        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            widthConstraint
        ])

        // note, vertical constraint not yet set ... will be set by caller

        return textView
    }
}

