//
//  File.swift
//  
//
//  Created by Ata Namvari on 2022-06-20.
//

import Foundation
import PDFKit
import SwiftUI

public extension PDF {
    struct FilledShape<S>: Drawable where S : SwiftUI.Shape {
        var from: S
        var fillColor: CGColor = UIColor.black.cgColor

        public init(from: S, fillColor: CGColor = UIColor.black.cgColor) {
            self.from = from
            self.fillColor = fillColor
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let cgPath = from.path(in: rect).cgPath
            context.cgContext.addPath(cgPath)
            context.cgContext.setFillColor(fillColor)
            context.cgContext.fillPath()
        }
    }
}

