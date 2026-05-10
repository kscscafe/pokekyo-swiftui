import SwiftUI
import PDFKit
import UIKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let view = SutraPDFView()
        view.document = PDFDocument(url: url)
        view.displayMode = .singlePage
        view.displayDirection = .horizontal
        view.autoScales = false
        view.backgroundColor = .white
        view.pageShadowsEnabled = false
        view.displaysPageBreaks = false
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

final class SutraPDFView: PDFView {
    private var hasAppliedInitialLayout = false

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !hasAppliedInitialLayout,
              bounds.width > 0, bounds.height > 0,
              let page = currentPage else { return }

        let pageBounds = page.bounds(for: displayBox)
        guard pageBounds.height > 0 else { return }

        scaleFactor = bounds.height / pageBounds.height

        if let scrollView = subviews.compactMap({ $0 as? UIScrollView }).first {
            let maxX = max(0, scrollView.contentSize.width - scrollView.bounds.width)
            scrollView.setContentOffset(CGPoint(x: maxX, y: 0), animated: false)
        }

        hasAppliedInitialLayout = true
    }
}
