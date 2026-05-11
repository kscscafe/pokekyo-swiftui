//
//  ContentView.swift
//  PokekyoSwiftUI
//
//  Created by 杉崎康隆 on 2026/05/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationDestination(for: SutraLanguage.self) { language in
                    SutraSelectionView(language: language)
                }
                .navigationDestination(for: Sutra.self) { sutra in
                    ReadingView(sutra: sutra)
                }
        }
    }
}

#Preview {
    ContentView()
}
