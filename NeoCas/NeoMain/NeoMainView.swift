import SwiftUI

struct Slots: Identifiable {
    var id = UUID().uuidString
    var image: String
    var name: String
}

struct NeoMainView: View {
    @StateObject var neoMainModel =  NeoMainViewModel()
    @State var showAlert = false
    @State var showCategories = false
    @State var isProfile = false
    @State var game1 = false
    @State var game2 = false
    @State var game3 = false
    @State var game4 = false
    @State var game5 = false
    @State var game6 = false
    @State var game7 = false
    @ObservedObject private var soundManager = SoundManager.shared
    
    let grid = [GridItem(.flexible()), GridItem(.flexible())]
    let slots = [Slots(image: "game1", name: "NEON RUSH: FRUIT 2080"),
                 Slots(image: "game2", name: "ELEMENTAL SPIN"),
                 Slots(image: "game3", name: "VEGAS LUX"),
                 Slots(image: "game4", name: "STEAM OF FORTUNE"),
                 Slots(image: "game5", name: "VEGAS LUX"),
                 Slots(image: "game6", name: "STEAM OF FORTUNE")]
    
    let crashGames = [Slots(image: "game7", name: "LUCKY SCRATCH"),
                      Slots(image: "game8", name: "THUNDER STRIKE"),
                      Slots(image: "game9", name: "NEON BINGO PARTY"),
                      Slots(image: "game10", name: "STEAM OF FORTUNE"),
                      Slots(image: "game11", name: "VEGAS LUX"),
                      Slots(image: "game12", name: "STEAM OF FORTUNE")]
    
    @ObservedObject private var stats = GameStatsManager.shared
    
