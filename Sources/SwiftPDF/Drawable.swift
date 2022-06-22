//
//  Drawable.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation
import PDFKit

public protocol Drawable {
    associatedtype Body: Drawable

    var body: Body { get }

    func desiredSize(boundedBy bound: CGSize) -> CGSize
    func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect)
}

public extension Drawable {
    func desiredSize(boundedBy bound: CGSize) -> CGSize {
        body.desiredSize(boundedBy: bound)
    }

    func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
        body.draw(in: context, rect: rect)
    }
}

extension Never: Drawable {
    public func desiredSize(boundedBy bound: CGSize) -> CGSize {
        .zero
    }

    public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
        fatalError()
    }
}

// MARK: Namespace

public struct PDF {}

// MARK: Type Erasure

public extension PDF {
    struct AnyDrawable: Drawable {
        var _draw: (UIGraphicsPDFRendererContext, CGRect) -> Void
        var _desiredSize: (CGSize) -> CGSize

        public init<D>(_ drawable: D) where D : Drawable {
            self._draw = {
                drawable.draw(in: $0, rect: $1)
            }

            self._desiredSize = {
                drawable.desiredSize(boundedBy: $0)
            }
        }

        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            self._desiredSize(bound)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            self._draw(context, rect)
        }
    }
}

public extension Drawable {
    func eraseToAnyDrawable() -> PDF.AnyDrawable {
        PDF.AnyDrawable(self)
    }
}

// MARK: Padding

public extension PDF {
    struct _Padding<Content>: Drawable where Content : Drawable {
        var margins = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        var content: Content

        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            CGSize(
                width: content.desiredSize(boundedBy: bound).width + margins.left + margins.right,
                height: content.desiredSize(boundedBy: bound).height + margins.top + margins.bottom
            )
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let newRect = CGRect(
               x: rect.origin.x + margins.left,
               y: rect.origin.y + margins.top,
               width: rect.width - margins.left - margins.right,
               height: rect.height - margins.top - margins.bottom
            )

            content.draw(in: context, rect: newRect)
        }
    }
}

public extension Drawable {
    func padding(_ insets: UIEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)) -> some Drawable {
        PDF._Padding(margins: insets, content: self)
    }

    func padding(_ value: CGFloat) -> some Drawable {
        PDF._Padding(margins: UIEdgeInsets(top: value, left: value, bottom: value, right: value), content: self)
    }
}

// MARK: Background

public extension PDF {
    struct _Background<Content, Background>: Drawable where Content : Drawable, Background : Drawable {
        var background: Background
        var content: Content

        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            content.desiredSize(boundedBy: bound)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            background.draw(in: context, rect: rect)
            content.draw(in: context, rect: rect)
        }
    }
}

public extension Drawable {
    func background<B>(_ background: B) -> some Drawable where B : Drawable {
        PDF._Background(background: background, content: self)
    }
}

// MARK: BackgroundColor

public extension PDF {
    struct _BackgroundColor<Content>: Drawable where Content : Drawable {
        var color: CGColor
        var content: Content

        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            content.desiredSize(boundedBy: bound)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            context.cgContext.setFillColor(color)
            context.cgContext.fill(rect)

            content.draw(in: context, rect: rect)
        }
    }
}

public extension Drawable {
    func backgroundColor(_ color: CGColor) -> some Drawable {
        PDF._BackgroundColor(color: color, content: self)
    }
}

// MARK: Frame

public extension PDF {
    struct _Frame<Content>: Drawable where Content : Drawable {
        var width: CGFloat?
        var height: CGFloat?
        var content: Content

        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            CGSize(
                width: width ?? content.desiredSize(boundedBy: bound).width,
                height: height ?? content.desiredSize(boundedBy: bound).height
            )
        }

        func desiredRect(in rect: CGRect) -> CGRect {
            CGRect(
                x: rect.origin.x,
                y: rect.origin.y,
                width: width ?? rect.width,
                height: height ?? rect.height
            )
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {
            let newRect = CGRect(
                x: rect.origin.x,
                y: rect.origin.y,
                width: width ?? rect.width,
                height: height ?? rect.height
            )

            content.draw(in: context, rect: newRect)
        }
    }
}

public extension Drawable {
    func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> some Drawable {
        PDF._Frame(width: width, height: height, content: self)
    }
}


// MARK: EmptyDrawable

public extension PDF {
    struct EmptyDrawable: Drawable {
        public init() {

        }
        
        public var body: Never {
            fatalError()
        }

        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            .zero
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {

        }
    }
}


// MARK: Spacer

public extension PDF {
    struct Spacer: Drawable {
        public init() {
            
        }

        public var body: Never {
            fatalError()
        }
        
        public func desiredSize(boundedBy bound: CGSize) -> CGSize {
            CGSize(width: CGFloat.infinity, height: .infinity)
        }

        public func draw(in context: UIGraphicsPDFRendererContext, rect: CGRect) {

        }
    }
}
