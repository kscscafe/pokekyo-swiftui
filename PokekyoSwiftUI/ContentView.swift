//
//  ContentView.swift
//  PokekyoSwiftUI
//
//  Created by 杉崎康隆 on 2026/05/10.
//

import SwiftUI

struct ContentView: View {
    @State private var audio = AudioPlayerModel()

    private let pdfResource = "500_05jigage"
    private let audioResource = "妙法蓮華経如来寿量品第十六（自我偈）"
    private let audioExt = "m4a"

    var body: some View {
        VStack(spacing: 0) {
            pdfArea
            controlBar
        }
        .onAppear {
            audio.load(resource: audioResource, ext: audioExt)
        }
    }

    @ViewBuilder
    private var pdfArea: some View {
        if let url = Bundle.main.url(forResource: pdfResource, withExtension: "pdf") {
            PDFKitView(url: url)
        } else {
            ContentUnavailableView(
                "PDF が見つかりません",
                systemImage: "doc.questionmark",
                description: Text("\(pdfResource).pdf がバンドルに含まれていません")
            )
        }
    }

    private var controlBar: some View {
        VStack(spacing: 8) {
            Slider(
                value: Binding(
                    get: { audio.currentTime },
                    set: { audio.seek(to: $0) }
                ),
                in: 0...max(audio.duration, 1)
            )

            HStack {
                Text(timeString(audio.currentTime))
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
                Spacer()
                Button {
                    audio.togglePlay()
                } label: {
                    Image(systemName: audio.isPlaying ? "stop.fill" : "play.fill")
                        .font(.system(size: 40))
                }
                Spacer()
                Text(timeString(audio.duration))
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.regularMaterial)
    }

    private func timeString(_ time: TimeInterval) -> String {
        let total = Int(time.rounded())
        return String(format: "%02d:%02d", total / 60, total % 60)
    }
}

#Preview {
    ContentView()
}
