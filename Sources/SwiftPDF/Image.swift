//
//  Image.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-17.
//

import Foundation
import PDFKit
import UIKit

public extension PDF {
    struct Image: Drawable {
        var from: UIImage

        public init(from: UIImage) {
            self.from = from
        }

        public var body: Never {
            fatalError()
        }

        public var desiredSize: CGSize {
            from.size
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            from.draw(in: rect)
        }
    }
}
