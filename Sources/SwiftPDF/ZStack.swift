//
//  ZStack.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct ZStack: Drawable {
        var items: [AnyDrawable]

        public init(@DrawableCollectionBuilder items: () -> [AnyDrawable]) {
            self.items = items()
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            for item in items {
                let itemRect = CGRect(
                    x: rect.origin.x,
                    y: rect.origin.y,
                    width: rect.width,
                    height: rect.height
                )

                item.draw(in: context, rect: itemRect)
            }
        }
    }
}
