import SwiftUI

struct SutraSelectionView: View {
    let language: SutraLanguage

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        Group {
            if language.sutras.isEmpty {
                ContentUnavailableView(
                    "準備中",
                    systemImage: "hourglass",
                    description: Text("\(language.displayName) のお経はまだ収録されていません")
                )
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(language.sutras) { sutra in
                            NavigationLink(value: sutra) {
                                SutraTanzakuCard(sutra: sutra)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(14)
                }
                .background(Color(.systemGroupedBackground))
            }
        }
        .navigationTitle("お経文を選択してください。")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SutraTanzakuCard: View {
    let sutra: Sutra

    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(spacing: 6) {
                Circle()
                    .fill(Color.black)
                    .frame(width: 5, height: 5)
                    .padding(.top, 8)
                HStack(alignment: .top, spacing: 2) {
                    Text(sutra.shortTitle.map(String.init).joined(separator: "\n"))
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .multilineTextAlignment(.center)
                    if let reading = sutra.reading {
                        Text(reading.map(String.init).joined(separator: "\n"))
                            .font(.system(size: 8))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 3)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 4)
        }
        .aspectRatio(0.44, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(color: .black.opacity(0.18), radius: 3, x: 1, y: 2)
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
