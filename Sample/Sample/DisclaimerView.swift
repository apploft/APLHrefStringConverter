//
// Created by apploft GmbH on 01.04.19.
// Copyright © 2018 apploft GmbH GmbH. All rights reserved.

import Foundation
import APLHrefStringConverter

class DisclaimerView : UIView, UITextViewDelegate {

    var lastClickedLink : URL?

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        imprintLinkClicked(clickedLink: URL)
        
        return false
    }
    
    @objc private func imprintLinkClicked(clickedLink : URL) {
        lastClickedLink = clickedLink
        UIApplication.shared.sendAction(#selector(ViewController.imprintLinkClicked), to: nil, from: self, for: nil)
    }
    
    private func commonInit() {
        addSubview(textView)
        setupConstraints()
        setupTextView()
    }
    
    private func setupTextView() {
        let string = "Sie akzeptieren die <a href=\"https://www.apploft.de/\">AGB</a>. Sie erhalten regelmäßig ausgesuchte Angebote zu Produkten der Apploft GmbH per E-Mail (Widerspruch jederzeit möglich)."
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.brown,
                                                             NSAttributedString.Key.font: UIFont.init(name: "Copperplate", size: 15) ?? UIFont.systemFont(ofSize: 12)]
        let linkTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                 NSAttributedString.Key.foregroundColor : UIColor.black,
                                                                 NSAttributedString.Key.underlineColor : UIColor.black,
                                                                 NSAttributedString.Key.font: UIFont.init(name: "Copperplate", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        textView.attributedText = HTMLTextConverter.convert(string, textAttributes: textAttributes, linkAttributes: linkTextAttributes, encoding: .isoLatin1)
        textView.textAlignment = .center
        textView.dataDetectorTypes = .link
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false

        //Setting the linkTextAttributes to [:] is important when using the linkAttributes property of the converter. Otherwise the textView overwrites the attributes with the default. Alternatively this property can be used to style the links instead of using the converter.
        textView.linkTextAttributes = [:]
        textView.delegate = self
    }
    
    private func setupConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private var textView : UITextView = UITextView()
    
    //Setting the textViewSize
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
}

