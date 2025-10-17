import SwiftUI

struct ThunderStrikeView: View {
    @StateObject var thunderStrikeModel =  ThunderStrikeViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                ZStack(alignment: .top) {
                    ZStack {
                        Image(.game10)
                            .resizable()
                       
                        LinearGradient(
                            colors: [
                                Color(red: 89/255, green: 22/255, blue: 139/255),
                                Color(red: 163/255, green: 0/255, blue: 76/255),
                                Color(red: 15/255, green: 78/255, blue: 99/255)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity(0.6)
                    }
                    .ignoresSafeArea()
                    
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
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 0/255, green: 255/255, blue: 255/255),
                                                                      Color(red: 0/255, green: 128/255, blue: 255/255),
                                                                      Color(red: 255/255, green: 1/255, blue: 255/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 4)
                                                .overlay {
                                                    Image(systemName: "house")
                                                        .foregroundStyle(.black)
                                                }
                                        }
                                        .frame(width: 40, height: 32)
                                        .cornerRadius(8)
                                }
                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255), radius: 15)
                                .pressableButtonStyle()
                                
                                Spacer()
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 9/255, green: 44/255, blue: 68/255),
                                                                  Color(red: 20/255, green: 11/255, blue: 47/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 9/255, green: 103/255, blue: 123/255), lineWidth: 2)
                                            .overlay {
                                                HStack(spacing: 5) {
                                                    Text("COINS:\(thunderStrikeModel.coin)")
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
                            }
                            
                            Text("THUNDER STRIKE")
                                .FontHeavy(size: 30)
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
                                        Text("THUNDER STRIKE")
                                            .FontHeavy(size: 30)
                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                    )
                                )
                        }
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                Rectangle()
                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                    .frame(height: 248)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.white, lineWidth: 3)
                                            .overlay {
                                                VStack(spacing: 10) {
                                                    Text(String(format: "%.2fx", thunderStrikeModel.multiplier))
                                                        .FontHeavy(size: 35)
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
                                                                Text(String(format: "%.2fx", thunderStrikeModel.multiplier))
                                                                    .FontHeavy(size: 35)
                                                            )
                                                        )
                                                    
                                                    if thunderStrikeModel.isPlaying {
                                                        Image(.strikeIcon)
                                                            .resizable()
                                                            .frame(width: 104, height: 104)
                                                    } else if thunderStrikeModel.hasCrashed {
                                                        Image(.thunderLose)
                                                            .resizable()
                                                            .frame(width: 104, height: 104)
                                                    } else if thunderStrikeModel.hasWon {
                                                        Image(.thunderWin)
                                                            .resizable()
                                                            .frame(width: 104, height: 104)
                                                    } else {
                                                        Image(.strikeIcon)
                                                            .resizable()
                                                            .frame(width: 104, height: 104)
                                                    }

                                                    if thunderStrikeModel.isPlaying {
                                                        Text("Initialize\nconnection!")
                                                            .FontMedium(size: 20, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                            .multilineTextAlignment(.center)
                                                    } else if thunderStrikeModel.hasCrashed {
                                                        Text("LOSE")
                                                            .FontHeavy(size: 40)
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
                                                                    Text("LOSE")
                                                                        .FontHeavy(size: 40)
                                                                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                                )
                                                            )
                                                    } else if thunderStrikeModel.hasWon {
                                                        Text("VICTORY")
                                                            .FontHeavy(size: 40)
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
                                                                    Text("VICTORY")
                                                                        .FontHeavy(size: 40)
                                                                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                                )
                                                            )
                                                    } else {
                                                        Text("Initialize\nconnection!")
                                                            .FontMedium(size: 20, color: Color(red: 224/255, green: 248/255, blue: 255/255))
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                            }
                                    }
                                    .cornerRadius(20)
                                    .padding(.horizontal, 20)
                                
                                Rectangle()
                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                    .frame(height: 440)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.white, lineWidth: 3)
                                            .overlay {
                                                VStack(spacing: 25) {
                                                    VStack(spacing: 15) {
                                                    Text("YOUR BET")
                                                        .FontHeavy(size: 20)
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
                                                                Text("YOUR BET")
                                                                    .FontHeavy(size: 20)
                                                            )
                                                        )
                                              
                                                        Rectangle()
                                                            .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 8)
                                                                    .stroke(LinearGradient(colors: [Color(red: 18/255, green: 71/255, blue: 102/255),
                                                                                                    Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                                    .overlay {
                                                                        HStack {
                                                                            Text("\(thunderStrikeModel.bet)")
                                                                                .FontRegular(size: 16)
                                                                            Spacer()
                                                                        }
                                                                        .padding(.horizontal)
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(8)
                                                            .padding(.horizontal)
                                                        
                                                        HStack {
                                                            Button(action: {
                                                                thunderStrikeModel.bet = thunderStrikeModel.coin / 2
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(LinearGradient(colors: [Color(red: 18/255, green: 71/255, blue: 102/255),
                                                                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("1/2")
                                                                                    .FontMedium(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                            }
                                                                    }
                                                                    .frame(height: 36)
                                                                    .cornerRadius(8)
                                                            }
                                                            .pressableButtonStyle()
                                                            
                                                            Button(action: {
                                                                if thunderStrikeModel.bet * 2 <= thunderStrikeModel.coin {
                                                                    thunderStrikeModel.bet *= 2
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(LinearGradient(colors: [Color(red: 18/255, green: 71/255, blue: 102/255),
                                                                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                                            .overlay {
                                                                                Text("2x")
                                                                                    .FontMedium(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                            }
                                                                    }
                                                                    .frame(height: 36)
                                                                    .cornerRadius(8)
                                                            }
                                                            .pressableButtonStyle()
                                                        }
                                                        .padding(.horizontal)
                                                        
                                                        if thunderStrikeModel.isPlaying {
                                                            Button(action: {
                                                                thunderStrikeModel.stopGame()
                                                            }) {
                                                                Rectangle()
                                                                    .fill(LinearGradient(colors: [Color(red: 255/255, green: 0/255, blue: 115/255),
                                                                                                  Color(red: 246/255, green: 2/255, blue: 255/255),
                                                                                                  Color(red: 67/255, green: 10/255, blue: 255/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 4)
                                                                            .overlay {
                                                                                HStack {
                                                                                    Text("STOP!")
                                                                                        .FontBold(size: 14, color: .black)
                                                                                }
                                                                            }
                                                                    }
                                                                    .frame(height: 32)
                                                                    .cornerRadius(8)
                                                            }
                                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                            .padding(.horizontal)
                                                        } else {
                                                            Button(action: {
                                                                thunderStrikeModel.startGame()
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
                                                                                    Text("Initialize Protocol  🌐")
                                                                                        .FontBold(size: 14, color: .black)
                                                                                }
                                                                            }
                                                                    }
                                                                    .frame(height: 32)
                                                                    .cornerRadius(8)
                                                            }
                                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                            .padding(.horizontal)
                                                        }
                                                    }
                                                    
                                                    VStack {
                                                        Text("System Overloads")
                                                            .FontHeavy(size: 16)
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
                                                                    Text("System Overloads")
                                                                        .FontHeavy(size: 16)
                                                                )
                                                            )
                                                        
                                                        VStack {
                                                            ForEach(Array(thunderStrikeModel.lastFourMultipliers.enumerated()), id: \.offset) { index, value in
                                                                Rectangle()
                                                                    .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
                                                                    .overlay {
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .stroke(LinearGradient(colors: [Color(red: 18/255, green: 71/255, blue: 102/255),
                                                                                                            Color(red: 8/255, green: 84/255, blue: 84/255)], startPoint: .bottom, endPoint: .top), lineWidth: 3)
                                                                            .overlay {
                                                                                HStack {
                                                                                    Text("Log #\(index + 1)")
                                                                                        .FontRegular(size: 16)

                                                                                    Spacer()

                                                                                    Text(String(format: "%.2fx", value))
                                                                                        .FontBold(size: 14)
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
                                                                                                Text(String(format: "%.2fx", value))
                                                                                                    .FontBold(size: 14)
                                                                                            )
                                                                                        )
                                                                                }
                                                                                .padding(.horizontal)
                                                                            }
                                                                    }
                                                                    .frame(height: 36)
                                                                    .cornerRadius(8)
                                                                    .padding(.horizontal)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.2), radius: 10)
                                    }
                                    .cornerRadius(20)
                                    .padding(.horizontal, 20)
                                
                            }
                            .padding(.top, UIScreen.main.bounds.width > 600 ? 60 : 15)
                        }
                    }
                }
                .padding([.top, .horizontal])
            }
        }
    }
}

#Preview {
    ThunderStrikeView()
}

