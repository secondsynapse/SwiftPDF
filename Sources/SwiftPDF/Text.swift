//
//  Text.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct Text: Drawable {
        var value: String
        var font: UIFont = .systemFont(ofSize: 8)
        var color: UIColor = UIColor.black
        var alignment: NSTextAlignment = .center
        var minFontSize: CGFloat?

        public init(value: String, font: UIFont = .systemFont(ofSize: 8), color: UIColor = UIColor.black, alignment: NSTextAlignment = .center, minFontSize: CGFloat? = nil) {
            self.value = value
            self.font = font
            self.color = color
            self.alignment = alignment
            self.minFontSize = minFontSize
        }

        public var body: Never {
            fatalError()
        }

        func attributedText(rect: CGRect) -> NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineSpacing = 4

            let textAttributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: font.withSize(optimalFontSize(startingWith: font.pointSize, rect: rect)),
                NSAttributedString.Key.foregroundColor: color
            ]

            return NSAttributedString(string: value, attributes: textAttributes)
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            attributedText(rect: .init(origin: .zero, size: bound)).boundingRect(
                with: CGSize(width: bound.width, height: .zero),
                context: nil
            ).size
        }

        private func optimalFontSize(startingWith size: CGFloat, rect: CGRect) -> CGFloat {
            guard let minFontSize = minFontSize else {
                return font.pointSize
            }

            if size <= minFontSize {
                return minFontSize
            }

            let textAttributes = [
                NSAttributedString.Key.font: font.withSize(size)
            ]
            let attributedText = NSAttributedString(string: value, attributes: textAttributes)
            let requiredWidth = attributedText.size().width

            if requiredWidth > rect.width {
                return optimalFontSize(startingWith: size - 1, rect: rect)
            } else {
                return size
            }
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            attributedText(rect: rect).draw(in: rect)
        }
    }
}

public extension PDF.Text {
    init(_ string: String) {
        self.init(value: string)
    }
}

public extension PDF.Text {
    func alignment(_ alignment: NSTextAlignment) -> PDF.Text {
        var newSelf = self
        newSelf.alignment = alignment
        return newSelf
    }
}
