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
                    .frame(maxWidth: 220)
                versionLabel
                    .padding(.top, 20)
                    .padding(.bottom, 28)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var coverCard: some View {
        Image("hyoushi_title")
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 420)
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
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
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
