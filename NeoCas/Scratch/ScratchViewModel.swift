import SwiftUI

class ScratchViewModel: ObservableObject {
    @Published var openedSymbols: [(index: Int, symbol: Symbol)] = []
    @Published var isGameActive: Bool = false
    @Published var coin = GameStatsManager.shared.coins
    @Published var bet = 10
    @Published var winningIndexes: [Int] = []

    let maxOpen = 5
    let symbolArray = [
        Symbol(image: "scratchB1", value: "100"),
        Symbol(image: "scratchB2", value: "50"),
        Symbol(image: "scratchB3", value: "10"),
        Symbol(image: "scratchB4", value: "5"),
        Symbol(image: "scratchB5", value: "3"),
        Symbol(image: "scratchB6", value: "2")
    ]
    
    func openCell(at index: Int) {
        guard isGameActive else { return }
        guard openedSymbols.count < maxOpen else { return }
        guard !openedSymbols.contains(where: { $0.index == index }) else { return }
        
        let randomSymbol = symbolArray.randomElement()!
        openedSymbols.append((index: index, symbol: randomSymbol))
        
        if openedSymbols.count == maxOpen {
            checkWin()
            isGameActive = false
        }
    }
    
    func checkWin() {
        let symbolCounts = Dictionary(grouping: openedSymbols, by: { $0.symbol.image })
            .mapValues { $0.count }

        if let (symbol, _) = symbolCounts.first(where: { $0.value >= 3 }),
           let winningSymbol = symbolArray.first(where: { $0.image == symbol }),
           let multiplier = Int(winningSymbol.value) {

            winningIndexes = openedSymbols
                .filter { $0.symbol.image == symbol }
                .map { $0.index }

            let winnings = bet * multiplier
            let _  = GameStatsManager.shared.addCoins(winnings)
            coin = GameStatsManager.shared.coins

            GameStatsManager.shared.recordGamePlayed(game: "Lucky Scratch")
            GameStatsManager.shared.recordGameWon(
                game: "Lucky Scratch",
                winAmount: winnings,
                multiplier: multiplier
            )
        } else {
            winningIndexes = []
            GameStatsManager.shared.recordGamePlayed(game: "Lucky Scratch")
        }
    }

    
    func startGame() {
        let _  = GameStatsManager.shared.spendCoins(bet)
        coin = GameStatsManager.shared.coins
        openedSymbols = []
        isGameActive = true
    }
}
