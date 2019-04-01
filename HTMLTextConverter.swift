//
//  HTMLTextConverter.swift
//  
//
//  Created by Famara Kassama on 29.03.19.
//

import Foundation

class HTMLTextConverter: NSObject {

    static let textStylePlaceholder: String = "$text-style$"
    static let linkStylePlaceholder: String = "$link-style$"
    static let textPlaceholder: String = "$text-content$"

    private static let defaultWrapperFileName = "HTML-Wrapper"

    class func convert(_ text: String, textAttributes: [NSAttributedString.Key: Any]? = nil, linkAttributes: [NSAttributedString.Key: Any]? = nil, htmlWrapperURL: URL? = nil, encoding: String.Encoding = .utf8) -> NSAttributedString? {
        guard let htmlWrapper = HTMLTextConverter.getHTMLWrapper(htmlWrapperURL) else { return nil }

        let htmlWrapperString = String(data: htmlWrapper, encoding: .utf8)
        let defaultTextStyleString = CSSAttributedDictionary(attributes: textAttributes).toHtmlString()
        let linkStyleString = CSSAttributedDictionary(attributes: linkAttributes).toHtmlString()

        guard let htmlStyled = htmlWrapperString?.replacingOccurrences(of: textStylePlaceholder, with: defaultTextStyleString) else { return nil }

        let htmlLinkStyled = htmlStyled.replacingOccurrences(of: linkStylePlaceholder, with: linkStyleString)

        let plaintext = text.replacingOccurrences(of: "\r\n", with: "<br>")
        let html = htmlLinkStyled.replacingOccurrences(of: textPlaceholder, with: plaintext)

        var htmlString: NSAttributedString?

        if let data = html.data(using: encoding) {
            htmlString = try? NSAttributedString(data: data,
                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
        }

        return htmlString
    }
    
    class func getHTMLWrapper(_ htmlWrapperURL: URL? = nil) -> Data? {
        guard let htmlWrapperURL = htmlWrapperURL ?? Bundle(for: HTMLTextConverter.self).url(forResource: defaultWrapperFileName, withExtension: "html"), let htmlWrapper = try? Data(contentsOf: htmlWrapperURL) else { return nil }
        return htmlWrapper
    }
}

enum CSSIdentifier: String {
    case color = "color"
    case fontFamily = "font-family"
    case fontSize = "font-size"
    case textDecoration = "text-decoration"
}

struct CSSAttribute {
    var identifier: CSSIdentifier
    var value: String
}

struct CSSAttributedDictionary {
    static let iosSystemFamilyFont: String = "system-ui"

    var attributeDict: [CSSIdentifier: String] = [.fontFamily: CSSAttributedDictionary.iosSystemFamilyFont, .fontSize: "12px"]

    init(attributes: [NSAttributedString.Key: Any]?) {
        guard let attributes = attributes else { return }
        for attribute in attributes {
            switch attribute.key {
            case .foregroundColor:
                guard let color: UIColor = attribute.value as? UIColor else { break }
                attributeDict[.color] = "\(color.toHexString())"
            case .font:
                guard let font = attribute.value as? UIFont else { break }
                let isSystemFontFamily = font.familyName == UIFont.systemFont(ofSize: 12).familyName
                attributeDict[.fontFamily] = isSystemFontFamily ? CSSAttributedDictionary.iosSystemFamilyFont : "\(font.familyName)"
                attributeDict[.fontSize] = "\(font.pointSize)px"
            case .underlineStyle:
                guard let underlineStyle = attribute.value as? NSUnderlineStyle else { break }
                if underlineStyle == .single {
                    attributeDict[.textDecoration] = "underline"
                }
            default:
                break
            }
        }
    }

    func toHtmlString() -> String {
        return (attributeDict.compactMap({ (key, value) -> String in
            return "\(key.rawValue):\(value)"
        }) as Array).joined(separator: ";")
    }
}
