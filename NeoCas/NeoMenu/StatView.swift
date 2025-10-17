import SwiftUI

struct GameStatistic: Identifiable {
    var id = UUID().uuidString
    var name: String
    var gamesPlayed: Int
    var gamesWon: Int
    var winRate: Double
    var titalWininngs: Int
}

struct StatView: View {
    var statsmodel: [StatsModel] {
        [
            StatsModel(image: "stat1", title: "Games Played", value: NumberFormatter.localizedString(from: NSNumber(value: gameStatistic.reduce(0, { $0 + $1.gamesPlayed })), number: .decimal), color: Color(red: 0/255, green: 212/255, blue: 242/255)),
            StatsModel(image: "stat2", title: "Total Winnings", value: NumberFormatter.localizedString(from: NSNumber(value: gameStatistic.reduce(0, { $0 + $1.titalWininngs })), number: .decimal), color: Color(red: 4/255, green: 223/255, blue: 114/255)),
            StatsModel(image: "stat3", title: "Win Rate", value: String(format: "%.1f%%", gameStatistic.map { $0.winRate }.reduce(0, +) / Double(gameStatistic.count)), color: Color(red: 193/255, green: 122/255, blue: 255/255)),
            StatsModel(image: "stat4", title: "Current Streak", value: "\(stats.totalWinStreakNonReset)", color: Color(red: 255/255, green: 138/255, blue: 0/255))
        ]
    }
    
    @ObservedObject private var stats = GameStatsManager.shared
    @StateObject private var viewModel = StatsViewModel()
    var gameStatistic: [GameStatistic] {
        let gameNames = ["Neon Rush: Fruit 2080", "Elemental Spin", "Vegas Lux", "Steam of Fortune", "Lucky Scratch", "Thunder Strike", "Neon Bingo Party"]
        
        return gameNames.map { name in
            let key = name.lowercased().replacingOccurrences(of: " ", with: "")
            let played = stats.getGamesPlayed(for: key)
            let won = stats.getGamesWon(for: key)
            let money = stats.getMoneyWon(for: key)
            let winRate = stats.winRate(for: key) * 100
            return GameStatistic(name: name, gamesPlayed: played, gamesWon: won, winRate: winRate, titalWininngs: money)
        }
    }
    
    let grid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                       ForEach(viewModel.statsmodel, id: \.id) { item in
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                                      Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(red: 14/255, green: 101/255, blue: 127/255))
                                .overlay {
                                    VStack(spacing: 7) {
                                        Image(item.image)
                                            .resizable()
                                            .frame(width: 40, height: 36)
                                        
                                        Text(item.title)
                                            .FontMedium(size: 14, color: Color(red: 182/255, green: 209/255, blue: 221/255))
                                        
                                        Text(item.value)
                                            .FontBold(size: 20, color: item.color)
                                    }
                                }
                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 10, x: -5, y: 10)
                        }
                        .frame(width: UIScreen.main.bounds.width > 600 ? 300 : 171, height: UIScreen.main.bounds.width > 600 ? 220 : 171)
                }
            }
            .padding(.top)
            
            Rectangle()
                .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                              Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color(red: 14/255, green: 101/255, blue: 127/255))
                        .overlay {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Game Statistics")
                                    .FontRegular(size: 16)
                                    .overlay(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 0/255, green: 255/255, blue: 255/255),
                                                Color(red: 0/255, green: 128/255, blue: 255/255),
                                                Color(red: 255/255, green: 1/255, blue: 255/255),
                                                Color(red: 0/255, green: 255/255, blue: 129/255)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .mask(
                                            Text("Game Statistics")
                                                .FontRegular(size: 16)
                                        )
                                    )
                                
                                ForEach(viewModel.gameStatistic, id: \.id) { item in
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                                                      Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 0)
                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.45), lineWidth: 0.5)
                                                .overlay {
                                                    VStack(alignment: .leading, spacing: 22) {
                                                        Text(item.name)
                                                            .FontMedium(size: 16)
                                                        
                                                        VStack(alignment: .leading, spacing: 13) {
                                                            HStack {
                                                                Text("Games Played")
                                                                    .FontMedium(size: 14)
                                                                
                                                                Spacer()
                                                                
                                                                Text("\(item.gamesPlayed)")
                                                                    .FontRegular(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                            }
                                                            
                                                            HStack {
                                                                Text("Games Won")
                                                                    .FontMedium(size: 14)
                                                                
                                                                Spacer()
                                                                
                                                                Text("\(item.gamesWon)")
                                                                    .FontRegular(size: 14, color: Color(red: 4/255, green: 223/255, blue: 114/255))
                                                            }
                                                            
                                                            HStack {
                                                                Text("Win Rate")
                                                                    .FontMedium(size: 14)
                                                                
                                                                Spacer()
                                                                
                                                                Text(String(format: "%.2f%%", item.winRate))
                                                                    .FontRegular(size: 14, color: Color(red: 194/255, green: 122/255, blue: 255/255))
                                                            }
                                                            
                                                            HStack {
                                                                Text("Total Winnings")
                                                                    .FontMedium(size: 14)
                                                                
                                                                Spacer()
                                                                
                                                                Text("\(item.titalWininngs)")
                                                                    .FontRegular(size: 14, color: Color(red: 253/255, green: 199/255, blue: 2/255))
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal)
                                                }
                                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 10, x: -5, y: 10)
                                        }
                                        .frame(height: 174)
                                }
                            }
                            .padding(.horizontal)
                        }
                }
                .frame(height: 1371)
                .padding(.horizontal, 5)
                .padding(.top, 8)
        }
        .onAppear {
            viewModel.update()
        }
    }
}

#Preview {
    StatView()
}

import SwiftUI

class StatsViewModel: ObservableObject {
    @Published var gameStatistic: [GameStatistic] = []
    private var stats = GameStatsManager.shared

    private let gameNames = ["Neon Rush: Fruit 2080", "Elemental Spin", "Vegas Lux", "Steam of Fortune", "Lucky Scratch", "Thunder Strike", "Neon Bingo Party"]

    func update() {
        gameStatistic = gameNames.map { name in
            let key = name
            let played = stats.getGamesPlayed(for: key)
            let won = stats.getGamesWon(for: key)
            let money = stats.getMoneyWon(for: key)
            let winRate = stats.winRate(for: key) * 100
            return GameStatistic(name: name, gamesPlayed: played, gamesWon: won, winRate: winRate, titalWininngs: money)
        }
    }

    var statsmodel: [StatsModel] {
        [
            StatsModel(
                image: "stat1",
                title: "Games Played",
                value: NumberFormatter.localizedString(from: NSNumber(value: gameStatistic.reduce(0, { $0 + $1.gamesPlayed })), number: .decimal),
                color: Color(red: 0/255, green: 212/255, blue: 242/255)
            ),
            StatsModel(
                image: "stat2",
                title: "Total Winnings",
                value: NumberFormatter.localizedString(from: NSNumber(value: gameStatistic.reduce(0, { $0 + $1.titalWininngs })), number: .decimal),
                color: Color(red: 4/255, green: 223/255, blue: 114/255)
            ),
            StatsModel(
                image: "stat3",
                title: "Win Rate",
                value: String(format: "%.1f%%", gameStatistic.map { $0.winRate }.reduce(0, +) / Double(gameStatistic.count)),
                color: Color(red: 193/255, green: 122/255, blue: 255/255)
            ),
            StatsModel(
                image: "stat4",
                title: "Current Streak",
                value: "\(stats.totalWinStreakNonReset)",
                color: Color(red: 255/255, green: 138/255, blue: 0/255)
            )
        ]
    }
}
