//
//  Shape.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import SwiftUI

public extension PDF {
    struct Shape<S>: Drawable where S : SwiftUI.Shape {
        var from: S
        var strokeColor: CGColor = UIColor.black.cgColor
        var strokeWidth: CGFloat = 1
        var dashed: Bool = false

        public init(from: S, strokeColor: CGColor = UIColor.black.cgColor, strokeWidth: CGFloat = 1, dashed: Bool = false) {
            self.from = from
            self.strokeColor = strokeColor
            self.strokeWidth = strokeWidth
            self.dashed = dashed
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let cgPath = from.path(in: rect).cgPath
            let newPath = cgPath.copy(
                strokingWithWidth: strokeWidth,
                lineCap: .butt,
                lineJoin: CGLineJoin.round,
                miterLimit: 0,
                transform: CGAffineTransform(translationX: rect.origin.x, y: rect.origin.y)
            )

            context.cgContext.addPath(newPath)
            context.cgContext.setStrokeColor(strokeColor)
            context.cgContext.setLineWidth(strokeWidth)
            context.cgContext.setLineDash(phase: 0, lengths:  dashed ? [5, 5] : [])
            context.cgContext.strokePath()
        }
    }
}

public extension PDF {
    struct Rectangle: Drawable {
        var color: CGColor
        var width: CGFloat = 1

        public init(color: CGColor, width: CGFloat = 1) {
            self.color = color
            self.width = width
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            context.cgContext.saveGState()
            context.cgContext.setStrokeColor(color)
            context.cgContext.stroke(rect, width: width)
            context.cgContext.restoreGState()
        }
    }
}
