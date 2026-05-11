import SwiftUI

struct SutraSelectionView: View {
    let language: SutraLanguage

    var body: some View {
        Group {
            if language.sutras.isEmpty {
                ContentUnavailableView(
                    "準備中",
                    systemImage: "hourglass",
                    description: Text("\(language.displayName) のお経はまだ収録されていません")
                )
            } else {
                List(language.sutras) { sutra in
                    NavigationLink(value: sutra) {
                        Text(sutra.title)
                    }
                }
            }
        }
        .navigationTitle("お経を選ぶ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("日本語版") {
    NavigationStack {
        SutraSelectionView(language: .japanese)
            .navigationDestination(for: Sutra.self) { sutra in
                ReadingView(sutra: sutra)
            }
    }
}

#Preview("English") {
    NavigationStack {
        SutraSelectionView(language: .english)
    }
}
