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

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            items.reduce(CGSize(width: CGFloat.infinity, height: 0)) { partialResult, item in
                CGSize(
                    width: .infinity,
                    height: partialResult.height + item.desiredSize(
                        boundedBy: CGSize(width: bound.width, height: bound.height - partialResult.height)
                    ).width
                )
            }
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let numberOfValidItems = items
                .filter {
                    $0.desiredSize(boundedBy: rect.size).height != 0
                }
                .count

            let numberOfFlexibleItems = items
                .filter {
                    $0.desiredSize(boundedBy: rect.size).height == .infinity
                }
                .count

            let totalDesiredHeight = items
                .filter {
                    $0.desiredSize(boundedBy: rect.size).height != .infinity && $0.desiredSize(boundedBy: rect.size).height != 0
                }
                .reduce(0, { partialResult, item in
                    partialResult + item.desiredSize(boundedBy: CGSize(width: rect.height, height: rect.width - partialResult)).height
                })

            let naturalHeight = (rect.height - totalDesiredHeight) / CGFloat(numberOfFlexibleItems) - (CGFloat(max(numberOfValidItems - 1, 0)) * spacing)

            var startingY: CGFloat = rect.origin.y

            for item in items {
                let itemRect = CGRect(
                    x: rect.origin.x,
                    y: startingY,
                    width: rect.width,
                    height: item.desiredSize(
                        boundedBy: CGSize(width: rect.width, height: rect.height - (startingY - rect.minY))
                    ).height == .infinity ? naturalHeight : item.desiredSize(
                        boundedBy: CGSize(width: rect.width, height: rect.height - (startingY - rect.minY))
                    ).height
                )

                item.draw(in: context, rect: itemRect)

                startingY += itemRect.height + spacing
            }
        }
    }
}
