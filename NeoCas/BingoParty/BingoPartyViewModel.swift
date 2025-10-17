import SwiftUI

class BingoPartyViewModel: ObservableObject {
    @Published var coin = GameStatsManager.shared.coins
    @Published var bet = 10

    @Published var userSelectedNumber: Int? = nil    
    @Published var selectedNumber: Int? = nil        
    @Published var finalNumber: Int? = nil           

    @Published var isAnimating = false
    @Published var showResultImage = false
    @Published var showAlert = false
    @Published var numbers: [Int] = []

    @Published var guessHistory: [Int] = []
    private let guessHistoryKey = "guessHistory"

    init() {
        generateRandomNumbers()
        loadGuessHistory()
    }

    func loadGuessHistory() {
        guessHistory = UserDefaults.standard.array(forKey: guessHistoryKey) as? [Int] ?? []
    }

    func saveGuess(_ guess: Int) {
        guessHistory.append(guess)
        if guessHistory.count > 3 {
            guessHistory.removeFirst(guessHistory.count - 3)
        }
        UserDefaults.standard.set(guessHistory, forKey: guessHistoryKey)
    }

    func generateRandomNumbers() {
        var set = Set<Int>()
        while set.count < 25 {
            set.insert(Int.random(in: 1...50))
        }
        numbers = Array(set)
    }

    func startAnimation() {
        guard let userNumber = userSelectedNumber else {
            showAlert = true
            return
        }
        saveGuess(userNumber)
        isAnimating = true
        showResultImage = false
        let _  = GameStatsManager.shared.spendCoins(bet)
        coin = GameStatsManager.shared.coins

        var currentHighlight = 0
        var stepsDone = 0
        let totalSteps = Int.random(in: 20...40)

        func animateStep() {
            if stepsDone >= totalSteps {
                isAnimating = false
                showResultImage = true
                finalNumber = numbers[currentHighlight]
                finishGame()
                return
            }

            currentHighlight = (currentHighlight + 1) % numbers.count
            selectedNumber = numbers[currentHighlight]
            stepsDone += 1

            let progress = Double(stepsDone) / Double(totalSteps)
            let delay = 0.05 + 0.3 * progress * progress 

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                animateStep()
            }
        }

        animateStep()
    }

    func finishGame() {
        guard let finalNum = finalNumber, let userNum = userSelectedNumber else { return }
        if finalNum == userNum {
            let _  = GameStatsManager.shared.addCoins(bet * 2)
            coin = GameStatsManager.shared.coins
            let gameKey = "Neon Bingo Party"
            GameStatsManager.shared.recordGamePlayed(game: gameKey)
            GameStatsManager.shared.recordGameWon(game: gameKey, winAmount: (bet * 2), multiplier: 2)
        } else {
            let gameKey = "Neon Bingo Party"
            GameStatsManager.shared.recordGamePlayed(game: gameKey)
        }
    }
}
