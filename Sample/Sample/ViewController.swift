//
//  ViewController.swift
//  Sample
//
//  Created by Famara Kassama on 01.04.19.
//  Copyright © 2019 Famara Kassama. All rights reserved.
//

import UIKit
import WebKit
import APLHrefStringConverter

class ViewController: UIViewController {

    @IBOutlet weak var htmlWrapperLabel: UILabel!
    @IBOutlet weak var falseLinkLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFalseLinkLabel()
        setupHTMLWrapperLabel()
    }

    @objc func imprintLinkClicked(_ sender: Any?) {
        guard let disclaimerView = sender as? DisclaimerView, let url = disclaimerView.lastClickedLink else {
            return
        }
        
        let webViewController = UIViewController()
        let webView = WKWebView()
        let request = URLRequest(url: url)
        
        webViewController.view = webView
        show(webViewController, sender: nil)
        webView.load(request)
    }
    
    private func setupHTMLWrapperLabel() {
        //Example string containing different html tags
        let string = "<h1>Ihr Partner für Erfolg in der App Welt!</h1><br><li>apploft</li>ist eine Tech Agentur der mobilen Welt, die 2008 als Ausgründung aus Apple gestartet ist. Heute begleiten wir viele Kunden auf dem Weg zum Erfolg. Unsere Kernbereiche sind dabei iOS, Android, tvOS, Android TV, AR, VR, Bots und Skills und unser Leistungsportfolio erstreckt sich von Strategieberatung, Design Thinking, Agile Coaching, UX, UI-Design, über die Software-Entwicklung bis hin zum Aufbau und Betrieb Cloud basierter Backend-Services."

        //loading the htmlWrapper file from the bundle
        let customHTMLWrapper = Bundle.main.url(forResource: "HTML-Custom-Wrapper", withExtension: ".html")

        htmlWrapperLabel.attributedText = HTMLTextConverter.convert(string, htmlWrapperURL: customHTMLWrapper, encoding: .isoLatin1)
    }
    
    //Showing that this converter can be used with labels too, but one needs to be careful when using hrefs with UILabels, because UILabel cannot detect links. Therefore the user might falsely click on the link.
    private func setupFalseLinkLabel() {
        let string = "This <a href=\"https://www.apploft.de/\">LINK</a> is not clickable, because it is just a label not a textView!"
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.brown,
                                                             NSAttributedString.Key.font: UIFont.init(name: "Copperplate", size: 15) ?? UIFont.systemFont(ofSize: 12)]
        let linkTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]

        falseLinkLabel.attributedText = HTMLTextConverter.convert(string, textAttributes: textAttributes, linkAttributes: linkTextAttributes, encoding: .isoLatin1)
    }
}

