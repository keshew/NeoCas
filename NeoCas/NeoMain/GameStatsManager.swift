import Foundation

struct GameHistoryEntry: Codable, Identifiable {
    let id: UUID
    let gameName: String
    let date: Date
    let winAmount: Int
    let multiplier: Int
}

class GameStatsManager: ObservableObject {
    static let shared = GameStatsManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static func gamesPlayedKey(for game: String) -> String { "\(game)_GamesPlayed" }
        static func gamesWonKey(for game: String) -> String { "\(game)_GamesWon" }
        static func moneyWonKey(for game: String) -> String { "\(game)_MoneyWon" }
        static func winStreakKey(for game: String) -> String { "\(game)_WinStreak" }
        
        static let totalWinStreak = "TotalWinStreak"
        static let achievementsGamesPlayed = "AchievementsGamesPlayed"
        static let achievementBigWin = "AchievementBigWin"
        static let totalWinStreakNonReset = "TotalWinStreakNonReset"
        static let userLevel = "UserLevel"
        static let experiencePoints = "ExperiencePoints"
        static let totalGamesWon = "TotalGamesWon"
        static let maxMultiplierAchieved = "MaxMultiplierAchieved"
        static let coins = "Coins"
    }
    
    private init() {
        self.userLevel = defaults.integer(forKey: Keys.userLevel)
        self.experiencePoints = defaults.integer(forKey: Keys.experiencePoints)
        loadRecentGames()
    }
    
    @Published var recentGames: [GameHistoryEntry] = []
    
    private let recentGamesKey = "RecentGamesHistory"
    
    private func saveRecentGames() {
        if let data = try? JSONEncoder().encode(recentGames) {
            defaults.set(data, forKey: recentGamesKey)
        }
    }
    
    private func loadRecentGames() {
        if let data = defaults.data(forKey: recentGamesKey),
           let decoded = try? JSONDecoder().decode([GameHistoryEntry].self, from: data) {
            recentGames = decoded
        }
    }
    
    
    // MARK: - Игры
    
    func getGamesPlayed(for game: String) -> Int {
        defaults.integer(forKey: Keys.gamesPlayedKey(for: game))
    }
    
    func setGamesPlayed(_ count: Int, for game: String) {
        defaults.set(count, forKey: Keys.gamesPlayedKey(for: game))
    }
    
    func incrementGamesPlayed(for game: String) {
        let current = getGamesPlayed(for: game)
        let newValue = current + 1
        addExperience()
        setGamesPlayed(newValue, for: game)
    }
    
    func getGamesWon(for game: String) -> Int {
        defaults.integer(forKey: Keys.gamesWonKey(for: game))
    }
    
    func setGamesWon(_ count: Int, for game: String) {
        defaults.set(count, forKey: Keys.gamesWonKey(for: game))
    }
    
    func incrementGamesWon(for game: String) {
        let newValue = getGamesWon(for: game) + 1
        setGamesWon(newValue, for: game)
    }
    
    func getMoneyWon(for game: String) -> Int {
        defaults.integer(forKey: Keys.moneyWonKey(for: game))
    }
    
    func addMoneyWon(_ amount: Int, for game: String) {
        let newValue = getMoneyWon(for: game) + amount
        defaults.set(newValue, forKey: Keys.moneyWonKey(for: game))
    }
    
    func getWinStreak(for game: String) -> Int {
        defaults.integer(forKey: Keys.winStreakKey(for: game))
    }
    
    func setWinStreak(_ streak: Int, for game: String) {
        defaults.set(streak, forKey: Keys.winStreakKey(for: game))
    }
    
    func resetWinStreak(for game: String) {
        setWinStreak(0, for: game)
    }
    
    func incrementWinStreak(for game: String) {
        let newValue = getWinStreak(for: game) + 1
        setWinStreak(newValue, for: game)
    }
    
    // MARK: - Общие ачивки и данные
    
    var totalGamesPlayed: Int {
        get { defaults.integer(forKey: Keys.achievementsGamesPlayed) }
        set { defaults.set(newValue, forKey: Keys.achievementsGamesPlayed) }
    }
    
    var bigWinAchieved: Bool {
        get { defaults.bool(forKey: Keys.achievementBigWin) }
        set { defaults.set(newValue, forKey: Keys.achievementBigWin) }
    }
    
    var totalWinStreakNonReset: Int {
        get { defaults.integer(forKey: Keys.totalWinStreakNonReset) }
        set { defaults.set(newValue, forKey: Keys.totalWinStreakNonReset) }
    }
    
    @Published private(set) var userLevel: Int {
        didSet {
            defaults.set(userLevel, forKey: Keys.userLevel)
        }
    }

    @Published private(set) var experiencePoints: Int {
        didSet {
            defaults.set(experiencePoints, forKey: Keys.experiencePoints)
        }
    }
    
    var totalGamesWon: Int {
        get { defaults.integer(forKey: Keys.totalGamesWon) }
        set { defaults.set(newValue, forKey: Keys.totalGamesWon) }
    }
    
    var maxMultiplierAchieved: Int {
        get { defaults.integer(forKey: Keys.maxMultiplierAchieved) }
        set { defaults.set(newValue, forKey: Keys.maxMultiplierAchieved) }
    }
    
    var coins: Int {
        get { defaults.integer(forKey: Keys.coins) }
        set { defaults.set(newValue, forKey: Keys.coins) }
    }
    
    // MARK: - Методы обновления ачивок и состояния
    
    func addExperience(points: Int = 100) {
        experiencePoints += points
        checkLevelUp()
    }
    
    private func checkLevelUp() {
        while experiencePoints >= 1000 {
            experiencePoints -= 1000
            userLevel += 1
        }
    }
    
    func addGameHistoryEntry(game: String, winAmount: Int, multiplier: Int) {
        let entry = GameHistoryEntry(id: UUID(), gameName: game, date: Date(), winAmount: winAmount, multiplier: multiplier)
        recentGames.insert(entry, at: 0)
        if recentGames.count > 20 {
            recentGames.removeLast()
        }
        saveRecentGames()
    }
    
    func recordGamePlayed(game: String) {
        incrementGamesPlayed(for: game)
        totalGamesPlayed += 1
        addGameHistoryEntry(game: game, winAmount: 0, multiplier: 0)
    }
    
    func recordGameWon(game: String, winAmount: Int, multiplier: Int) {
        incrementGamesWon(for: game)
        totalGamesWon += 1
        addMoneyWon(winAmount, for: game)
        incrementWinStreak(for: game)
        if getWinStreak(for: game) > totalWinStreakNonReset {
            totalWinStreakNonReset = getWinStreak(for: game)
        }
        if winAmount >= 100 {
            bigWinAchieved = true
        }
        if multiplier > maxMultiplierAchieved {
            maxMultiplierAchieved = multiplier
        }
        addExperience()
        addGameHistoryEntry(game: game, winAmount: winAmount, multiplier: multiplier)
    }
    
    func resetWinStreakForGame(game: String) {
        resetWinStreak(for: game)
    }
    
    func addCoins(_ amount: Int) {
        coins += amount
    }
    
    func spendCoins(_ amount: Int) -> Bool {
        guard coins >= amount else { return false }
        coins -= amount
        return true
    }
    
    func winRate(for game: String) -> Double {
        let played = getGamesPlayed(for: game)
        guard played > 0 else { return 0 }
        let won = getGamesWon(for: game)
        return Double(won) / Double(played)
    }
}
