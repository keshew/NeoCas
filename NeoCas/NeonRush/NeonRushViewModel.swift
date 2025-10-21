import SwiftUI

class NeonRushViewModel: ObservableObject {
    let contact = NeonRushModel()
    @Published var slots: [[String]] = []
    @Published var coin =  GameStatsManager.shared.coins
    @Published var bet = 10
    let allFruits = ["rush1", "rush2","rush3", "rush4","rush5", "rush6"]
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var isWin = false
    @Published var win = 0
    var spinningTimer: Timer?
    @ObservedObject private var soundManager = SoundManager.shared
    init() {
        resetSlots()
    }
    
    let symbolArray = [
        Symbol(image: "rush1", value: "100"),
        Symbol(image: "rush2", value: "50"),
        Symbol(image: "rush3", value: "10"),
        Symbol(image: "rush4", value: "5"),
        Symbol(image: "rush5", value: "3"),
        Symbol(image: "rush6", value: "2")
    ]
    
    func resetSlots() {
        slots = (0..<3).map { _ in
            (0..<5).map { _ in
                allFruits.randomElement()!
            }
        }
    }
    
    func spin() {
        soundManager.playSlot3()
        let _  = GameStatsManager.shared.spendCoins(bet)
        coin = GameStatsManager.shared.coins
        isSpinning = true
        spinningTimer?.invalidate()
        winningPositions.removeAll()
        win = 0
        
        let columns = 5
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<3 {
                        self.slots[row][col] = self.allFruits.randomElement()!
                    }
                    spinCount += 1
                    if spinCount > 12 + col * 4 {
                        timer.invalidate()
                        if col == columns - 1 {
                            self.isSpinning = false
                            self.checkWin()
                            self.soundManager.stopAllSoundEffects()
                        }
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }
    
    
    func checkWin() {
        winningPositions = []
        var totalWin = 0
        var maxMultiplier = 0
        let minCounts = [
            "rush1": 5,
            "rush2": 5,
            "rush3": 5,
            "rush4": 5,
            "rush5": 5,
            "rush6": 5
        ]
        let multipliers = [
            "rush1": 100,
            "rush2": 50,
            "rush3": 10,
            "rush4": 5,
            "rush5": 3,
            "rush6": 2
        ]

        for row in 0..<3 {
            let rowContent = slots[row]
            var currentSymbol = rowContent[0]
            var count = 1
            for col in 1..<rowContent.count {
                if rowContent[col] == currentSymbol {
                    count += 1
                } else {
                    if let minCount = minCounts[currentSymbol], count >= minCount {
                        totalWin += multipliers[currentSymbol] ?? 0
                        if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                            maxMultiplier = multiplierValue
                        }
                        let startCol = col - count
                        for c in startCol..<col {
                            winningPositions.append((row: row, col: c))
                        }
                    }
                    currentSymbol = rowContent[col]
                    count = 1
                }
            }
            if let minCount = minCounts[currentSymbol], count >= minCount {
                totalWin += multipliers[currentSymbol] ?? 0
                if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                    maxMultiplier = multiplierValue
                }
                let startCol = rowContent.count - count
                for c in startCol..<rowContent.count {
                    winningPositions.append((row: row, col: c))
                }
            }
        }

        if totalWin != 0 {
            let _  = GameStatsManager.shared.addCoins(totalWin + bet)
            coin = GameStatsManager.shared.coins
            win = (totalWin + bet)
            isWin = true
            let gameKey = "Neon Rush: Fruit 2080"
            GameStatsManager.shared.recordGamePlayed(game: gameKey)
            GameStatsManager.shared.recordGameWon(game: gameKey, winAmount: (totalWin + bet), multiplier: maxMultiplier)
        } else {
            let gameKey = "Neon Rush: Fruit 2080"
            GameStatsManager.shared.recordGamePlayed(game: gameKey)
        }
    }
}
