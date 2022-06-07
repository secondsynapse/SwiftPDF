//
//  Page.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct Page<Content>: Drawable where Content : Drawable {
        var content: Content

        public init(content: () -> Content) {
            self.content = content()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public var body: Never {
            fatalError()
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            context.beginPage()
            content.draw(in: context, rect: rect)
        }
    }
}
