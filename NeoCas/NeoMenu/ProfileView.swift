import SwiftUI

struct ProfileView: View {
    @ObservedObject private var stats = GameStatsManager.shared
    
    private var currentLevel: Int { max(stats.userLevel, 1) }
    private var currentXP: Int { stats.experiencePoints }
    private var xpForNextLevel: Int { 1000 }
    private var coins: Int { stats.coins }
    private var progressWidth: CGFloat {
        CGFloat(currentXP) / CGFloat(xpForNextLevel) * 220
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Rectangle()
                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                    .overlay {
                        RoundedRectangle(cornerRadius: 41)
                            .stroke(LinearGradient(colors: [Color(red: 11/255, green: 10/255, blue: 10/255),
                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                            .overlay {
                                VStack(spacing: 30) {
                                    HStack(spacing: 40) {
                                        ZStack(alignment: .bottomTrailing) {
                                            Rectangle()
                                                .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255),
                                                                              Color(red: 0/255, green: 128/255, blue: 255/255),
                                                                              Color(red: 255/255, green: 1/255, blue: 255/255),
                                                                              Color(red: 128/255, green: 0/255, blue: 255/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .overlay {
                                                    ZStack {
                                                        Circle()
                                                            .stroke(LinearGradient(colors: [Color(red: 11/255, green: 10/255, blue: 10/255),
                                                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                            .frame(width: 87, height: 87)
                                                        
                                                        Image(.ava)
                                                            .resizable()
                                                            .frame(width: 85, height: 85)
                                                            .clipShape(Circle())
                                                    }
                                                }
                                                .frame(width: 96, height: 96)
                                                .cornerRadius(20)
                                            
                                            ZStack {
                                                Circle()
                                                    .stroke(LinearGradient(colors: [Color(red: 11/255, green: 10/255, blue: 10/255),
                                                                                    Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                    .frame(width: 36, height: 36)
                                                
                                                Circle()
                                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                    .frame(width: 35, height: 35)
                                                
                                                Image(.crown)
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                            }
                                            .offset(x: 20, y: 15)
                                        }
                                        
                                        
                                        
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text("PLAYER NAME")
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
                                                        Text("PLAYER NAME")
                                                            .FontRegular(size: 16)
                                                    )
                                                )
                                            
                                            HStack(spacing: 15) {
                                                Text("Level \(currentLevel)")
                                                    .FontMedium(size: 16, color: .white)
                                                
                                                Text("\(currentXP)/\(xpForNextLevel) XP")
                                                    .FontMedium(size: 14, color: Color(red: 180/255, green: 199/255, blue: 211/255))
                                            }
                                            
                                            ZStack(alignment: .leading) {
                                                Rectangle()
                                                    .fill(Color(red: 37/255, green: 18/255, blue: 68/255))
                                                    .frame(width: 200, height: 8)
                                                    .cornerRadius(10)
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing))
                                                    .frame(width: progressWidth, height: 8)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                    
                                    HStack(spacing: 25) {
                                        VStack {
                                            Text("Total\nWinnings")
                                                .FontMedium(size: 14, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                .multilineTextAlignment(.center)
                                            
                                            Rectangle()
                                                .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 41)
                                                        .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 0.6)
                                                        .overlay {
                                                            Text("\(formattedTotalWinnings())")
                                                                .FontBold(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                        }
                                                }
                                                .frame(height: 34)
                                                .cornerRadius(20)
                                        }
                                        
                                        VStack {
                                            Text("Win\nRate")
                                                .FontMedium(size: 14, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                .multilineTextAlignment(.center)
                                            
                                            Rectangle()
                                                .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 41)
                                                        .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 0.6)
                                                        .overlay {
                                                            Text(formattedWinRate())
                                                                .FontBold(size: 14, color: Color(red: 4/255, green: 223/255, blue: 114/255))
                                                        }
                                                }
                                                .frame(height: 34)
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.horizontal, 35)
                            }
                    }
                    .frame(height: 254)
                    .cornerRadius(41)
                
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                                  Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color(red: 14/255, green: 101/255, blue: 127/255))
                            .overlay {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Recent Activity")
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
                                                Text("Recent Activity")
                                                    .FontRegular(size: 16)
                                            )
                                        )
                                    
                                    VStack(spacing: 20) {
                                        if stats.recentGames.isEmpty {
                                            ForEach(0..<4, id: \.self) { _ in
                                                EmptyGamePlaceholderView()
                                            }
                                        } else {
                                            let gamesToShow = Array(stats.recentGames.prefix(4))
                                            let emptyCount = 4 - gamesToShow.count

                                            ForEach(gamesToShow) { game in
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [
                                                        Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                                                        Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)
                                                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 0)
                                                            .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.45), lineWidth: 0.5)
                                                            .overlay(
                                                                VStack {
                                                                    HStack {
                                                                        VStack(alignment: .leading, spacing: 5) {
                                                                            Text(game.gameName)
                                                                                .FontMedium(size: 16, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                                            Text(formattedDate(game.date))
                                                                                .FontMedium(size: 14, color: Color(red: 168/255, green: 185/255, blue: 205/255))
                                                                        }
                                                                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 10, x: -5, y: 10)
                                                                        Spacer()
                                                                        Text(String(format: "%+.2f", Double(game.winAmount)))
                                                                            .FontMedium(size: 14, color: game.winAmount >= 0
                                                                                        ? Color(red: 4/255, green: 223/255, blue: 114/255)
                                                                                        : Color(red: 255/255, green: 100/255, blue: 103/255))
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            )
                                                    )
                                                    .frame(height: 70)
                                            }

                                            if emptyCount > 0 {
                                                ForEach(0..<emptyCount, id: \.self) { _ in
                                                    EmptyGamePlaceholderView()
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                    }
                    .frame(height: 406)
                    .padding(.horizontal, 5)
                    .padding(.top, 8)
            }
            .padding(.top)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    private func formattedTotalWinnings() -> String {
        let gameNames = ["Neon Rush: Fruit 2080", "Elemental Spin", "Vegas Lux", "Steam of Fortune", "Lucky Scratch", "Thunder Strike", "Neon Bingo Party"]
        let total = gameNames.reduce(0) { $0 + stats.getMoneyWon(for: $1) }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: total)) ?? "0"
    }
    
    private func formattedWinRate() -> String {
        let gameNames = ["Neon Rush: Fruit 2080", "Elemental Spin", "Vegas Lux", "Steam of Fortune", "Lucky Scratch", "Thunder Strike", "Neon Bingo Party"]
        let winRates = gameNames.map { stats.winRate(for: $0) }
        let avgWinRate = winRates.reduce(0, +) / Double(winRates.count)
        return String(format: "%.1f%%", avgWinRate * 100)
    }
    
}

#Preview {
    ProfileView()
}

struct EmptyGamePlaceholderView: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(colors: [
                Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.15),
                Color(red: 255/255, green: 1/255, blue: 255/255).opacity(0.05)
            ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.45), lineWidth: 0.5)
                    .overlay(
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("No history yet")
                                        .FontMedium(size: 16, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                    Text("-")
                                        .FontMedium(size: 14, color: Color(red: 168/255, green: 185/255, blue: 205/255))
                                }
                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 10, x: -5, y: 10)
                                Spacer()
                                Text("0.00")
                                    .FontMedium(size: 14, color: Color(red: 255/255, green: 100/255, blue: 103/255))
                            }
                        }
                        .padding(.horizontal)
                    )
            )
            .frame(height: 70)
    }
}
