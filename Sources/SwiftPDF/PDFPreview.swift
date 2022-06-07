//
//  PDFPreview.swift
//  COMMAND
//
//  Created by Ata Namvari on 2022-05-10.
//

import Foundation
import PDFKit
import SwiftUI

public struct PDFPreview<Content>: View where Content : Drawable {
    var content: Content

    public init(content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        let data = PDFCreator(title: "Title", content: content).createData()
        return PDFKitView(data: data)
    }
}

public struct PDFKitView: View {
    var data: Data

    public var body: some View {
        PDFKitRepresentedView(data)
    }
}

public struct PDFKitRepresentedView: UIViewRepresentable {
    let data: Data

    public init(_ data: Data) {
        self.data = data
    }

    public func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {

    }
}
