import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(red: 0.10, green: 0.13, blue: 0.30)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                titlePlaceholder
                Spacer()
                languageButtons
                    .padding(.horizontal, 32)
                versionLabel
                    .padding(.top, 16)
                    .padding(.bottom, 24)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // タイトル画像が用意でき次第、Image アセットに差し替える想定の仮表紙。
    private var titlePlaceholder: some View {
        VStack(spacing: 12) {
            Text("妙法蓮華経")
                .font(.system(size: 44, weight: .semibold, design: .serif))
            Text("ポケ経")
                .font(.system(size: 22, weight: .light, design: .serif))
                .tracking(8)
        }
        .foregroundStyle(.white)
    }

    private var languageButtons: some View {
        VStack(spacing: 12) {
            NavigationLink(value: SutraLanguage.japanese) {
                LanguageButtonLabel(text: "日本語版", isEnabled: true)
            }
            Button {} label: {
                LanguageButtonLabel(text: "English", isEnabled: false)
            }
            .buttonStyle(.plain)
            .disabled(true)
        }
    }

    private var versionLabel: some View {
        Text("Version \(Self.versionString)")
            .font(.footnote)
            .foregroundStyle(.white.opacity(0.6))
    }

    private static var versionString: String {
        let info = Bundle.main.infoDictionary
        let marketing = info?["CFBundleShortVersionString"] as? String ?? "—"
        let build = info?["CFBundleVersion"] as? String ?? "—"
        return "\(marketing) (\(build))"
    }
}

private struct LanguageButtonLabel: View {
    let text: String
    let isEnabled: Bool

    var body: some View {
        Text(text)
            .font(.title3.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isEnabled ? Color.white : Color.white.opacity(0.25))
            .foregroundStyle(isEnabled ? Color.black : Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
