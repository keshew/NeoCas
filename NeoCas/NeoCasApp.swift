import SwiftUI

@main
struct NeoCasApp: App {
    init() {
        let stats = GameStatsManager.shared
        let key = "didAddInitialCoins"
        if !UserDefaults.standard.bool(forKey: key) {
            stats.addCoins(5000)
            UserDefaults.standard.set(true, forKey: key)
        }
    }

    var body: some Scene {
        WindowGroup {
            NeoMainView()
        }
    }
}
