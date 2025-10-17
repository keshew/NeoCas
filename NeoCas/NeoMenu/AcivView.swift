import SwiftUI

struct AcivView: View {
    @State private var achievements = [
        Achievement(image: "ach1", name: "First Win", desc: "Win your first game", color: Color(red: 153/255, green: 161/255, blue: 175/255), goal: 1),
        Achievement(image: "ach2", name: "High Roller", desc: "Bet over 100 in a single game", color: Color(red: 81/255, green: 162/255, blue: 255/255), goal: 1),
        Achievement(image: "ach3", name: "Lucky Streak", desc: "Win 10 games in a row", color: Color(red: 194/255, green: 122/255, blue: 255/255), goal: 10),
        Achievement(image: "ach4", name: "Quantum Master", desc: "Reach level 25", color: Color(red: 158/255, green: 127/255, blue: 18/255), goal: 1),
        Achievement(image: "ach5", name: "Mine Expert", desc: "Win 100 Mines games", color: Color(red: 127/255, green: 76/255, blue: 175/255), goal: 100),
        Achievement(image: "ach6", name: "Crash Survivor", desc: "Cash out at 50x multiplier", color: Color(red: 163/255, green: 121/255, blue: 23/255), goal: 1)
    ]
    @StateObject var state = GameStatsManager.shared
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                ForEach(achievements, id: \.id) { item in
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                                      Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.45), lineWidth: 0.5)
                                .overlay {
                                    HStack {
                                        Image(item.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 45)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            HStack {
                                                Text(item.name)
                                                    .FontBold(size: 16, color: item.color)
                                                
                                                if item.isAchieved {
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .frame(width: 72, height: 22)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.black.opacity(0.1), lineWidth: 3)
                                                                .overlay {
                                                                    Text("Unlocked")
                                                                        .FontMedium(size: 12)
                                                                }
                                                        }
                                                }
                                            }
                                            Text(item.desc)
                                                .FontMedium(size: 14, color: Color(red: 183/255, green: 207/255, blue: 219/255))
                                            
                                            HStack {
                                                Text("Progress")
                                                    .FontMedium(size: 12, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                Spacer()
                                                Text("\(min(item.currentValue, item.goal))/\(item.goal)")
                                                    .FontMedium(size: 12, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                            }
                                            
                                            ZStack(alignment: .leading) {
                                                Rectangle()
                                                    .fill(.black.opacity(0.2))
                                                    .frame(width: 278, height: 4)
                                                    .cornerRadius(10)
                                                
                                                Rectangle()
                                                    .fill(.black)
                                                    .frame(width: min(CGFloat(item.currentValue) / CGFloat(item.goal) * 278, 278), height: 4)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                        }
                        .frame(height: 114)
                }
            }
            .padding(.top)
        }
        .onAppear {
            updateAchievements(from: state)
        }
    }
    
    func updateAchievements(from stats: GameStatsManager) {
        for index in achievements.indices {
            switch achievements[index].name {
            case "First Win":
                // Проверка было ли хоть одно выигранное событие
                achievements[index].currentValue = stats.totalGamesWon
                achievements[index].isAchieved = stats.totalGamesWon >= achievements[index].goal
                
            case "High Roller":
                // Проверка был ли выигрыш с крупной ставкой (winAmount >= 100)
                achievements[index].currentValue = stats.bigWinAchieved ? 1 : 0
                achievements[index].isAchieved = stats.bigWinAchieved
                
            case "Lucky Streak":
                // Текущая серия выигрышей
                achievements[index].currentValue = stats.totalWinStreakNonReset
                achievements[index].isAchieved = stats.totalWinStreakNonReset >= achievements[index].goal
                
            case "Quantum Master":
                // Текущий уровень пользователя
                achievements[index].currentValue = stats.userLevel
                achievements[index].isAchieved = stats.userLevel >= 25
                
            case "Mine Expert":
                // Сколько выиграно игр по имени "Mine" - считайте по recentGames
                let mineWins = stats.recentGames.filter { $0.gameName.lowercased().contains("mine") && $0.winAmount > 0 }.count
                achievements[index].currentValue = mineWins
                achievements[index].isAchieved = mineWins >= achievements[index].goal
                
            case "Crash Survivor":
                // Максимальный мультиплеер
                achievements[index].currentValue = stats.maxMultiplierAchieved
                achievements[index].isAchieved = stats.maxMultiplierAchieved >= 50
                
            default:
                break
            }
        }
    }

}
#Preview {
    AcivView()
}
