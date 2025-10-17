import SwiftUI

class NeoMainViewModel: ObservableObject {
    let contact = NeoMainModel()
    @ObservedObject private var stats = GameStatsManager.shared
    var coins: Int { stats.coins }
}
