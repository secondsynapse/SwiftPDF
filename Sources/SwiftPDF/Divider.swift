//
//  HDivider.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public extension PDF {
    struct HDivider: Drawable {
        public var color: CGColor

        public init(color: CGColor) {
            self.color = color
        }

        public var body: some Drawable {
            _BackgroundColor(color: color, content: EmptyDrawable())
                .frame(width: 1)
        }
    }

    struct VDivider: Drawable {
        public var color: CGColor

        public init(color: CGColor) {
            self.color = color
        }

        public var body: some Drawable {
            _BackgroundColor(color: color, content: EmptyDrawable())
                .frame(height: 1)
        }
    }
}
