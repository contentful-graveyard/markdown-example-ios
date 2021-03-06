//
//  MDTextViewController.swift
//  Markdown
//
//  Created by Boris Bügling on 01/12/15.
//  Copyright © 2015 Contentful GmbH. All rights reserved.
//

import CocoaMarkdown
import UIKit

class MDTextViewController: UIViewController {
    var entryId = "4bJdF7zhwkwcWq202gmkuM"

    convenience init() {
        self.init(nibName: nil, bundle: nil)

        self.tabBarItem = UITabBarItem(title: "TextView", image: UIImage(named: "lightning"), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let textView = UITextView(frame: view.bounds)
        textView.isEditable = false
        view.addSubview(textView)

        client.fetchEntry(identifier: entryId).1.next { (entry) in
            if let markdown = entry.fields["body"] as? String {
                let data = markdown.data(using: String.Encoding.utf8)
                let document = CMDocument(data: data, options: [])
                let renderer = CMAttributedStringRenderer(document: document, attributes: CMTextAttributes())

                DispatchQueue.main.async {
                    textView.attributedText = renderer?.render()
                }
            }
        }.error { (error) in
            showError(error, self)
        }
    }
}
