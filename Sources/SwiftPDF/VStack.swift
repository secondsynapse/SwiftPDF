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
        public enum Alignment {
            case left
            case right
            case center
        }

        var spacing: CGFloat = 0
        var alignment: Alignment
        var items: [AnyDrawable]

        public init(spacing: CGFloat = 0, alignment: Alignment = .left, @DrawableCollectionBuilder items: () -> [AnyDrawable]) {
            self.spacing = spacing
            self.items = items()
            self.alignment = alignment
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
                    ).height
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
                let itemDesiredSize = item.desiredSize(boundedBy: CGSize(width: rect.width, height: rect.height - (startingY - rect.minY)))
                let x: CGFloat

                switch alignment {
                case .left:
                    x = rect.origin.x
                case .right:
                    x = rect.origin.x + rect.width - itemDesiredSize.width
                case .center:
                    x = (rect.origin.x + rect.width - itemDesiredSize.width) / 2
                }

                let itemRect = CGRect(
                    x: x,
                    y: startingY,
                    width: rect.width,
                    height: itemDesiredSize.height == .infinity ? naturalHeight : itemDesiredSize.height
                )

                item.draw(in: context, rect: itemRect)

                startingY += itemRect.height + spacing
            }
        }
    }
}
