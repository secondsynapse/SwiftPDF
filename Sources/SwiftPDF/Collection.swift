//
//  Collection.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-11.
//

import Foundation

public extension PDF {
    @resultBuilder
    struct DrawableCollectionBuilder {

        public static func buildArray(_ components: [[PDF.AnyDrawable]]) -> [PDF.AnyDrawable] {
            components.flatMap({ $0 })
        }

        public static func buildBlock(_ components: [AnyDrawable]) -> [AnyDrawable] {
            components
        }

        public static func buildEither(first component: [PDF.AnyDrawable]) -> [PDF.AnyDrawable] {
            component
        }

        public static func buildEither(second component: [PDF.AnyDrawable]) -> [PDF.AnyDrawable] {
            component
        }

        public static func buildBlock<D0>(_ component: D0) -> [AnyDrawable] where D0 : Drawable {
            [AnyDrawable(component)]
        }

        public static func buildBlock<D0, D1>(_ d0: D0, _ d1: D1) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1)
            ]
        }

        public static func buildBlock<D0, D1, D2>(_ d0: D0, _ d1: D1, _ d2: D2) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4, D5>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4, _ d5: D5) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable, D5 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4),
                AnyDrawable(d5)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4, D5, D6>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4, _ d5: D5, _ d6: D6) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable, D5 : Drawable, D6 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4),
                AnyDrawable(d5),
                AnyDrawable(d6)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4, D5, D6, D7>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4, _ d5: D5, _ d6: D6, _ d7: D7) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable, D5 : Drawable, D6 : Drawable, D7 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4),
                AnyDrawable(d5),
                AnyDrawable(d6),
                AnyDrawable(d7)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4, D5, D6, D7, D8>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4, _ d5: D5, _ d6: D6, _ d7: D7, _ d8: D8) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable, D5 : Drawable, D6 : Drawable, D7 : Drawable, D8 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4),
                AnyDrawable(d5),
                AnyDrawable(d6),
                AnyDrawable(d7),
                AnyDrawable(d8)
            ]
        }

        public static func buildBlock<D0, D1, D2, D3, D4, D5, D6, D7, D8, D9>(_ d0: D0, _ d1: D1, _ d2: D2, _ d3: D3, _ d4: D4, _ d5: D5, _ d6: D6, _ d7: D7, _ d8: D8, _ d9: D9) -> [AnyDrawable] where D0 : Drawable, D1 : Drawable, D2 : Drawable, D3 : Drawable, D4 : Drawable, D5 : Drawable, D6 : Drawable, D7 : Drawable, D8 : Drawable, D9 : Drawable {
            [
                AnyDrawable(d0),
                AnyDrawable(d1),
                AnyDrawable(d2),
                AnyDrawable(d3),
                AnyDrawable(d4),
                AnyDrawable(d5),
                AnyDrawable(d6),
                AnyDrawable(d7),
                AnyDrawable(d8),
                AnyDrawable(d9)
            ]
        }

    }
}
