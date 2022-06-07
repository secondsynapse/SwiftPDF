//
//  VStack.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct VStack: Drawable {
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
            items.reduce(CGSize(width: CGFloat.infinity, height: 0)) { partialResult, item in
                CGSize(
                    width: .infinity,
                    height: partialResult.height + item.desiredSize.height
                )
            }
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let numberOfValidItems = items
                .filter {
                    $0.desiredSize.height != 0
                }
                .count

            let numberOfFlexibleItems = items
                .filter {
                    $0.desiredSize.height == .infinity
                }
                .count

            let totalDesiredHeight = items
                .filter {
                    $0.desiredSize.height != .infinity && $0.desiredSize.height != 0
                }
                .map {
                    $0.desiredSize.height
                }
                .reduce(0, +)

            let naturalHeight = (rect.height - totalDesiredHeight) / CGFloat(numberOfFlexibleItems) - (CGFloat(max(numberOfValidItems - 1, 0)) * spacing)

            var startingY: CGFloat = rect.origin.y

            for item in items {
                let itemRect = CGRect(
                    x: rect.origin.x,
                    y: startingY,
                    width: rect.width,
                    height: item.desiredSize.height == .infinity ? naturalHeight : item.desiredSize.height
                )

                item.draw(in: context, rect: itemRect)

                startingY += itemRect.height + spacing
            }
        }
    }
}
