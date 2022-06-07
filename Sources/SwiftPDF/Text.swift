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

        public init(value: String, font: UIFont = .systemFont(ofSize: 8), color: UIColor = UIColor.black, alignment: NSTextAlignment = .center) {
            self.value = value
            self.font = font
            self.color = color
            self.alignment = alignment
        }

        public var body: Never {
            fatalError()
        }

        var attributedText: NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineSpacing = 4

            let textAttributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color
            ]

            return NSAttributedString(string: value, attributes: textAttributes)
        }

        public var desiredSize: CGSize {
            attributedText.boundingRect(
                with: .zero,
                context: nil
            ).size
        }

        func desiredRect(in rect: CGRect) -> CGRect {
            let size = attributedText.boundingRect(
                with: .zero,
                context: nil
            )

            let desiredRect = CGRect(
                x: rect.origin.x,
                y: rect.origin.y,
                width: size.width,
                height: size.height
            )

            return desiredRect
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            attributedText.draw(in: rect)
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
