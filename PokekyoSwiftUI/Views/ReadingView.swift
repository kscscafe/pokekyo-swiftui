import SwiftUI

struct ReadingView: View {
    let sutra: Sutra
    @State private var audio = AudioPlayerModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            customHeader
            Divider()
            pdfArea
            Divider()
            audioBar
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            audio.load(resource: sutra.audioResource, ext: sutra.audioExt)
        }
    }

    private var customHeader: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 13, weight: .semibold))
                    .frame(width: 34, height: 34)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
            .buttonStyle(.plain)
            Spacer()
            Button {} label: {
                Text("音声選択")
                    .font(.system(size: 13))
                    .padding(.horizontal, 12)
                    .frame(height: 34)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
    }

    @ViewBuilder
    private var pdfArea: some View {
        if let url = Bundle.main.url(forResource: sutra.pdfResource, withExtension: "pdf") {
            PDFKitView(url: url)
        } else {
            ContentUnavailableView(
                "PDF が見つかりません",
                systemImage: "doc.questionmark",
                description: Text("\(sutra.pdfResource).pdf がバンドルに含まれていません")
            )
        }
    }

    private var audioBar: some View {
        HStack(spacing: 10) {
            Button {
                audio.togglePlay()
            } label: {
                Image(systemName: audio.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 22))
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)

            Text(timeString(audio.currentTime))
                .monospacedDigit()
                .font(.footnote)
                .foregroundStyle(.secondary)

            Slider(
                value: Binding(
                    get: { audio.currentTime },
                    set: { audio.seek(to: $0) }
                ),
                in: 0...max(audio.duration, 1)
            )

            Text(timeString(audio.duration))
                .monospacedDigit()
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }

    private func timeString(_ time: TimeInterval) -> String {
        let total = Int(time.rounded())
        return String(format: "%02d:%02d", total / 60, total % 60)
    }
}

#Preview {
    NavigationStack {
        ReadingView(sutra: .jigage)
    }
}
