//
//  HStack.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct HStack: Drawable {
        var spacing: CGFloat = 0
        var items: [AnyDrawable]

        public init(spacing: CGFloat = 0, @DrawableCollectionBuilder items: () -> [AnyDrawable]) {
            self.spacing = spacing
            self.items = items()
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            items.reduce(CGSize(width: 0, height: CGFloat.infinity)) { partialResult, item in
                CGSize(
                    width: partialResult.width + item.desiredSize.width,
                    height: .infinity
                )
            }
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let numberOfValidItems = items
                .filter {
                    $0.desiredSize.width != 0
                }
                .count

            let numberOfFlexibleItems = items
                .filter {
                    $0.desiredSize.width == .infinity
                }
                .count

            let totalDesiredWidth = items
                .filter {
                    $0.desiredSize.width != .infinity && $0.desiredSize.width != 0
                }
                .map {
                    $0.desiredSize.width
                }
                .reduce(0, +)

            let naturalWidth = (rect.width - totalDesiredWidth) / CGFloat(numberOfFlexibleItems) - (CGFloat(max(numberOfValidItems - 1, 0)) * spacing)

            var startingX: CGFloat = rect.origin.x

            for item in items {
                let itemRect = CGRect(
                    x: startingX,
                    y: rect.origin.y,
                    width: item.desiredSize.width == .infinity ? naturalWidth : item.desiredSize.width,
                    height: rect.height
                )

                item.draw(in: context, rect: itemRect)

                startingX += itemRect.width + spacing
            }
        }
    }
}
