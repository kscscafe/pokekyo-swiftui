# PokekyoSwiftUI — 開発メモ

## プロジェクト概要

旧 Pokekyou（お経アプリ）を SwiftUI でフルリライトするプロジェクト。  
Bundle ID: `jp.co.kscscafe.PokekyoSwiftUI`  
iOS 26.2 以降 / Swift 6 / Xcode 26.3

---

## ファイル構成

```
PokekyoSwiftUI/
├── PokekyoSwiftUIApp.swift       # @main エントリ → ContentView
├── ContentView.swift              # NavigationStack の根 + navigationDestination 定義
├── Models/
│   ├── Sutra.swift                # Sutra 構造体・SutraLanguage enum・経典データ
│   └── AudioPlayerModel.swift     # @Observable AVAudioPlayer ラッパー
├── Views/
│   ├── HomeView.swift             # 表紙画面（hyoushi_title + 言語ボタン + Version）
│   ├── SutraSelectionView.swift   # お経選択（4列グリッド・短冊カード）
│   ├── ReadingView.swift          # 読経画面（PDF表示 + 音声再生バー）
│   └── PDFKitView.swift           # UIViewRepresentable PDFKit ラッパー
└── Resources/
    ├── PDF/500_05jigage.pdf
    └── Audio/妙法蓮華経如来寿量品第十六（自我偈）.m4a
```

---

## 画面構成と遷移

```
HomeView
  └─ 日本語版へ ──→ SutraSelectionView(language: .japanese)
                        └─ 自我偈 ──→ ReadingView(sutra: .jigage)
  └─ English Edition（disabled・リソース未整備）
```

- `NavigationStack` は `ContentView` に集約。`navigationDestination(for: SutraLanguage.self)` と `navigationDestination(for: Sutra.self)` を両方ここで宣言。
- `HomeView` では `.toolbar(.hidden, for: .navigationBar)` でナビゲーションバーを非表示。
- `ReadingView` も同様に非表示。`×` ボタンで `dismiss()` する。

---

## データモデル

### Sutra

| フィールド | 用途 |
|---|---|
| `id` | 識別子 |
| `title` | フル書名（読経画面のナビタイトル等で使用想定） |
| `shortTitle` | 短冊カード表示用（縦書き） |
| `reading` | ふりがな（短冊カードに小字で付記） |
| `pdfResource` | Bundle 内 PDF ファイル名（拡張子なし） |
| `audioResource` | Bundle 内音声ファイル名（拡張子なし） |
| `audioExt` | 音声拡張子（`"m4a"` 等） |

新しいお経を追加するときは `Sutra.swift` の `static let japanese: [Sutra]` に追記するだけでグリッドに自動反映される。

---

## 収録経典（現状）

| id | 書名 | PDF | 音声 |
|---|---|---|---|
| `jigage` | 妙法蓮華経 如来寿量品 第十六（自我偈） | `500_05jigage.pdf` | `妙法蓮華経如来寿量品第十六（自我偈）.m4a` |

---

## デザイン方針

参考アプリ：**お経のアプリ 日蓮宗朝夕のおつとめ**（App Store ID: 1589241305）

- **Home**: 濃紺背景 `(0.08, 0.05, 0.18)` / 中央に短冊形白カード（二重黒枠）/ 縦書き書名画像 `hyoushi_title` / 灰色ボタン 2 つ / Version 表示
- **選択**: 白背景 / 4列 `LazyVGrid` / 短冊カード（白地・影・黒丸●・縦書き経名・ふりがな）
- **読経**: ヘッダーに `×`（dismiss）と `音声選択`（殻）/ PDF 全画面 / 下部に `▶ 00:00 ─── 06:30`

---

## 今後の予定（未実装）

- [ ] 英語版 PDF / 音声リソース追加 → `Sutra.english` に追記 → English Edition 有効化
- [ ] 音声選択機能（読経速度・複数音声切替）
- [ ] お経の追加（方便品・観音経・般若心経 等）
- [ ] タイトル画像の最終版差し替え（`hyoushi_title` は暫定版かもしれない場合）

---

## コミット履歴（このセッションの作業）

| hash | 内容 |
|---|---|
| `9373236` | HomeView: 言語選択ボタンを小さく調整 |
| `63ecf57` | HomeView: 仮表紙テキストを hyoushi_title 画像に差し替え |
| `87b8cc0` | 参考アプリのレイアウトに合わせて UI を刷新 |
| `98686b1` | ホーム → お経選択 → 読経 の導線を実装 |
| `8ff4366` | Phase 1: 自我偈の縦串を実装 |
| `036a7d4` | SwiftUI プロジェクト雛形を追加 |
