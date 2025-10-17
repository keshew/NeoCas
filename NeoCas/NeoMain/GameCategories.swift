import SwiftUI

struct GameCategories: View {
    @State var selectedGame = "Neon Rush: Fruit 2080"
    let arraOfGames = ["Neon Rush: Fruit 2080", "Elemental Spin", "Vegas Lux", "Steam of Fortune", "Lucky Scratch", "Thunder Strike", "Neon Bingo Party"]
    @State var game1 = false
    @State var game2 = false
    @State var game3 = false
    @State var game4 = false
    @State var game5 = false
    @State var game6 = false
    @State var game7 = false
    @State var isProfile = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("GAME CATEGORIES")
                .FontHeavy(size: 16)
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
                        Text("GAME CATEGORIES")
                            .FontHeavy(size: 16)
                    )
                )
            
            VStack(alignment: .leading) {
                ForEach(0..<11, id: \.self) { index in
                    if index <= 6 {
                        Button(action: {
                            if selectedGame == arraOfGames[index] {
                                switch index {
                                case 0:
                                    game1 = true
                                case 1:
                                    game2 = true
                                case 2:
                                    game3 = true
                                case 3:
                                    game4 = true
                                case 4:
                                    game5 = true
                                case 5:
                                    game6 = true
                                default:
                                    game1 = true
                                }
                            } else {
                                selectedGame = arraOfGames[index]
                            }
                        }) {
                            Text(arraOfGames[index])
                                .FontRegular(size: 16, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                .padding(10)
                                .background(
                                    selectedGame == arraOfGames[index] ? Color(red: 5/255, green: 47/255, blue: 75/255) : Color.clear
                                )
                        }
                        .pressableButtonStyle()
                    } else {
                        Text("Locked...")
                            .FontRegular(size: 16, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                            .padding(10)
                    }
                }
                
                VStack(spacing: 25) {
                    Rectangle()
                        .fill(Color(red: 5/255, green: 47/255, blue: 80/255))
                        .frame(width: 204, height: 1)
                    
                    Button(action: {
                        isProfile = true
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255),
                                                          Color(red: 0/255, green: 128/255, blue: 255/255),
                                                          Color(red: 255/255, green: 1/255, blue: 255/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 4)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "person")
                                                .foregroundStyle(.black)
                                            
                                            Text("Profile")
                                                .FontRegular(size: 16, color: .black)
                                        }
                                    }
                            }
                            .frame(width: 204, height: 36)
                            .cornerRadius(8)
                    }
                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255), radius: 15)
                    .pressableButtonStyle()
                }
                .padding(.top, 20)
            }
        }
        .fullScreenCover(isPresented: $game1, content: {
            NeonRushView()
        })
        .fullScreenCover(isPresented: $game2, content: {
            ElementalSpinView()
        })
        .fullScreenCover(isPresented: $game3, content: {
            VegasLuxView()
        })
        .fullScreenCover(isPresented: $game4, content: {
            SteamFortuneView()
        })
        .fullScreenCover(isPresented: $game5, content: {
            ScratchView()
        })
        .fullScreenCover(isPresented: $game6, content: {
            ThunderStrikeView()
        })
        .fullScreenCover(isPresented: $game7, content: {
            BingoPartyView()
        })
        .fullScreenCover(isPresented: $isProfile, content: {
            NeoMenuView()
        })
        .padding(20)
        .background(
            Color(red: 1/255, green: 9/255, blue: 47/255)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(  LinearGradient(
                    colors: [
                        Color(red: 11/255, green: 10/255, blue: 10/255),
                        Color(red: 8/255, green: 84/255, blue: 84/255)
                    ],
                    startPoint: .bottom, endPoint: .top
                ), lineWidth: 3)
        )
        
    }
}

#Preview {
    GameCategories()
}
