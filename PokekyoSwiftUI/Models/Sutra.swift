import Foundation

struct Sutra: Identifiable, Hashable {
    let id: String
    let title: String
    let pdfResource: String
    let audioResource: String
    let audioExt: String
}

extension Sutra {
    static let jigage = Sutra(
        id: "jigage",
        title: "妙法蓮華経 如来寿量品 第十六（自我偈）",
        pdfResource: "500_05jigage",
        audioResource: "妙法蓮華経如来寿量品第十六（自我偈）",
        audioExt: "m4a"
    )

    static let japanese: [Sutra] = [.jigage]
    static let english: [Sutra] = []
}

enum SutraLanguage: Hashable {
    case japanese
    case english

    var displayName: String {
        switch self {
        case .japanese: "日本語版"
        case .english: "English"
        }
    }

    var sutras: [Sutra] {
        switch self {
        case .japanese: Sutra.japanese
        case .english: Sutra.english
        }
    }
}
