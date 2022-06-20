//
//  File.swift
//  
//
//  Created by Ata Namvari on 2022-06-20.
//

import Foundation
import PDFKit

public extension PDF {
    struct Grid: Drawable {
        var horizontalSpacing: CGFloat = 0
        var verticalSpacing: CGFloat = 0
        var items: [AnyDrawable]

        public init(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0, @DrawableCollectionBuilder items: () -> [AnyDrawable]) {
            self.horizontalSpacing = horizontalSpacing
            self.verticalSpacing = verticalSpacing
            self.items = items()
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            var runningWidth: CGFloat = 0
            var runningHeight: CGFloat = 0
            var maxRowHeight: CGFloat = 0

            for item in items {
                let itemSize = item.desiredSize

                if rect.width - runningWidth < itemSize.width && runningWidth != 0 {
                    runningWidth = 0
                    runningHeight += maxRowHeight + verticalSpacing
                    maxRowHeight = 0
                }

                item.draw(
                    in: context,
                    rect: CGRect(
                        origin: CGPoint(x: rect.origin.x + runningWidth, y: rect.origin.y + runningHeight),
                        size: itemSize
                    )
                )

                runningWidth += itemSize.width + horizontalSpacing
                maxRowHeight = max(maxRowHeight, itemSize.height)
            }
        }
    }
}
