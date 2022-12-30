//
//  PDFCreator.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-10.
//

import Foundation
import PDFKit

public struct PDFCreator<Content> where Content : Drawable {
    var creator: String = ""
    var author: String = Bundle.main.bundleIdentifier ?? ""
    var title: String = ""
    public private(set) var size: CGSize = CGSize(width: 8.27 * 72.0, height: 11.69 * 72.0) // A4 Size is Default
    var content: Content

    public init(
        creator: String = "",
        author: String = "",
        title: String = "",
        size: CGSize = CGSize(width: 8.27 * 72.0, height: 11.69 * 72.0), // A4 Size is Default
        content: Content
    ) {
        self.creator = creator
        self.author = author
        self.title = title
        self.size = size
        self.content = content
    }

    public func createData() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: creator,
            kCGPDFContextAuthor: author,
            kCGPDFContextTitle: title
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageRect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            content.draw(in: context, rect: pageRect)
        }

        return data
    }
}



