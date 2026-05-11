import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(red: 0.08, green: 0.05, blue: 0.18)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                // タイトル画像が用意でき次第 Image("AppTitle") に差し替える想定の仮表紙
                coverCard
                Spacer()
                languageButtons
                    .padding(.horizontal, 48)
                versionLabel
                    .padding(.top, 20)
                    .padding(.bottom, 28)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var coverCard: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                Spacer().frame(height: 4)
                verticalText("妙法蓮華経", fontSize: 40, weight: .bold)
                Spacer()
            }
            // Inner thin border
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .padding(8)
        }
        .frame(width: 160, height: 400)
        .overlay(Rectangle().stroke(Color.black, lineWidth: 5))
    }

    private func verticalText(_ string: String, fontSize: CGFloat, weight: Font.Weight) -> some View {
        Text(string.map(String.init).joined(separator: "\n"))
            .font(.system(size: fontSize, weight: weight, design: .serif))
            .multilineTextAlignment(.center)
            .lineSpacing(4)
    }

    private var languageButtons: some View {
        VStack(spacing: 10) {
            NavigationLink(value: SutraLanguage.japanese) {
                CoverButtonLabel(text: "日本語版へ", active: true)
            }
            Button {} label: {
                CoverButtonLabel(text: "English Edition", active: false)
            }
            .buttonStyle(.plain)
            .disabled(true)
        }
    }

    private var versionLabel: some View {
        Text("Version \(Self.versionString)")
            .font(.footnote)
            .foregroundStyle(.white.opacity(0.55))
    }

    private static var versionString: String {
        let info = Bundle.main.infoDictionary
        let v = info?["CFBundleShortVersionString"] as? String ?? "—"
        let b = info?["CFBundleVersion"] as? String ?? "—"
        return "\(v) (\(b))"
    }
}

private struct CoverButtonLabel: View {
    let text: String
    let active: Bool

    var body: some View {
        Text(text)
            .font(.body)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 11)
            .background(Color(.systemGray4))
            .foregroundStyle(active ? Color.primary : Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
