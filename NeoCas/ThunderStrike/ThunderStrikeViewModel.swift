import SwiftUI
import Combine

class ThunderStrikeViewModel: ObservableObject {
    @Published var coin = GameStatsManager.shared.coins
    @Published var bet = 10
    @Published var multiplier: Double = 1.0
    @Published var isPlaying = false
    @Published var hasCrashed = false
    @Published var hasWon = false
    @Published var multipliersLog: [Double] = []
    private var timer: Timer?
    private var crashMultiplier: Double = 0.0
    private let multipliersKey = "lastMultipliers"

    var lastFourMultipliers: [Double] {
        let logs = multipliersLog.suffix(4)
        let paddingCount = max(0, 4 - logs.count)
        return Array(logs) + Array(repeating: 0.0, count: paddingCount)
    }

    init() {
        loadMultipliers()
    }

    private func loadMultipliers() {
        let saved = UserDefaults.standard.array(forKey: multipliersKey) as? [Double] ?? []
        multipliersLog = saved
    }

    private func saveMultipliers() {
        UserDefaults.standard.set(multipliersLog, forKey: multipliersKey)
    }

    private func addMultiplierToLog(_ multiplier: Double) {
        multipliersLog.append(multiplier)
        if multipliersLog.count > 4 {
            multipliersLog.removeFirst(multipliersLog.count - 4)
        }
        saveMultipliers()
    }

    private func finishGame(win: Bool) {
        timer?.invalidate()
        timer = nil
        isPlaying = false
        if win {
            let winnings = Int(Double(bet) * multiplier)
            let _  = GameStatsManager.shared.addCoins(winnings)
            coin = GameStatsManager.shared.coins
            addMultiplierToLog(multiplier)
            GameStatsManager.shared.recordGamePlayed(game: "Thunder Strike")
            GameStatsManager.shared.recordGameWon(game: "Thunder Strike", winAmount: winnings, multiplier: Int(multiplier))
        } else {
            addMultiplierToLog(multiplier)
            GameStatsManager.shared.recordGamePlayed(game: "Thunder Strike")
        }
    }

    
    func startGame() {
        guard !isPlaying, bet > 0, bet <= coin else { return }
        isPlaying = true
        hasCrashed = false
        hasWon = false
        multiplier = 1.0
        let _  = GameStatsManager.shared.spendCoins(bet)
        coin = GameStatsManager.shared.coins
        crashMultiplier = Double.random(in: 1.5...5.0)
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.updateMultiplier()
        }
    }

    private func updateMultiplier() {
        guard isPlaying else { return }
        multiplier += 0.05
        if multiplier >= crashMultiplier {
            let randomResult = Bool.random()
            hasWon = randomResult
            hasCrashed = !randomResult
            finishGame(win: randomResult)
        }
    }

    func stopGame() {
        guard isPlaying, !hasCrashed else { return }
        hasWon = true
        finishGame(win: true)
    }
}