    private var currentLevel: Int { max(stats.userLevel, 1) }
    private var currentXP: Int { stats.experiencePoints }
    private var xpForNextLevel: Int { 1000 }
    private var progressWidth: CGFloat {
        CGFloat(currentXP) / CGFloat(xpForNextLevel) * 220
    }
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                ZStack(alignment: .top) {
                    LinearGradient(colors: [Color(red: 4/255, green: 34/255, blue: 46/255),
                                            Color(red: 7/255, green: 37/255, blue: 54/255),
                                            Color(red: 46/255, green: 12/255, blue: 77/255),
                                            Color(red: 28/255, green: 5/255, blue: 52/255)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    
                    Rectangle()
                        .fill(Color(red: 10/255, green: 3/255, blue: 31/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color(red: 12/255, green: 17/255, blue: 17/255), lineWidth: 3)
                        }
                        .frame(height: 180)
                        .ignoresSafeArea(edges: .top)
                }
                
                VStack {
                    VStack(spacing: 15) {
                        VStack(spacing: 20) {
                            HStack {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 9/255, green: 44/255, blue: 68/255),
                                                                  Color(red: 20/255, green: 11/255, blue: 47/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 9/255, green: 103/255, blue: 123/255), lineWidth: 2)
                                            .overlay {
                                                HStack(spacing: 5) {
                                                    Text("COINS:\(neoMainModel.coins)")
                                                        .FontMedium(size: 10)
                                                    
                                                    Image(.coin)
                                                        .resizable()
                                                        .frame(width: 24, height: 24)
                                                }
                                                .padding(.leading)
                                            }
                                    }
                                    .frame(width: 126, height: 32)
                                    .cornerRadius(16)
                                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 10, x: -5, y: -2)
                                
                                Spacer()
                                
                                HStack {
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
                                                        Image(systemName: "person")
                                                            .foregroundStyle(.black)
                                                    }
                                            }
                                            .frame(width: 40, height: 32)
                                            .cornerRadius(8)
                                    }
                                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255), radius: 15)
                                    
                                    Button(action: {
                                        showCategories = true
                                    }) {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255),
                                                                          Color(red: 0/255, green: 128/255, blue: 255/255),
                                                                          Color(red: 255/255, green: 1/255, blue: 255/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 4)
                                                    .overlay {
                                                        Image(systemName: "list.bullet")
                                                            .foregroundStyle(.black)
                                                    }
                                            }
                                            .frame(width: 40, height: 32)
                                            .cornerRadius(8)
                                    }
                                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255), radius: 15)
                                }
                                .pressableButtonStyle()
                            }
                            
                            Text("LUCKY CHARM CASINO")
                                .FontHeavy(size: 26)
                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
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
                                        Text("LUCKY CHARM CASINO")
                                            .FontHeavy(size: 26)
                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                    )
                                )
                                .offset(y: 5)
                        }
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 25) {
                                Rectangle()
                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 41)
                                            .stroke(LinearGradient(colors: [Color(red: 11/255, green: 10/255, blue: 10/255),
                                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                            .overlay {
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
                                                .padding(.horizontal, 35)
                                            }
                                    }
                                    .frame(height: 148)
                                    .cornerRadius(41)
                                
                                Text("Amazing Slots")
                                    .FontHeavy(size: 25)
                                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
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
                                            Text("Amazing Slots")
                                                .FontHeavy(size: 25)
                                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                        )
                                    )
                                
                                LazyVGrid(columns: grid, spacing: 25) {
                                    ForEach(0..<6, id: \.self) { index in
                                        if index <= 3 {
                                            Button(action: {
                                                switch index {
                                                case 0:
                                                    game1 = true
                                                case 1:
                                                    game2 = true
                                                case 2:
                                                    game3 = true
                                                case 3:
                                                    game4 = true
                                                default:
                                                    game1 = true
                                                }
                                            }) {
                                                ZStack(alignment: .bottom) {
                                                    Image(slots[index].image)
                                                        .resizable()
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 0/255, green: 251/255, blue: 251/255), lineWidth: 5)
                                                        }
                                                        .frame(width: UIScreen.main.bounds.width > 600 ? 220 : 163, height: UIScreen.main.bounds.width > 600 ? 200 : 181)
                                                        .cornerRadius(16)
                                                    
                                                    BottomRoundedRectangle(radius: 12)
                                                        .fill(Color(red: 9/255, green: 10/255, blue: 41/255))
                                                        .overlay(
                                                            BottomRoundedRectangle(radius: 12)
                                                                .stroke(.white, lineWidth: 2)
                                                                .overlay {
                                                                    Text(slots[index].name)
                                                                        .FontHeavy(size: 12)
                                                                        .frame(width: 120)
                                                                        .multilineTextAlignment(.center)
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
                                                                                Text(slots[index].name)
                                                                                    .FontHeavy(size: 12)
                                                                                    .frame(width: 120)
                                                                                    .multilineTextAlignment(.center)
                                                                            )
                                                                        )
                                                                }
                                                        )
                                                        .frame(width: UIScreen.main.bounds.width > 600 ? 218 : 163, height: 40)
                                                }
                                            }
                                        } else {
                                            ZStack(alignment: .bottom) {
                                                ZStack(alignment: .top) {
                                                    ZStack(alignment: .bottom) {
                                                        Image(slots[index].image)
                                                            .resizable()
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 0/255, green: 251/255, blue: 251/255), lineWidth: 5)
                                                            }
                                                            .frame(width: UIScreen.main.bounds.width > 600 ? 220 : 163, height: UIScreen.main.bounds.width > 600 ? 200 : 181)
                                                            .cornerRadius(16)
                                                        
                                                        BottomRoundedRectangle(radius: 12)
                                                            .fill(Color(red: 9/255, green: 10/255, blue: 41/255))
                                                            .overlay(
                                                                BottomRoundedRectangle(radius: 12)
                                                                    .stroke(.white, lineWidth: 2)
                                                                    .overlay {
                                                                        Text(slots[index].name)
                                                                            .FontHeavy(size: 12)
                                                                            .frame(width: 120)
                                                                            .multilineTextAlignment(.center)
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
                                                                                    Text(slots[index].name)
                                                                                        .FontHeavy(size: 12)
                                                                                        .frame(width: 120)
                                                                                        .multilineTextAlignment(.center)
                                                                                )
                                                                            )
                                                                    }
                                                            )
                                                            .frame(width: UIScreen.main.bounds.width > 600 ? 218 : 161, height: 40)
                                                    }
                                                    .blur(radius: 5)
                                                    
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 20)
                                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                .overlay {
                                                                    HStack(spacing: 5) {
                                                                        Text("COST:1000000")
                                                                            .FontMedium(size: 10)
                                                                        
                                                                        Image(.coin)
                                                                            .resizable()
                                                                            .frame(width: 24, height: 24)
                                                                    }
                                                                    .padding(.leading)
                                                                }
                                                        }
                                                        .frame(width: 163, height: 31)
                                                        .cornerRadius(20)
                                                }
                                                
                                                Button(action: {
                                                    showAlert = true
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 0/255, blue: 115/255),
                                                                                      Color(red: 246/255, green: 2/255, blue: 255/255),
                                                                                      Color(red: 67/255, green: 10/255, blue: 255/255)], startPoint: .leading, endPoint: .trailing))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                .overlay {
                                                                    Text("BUY")
                                                                        .FontBold(size: 14, color: .black)
                                                                }
                                                        }
                                                        .frame(width: 125, height: 32)
                                                        .cornerRadius(8)
                                                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 15)
                                                }
                                                .alert(isPresented: $showAlert) {
                                                    Alert(
                                                        title: Text("Not enough coins"),
                                                        message: Text("You do not have enough coins to unlock."),
                                                        dismissButton: .default(Text("Ok"))
                                                    )
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                Text("Crash Games")
                                    .FontHeavy(size: 25)
                                    .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
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
                                            Text("Crash Games")
                                                .FontHeavy(size: 25)
                                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                        )
                                    )
                                
                                LazyVGrid(columns: grid, spacing: 25) {
                                    ForEach(0..<6, id: \.self) { index in
                                        if index <= 2 {
                                            Button(action: {
                                                switch index {
                                                case 0:
                                                    game5 = true
                                                case 1:
                                                    game6 = true
                                                case 2:
                                                    game7 = true
                                                default:
                                                    game5 = true
                                                }
                                            }) {
                                                ZStack(alignment: .bottom) {
                                                    Image(crashGames[index].image)
                                                        .resizable()
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 0/255, green: 251/255, blue: 251/255), lineWidth: 5)
                                                        }
                                                        .frame(width: UIScreen.main.bounds.width > 600 ? 220 : 163, height: UIScreen.main.bounds.width > 600 ? 200 : 181)
                                                        .cornerRadius(16)
                                                    
                                                    BottomRoundedRectangle(radius: 12)
                                                        .fill(Color(red: 9/255, green: 10/255, blue: 41/255))
                                                        .overlay(
                                                            BottomRoundedRectangle(radius: 12)
                                                                .stroke(.white, lineWidth: 2)
                                                                .overlay {
                                                                    Text(crashGames[index].name)
                                                                        .FontHeavy(size: 12)
                                                                        .frame(width: 120)
                                                                        .multilineTextAlignment(.center)
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
                                                                                Text(crashGames[index].name)
                                                                                    .FontHeavy(size: 12)
                                                                                    .frame(width: 120)
                                                                                    .multilineTextAlignment(.center)
                                                                            )
                                                                        )
                                                                }
                                                        )
                                                        .frame(width: UIScreen.main.bounds.width > 600 ? 218 : 161, height: 40)
                                                }
                                            }
                                        } else {
                                            ZStack(alignment: .bottom) {
                                                ZStack(alignment: .top) {
                                                    ZStack(alignment: .bottom) {
                                                        Image(crashGames[index].image)
                                                            .resizable()
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 16)
                                                                    .stroke(Color(red: 0/255, green: 251/255, blue: 251/255), lineWidth: 5)
                                                            }
                                                            .frame(width: UIScreen.main.bounds.width > 600 ? 220 : 163, height: UIScreen.main.bounds.width > 600 ? 200 : 181)
                                                            .cornerRadius(16)
                                                        
                                                        BottomRoundedRectangle(radius: 12)
                                                            .fill(Color(red: 9/255, green: 10/255, blue: 41/255))
                                                            .overlay(
                                                                BottomRoundedRectangle(radius: 12)
                                                                    .stroke(.white, lineWidth: 2)
                                                                    .overlay {
                                                                        Text(crashGames[index].name)
                                                                            .FontHeavy(size: 12)
                                                                            .frame(width: 120)
                                                                            .multilineTextAlignment(.center)
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
                                                                                    Text(crashGames[index].name)
                                                                                        .FontHeavy(size: 12)
                                                                                        .frame(width: 120)
                                                                                        .multilineTextAlignment(.center)
                                                                                )
                                                                            )
                                                                    }
                                                            )
                                                            .frame(width: UIScreen.main.bounds.width > 600 ? 218 : 161, height: 40)
                                                    }
                                                    .blur(radius: 5)
                                                    
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 20)
                                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                .overlay {
                                                                    HStack(spacing: 5) {
                                                                        Text("COST:1000000")
                                                                            .FontMedium(size: 10)
                                                                        
                                                                        Image(.coin)
                                                                            .resizable()
                                                                            .frame(width: 24, height: 24)
                                                                    }
                                                                    .padding(.leading)
                                                                }
                                                        }
                                                        .frame(width: UIScreen.main.bounds.width > 600 ? 218 : 161, height: 31)
                                                        .cornerRadius(20)
                                                }
                                                
                                                Button(action: {
                                                    showAlert = true
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 0/255, blue: 115/255),
                                                                                      Color(red: 246/255, green: 2/255, blue: 255/255),
                                                                                      Color(red: 67/255, green: 10/255, blue: 255/255)], startPoint: .leading, endPoint: .trailing))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                .overlay {
                                                                    Text("BUY")
                                                                        .FontBold(size: 14, color: .black)
                                                                }
                                                        }
                                                        .frame(width: 125, height: 32)
                                                        .cornerRadius(8)
                                                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.7), radius: 15)
                                                }
                                                .alert(isPresented: $showAlert) {
                                                    Alert(
                                                        title: Text("Not enough coins"),
                                                        message: Text("You do not have enough coins to unlock."),
                                                        dismissButton: .default(Text("Ok"))
                                                    )
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                Color.clear.frame(height: 10)
                            }
                            .padding(.top, UIScreen.main.bounds.width > 600 ? 60 : 20)
                        }
                    }
                }
                .padding([.top, .horizontal])
            }
            
            if showCategories {
                Color.black.opacity(0.7).ignoresSafeArea()
                    .onTapGesture {
                        showCategories.toggle()
                    }
                
                GameCategories()
                    .cornerRadius(0)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .zIndex(1)
                    .padding(.top)
            }
        }
        .onAppear {
            soundManager.playBackgroundMusic()
        }
        .fullScreenCover(isPresented: $isProfile, content: {
            NeoMenuView()
        })
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
        .animation(.easeInOut, value: showCategories)
    }
}

#Preview {
    NeoMainView()
}
