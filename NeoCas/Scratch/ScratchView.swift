import SwiftUI

struct ScratchView: View {
    @StateObject var scratchModel =  ScratchViewModel()
    @Environment(\.presentationMode) var presentationMode
    let columns: [GridItem] = Array(repeating: .init(.fixed(70), spacing: 20), count: 3)
    let symbolArray = [Symbol(image: "scratch1", value: "100"),
                       Symbol(image: "scratch2", value: "50"),
                       Symbol(image: "scratch3", value: "10"),
                       Symbol(image: "scratch4", value: "5"),
                       Symbol(image: "scratch5", value: "3"),
                       Symbol(image: "scratch6", value: "2")]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                ZStack(alignment: .top) {
                    ZStack {
                        Image(.partyBg)
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
                                                    Text("COINS:\(scratchModel.coin)")
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
                            
                            Text("LUCKY SCRATCH")
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
                                        Text("LUCKY SCRATCH")
                                            .FontHeavy(size: 30)
                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                    )
                                )
                        }
                        
                        ScrollView(showsIndicators: false) {
                            Rectangle()
                                .fill(LinearGradient(
                                    colors: [
                                        Color(red: 0/255, green: 255/255, blue: 255/255),
                                        Color(red: 6/255, green: 95/255, blue: 184/255),
                                        Color(red: 168/255, green: 3/255, blue: 168/255),
                                        Color(red: 3/255, green: 167/255, blue: 83/255),
                                        Color(red: 84/255, green: 15/255, blue: 158/255)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(height: 763)
                                .overlay {
                                    VStack(spacing: 10) {
                                        VStack(spacing: 15) {
                                            VStack {
                                                BingoPlaceholder(text: "YOUR GUESS")
                                                
                                                LazyVGrid(columns: columns, spacing: 5) {
                                                    ForEach(0..<9, id: \.self) { index in
                                                        Button(action: {
                                                            scratchModel.openCell(at: index)
                                                        }) {
                                                            if let opened = scratchModel.openedSymbols.first(where: { $0.index == index }) {
                                                                Image(opened.symbol.image)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 80, height: 80)
                                                                    .overlay(
                                                                        RoundedRectangle(cornerRadius: 14)
                                                                            .stroke(scratchModel.winningIndexes.contains(index) ? Color.yellow : Color.clear, lineWidth: 4)
                                                                    )
                                                                    .shadow(color: scratchModel.winningIndexes.contains(index) ? Color.yellow.opacity(0.8) : Color.clear, radius: 10)
                                                            } else {
                                                                Rectangle()
                                                                    .fill(
                                                                        LinearGradient(
                                                                            colors: [Color(red: 153/255, green: 161/255, blue: 175/255), Color(red: 73/255, green: 85/255, blue: 101/255)],
                                                                            startPoint: .topLeading,
                                                                            endPoint: .bottomTrailing
                                                                        )
                                                                    )
                                                                    .overlay(
                                                                        RoundedRectangle(cornerRadius: 14)
                                                                            .stroke(Color(red: 106/255, green: 114/255, blue: 130/255), lineWidth: 3)
                                                                            .overlay(
                                                                                Text("?")
                                                                                    .FontRegular(size: 30)
                                                                                    .foregroundColor(.white)
                                                                            )
                                                                    )
                                                                    .frame(width: 80, height: 80)
                                                                    .cornerRadius(14)
                                                                    .padding(.horizontal, 5)
                                                            }
                                                        }
                                                        .disabled(!scratchModel.isGameActive || scratchModel.openedSymbols.contains(where: { $0.index == index }))
                                                    }
                                                }
                                            }
                                            
                                            VStack {
                                                BingoPlaceholder(text: "CARD COST")
                                                Rectangle()
                                                    .fill(LinearGradient(
                                                        colors: [
                                                            Color(red: 0/255, green: 255/255, blue: 255/255),
                                                            Color(red: 6/255, green: 95/255, blue: 184/255),
                                                            Color(red: 168/255, green: 3/255, blue: 168/255),
                                                            Color(red: 3/255, green: 167/255, blue: 83/255),
                                                            Color(red: 84/255, green: 15/255, blue: 158/255)
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ).opacity(0.2))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.5), lineWidth: 1)
                                                            .overlay {
                                                                HStack {
                                                                    Text("\(scratchModel.bet)")
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
                                                        scratchModel.bet = scratchModel.coin / 2
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(
                                                                colors: [
                                                                    Color(red: 0/255, green: 255/255, blue: 255/255),
                                                                    Color(red: 6/255, green: 95/255, blue: 184/255),
                                                                    Color(red: 168/255, green: 3/255, blue: 168/255),
                                                                    Color(red: 3/255, green: 167/255, blue: 83/255),
                                                                    Color(red: 84/255, green: 15/255, blue: 158/255)
                                                                ],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            ).opacity(0.2))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 8)
                                                                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.5), lineWidth: 1)
                                                                    .overlay {
                                                                        Text("1/2")
                                                                            .FontMedium(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(8)
                                                    }
                                                    
                                                    Button(action: {
                                                        if scratchModel.bet * 2 <= scratchModel.coin {
                                                            scratchModel.bet *= 2
                                                        }
                                                    }) {
                                                        Rectangle()
                                                            .fill(LinearGradient(
                                                                colors: [
                                                                    Color(red: 0/255, green: 255/255, blue: 255/255),
                                                                    Color(red: 6/255, green: 95/255, blue: 184/255),
                                                                    Color(red: 168/255, green: 3/255, blue: 168/255),
                                                                    Color(red: 3/255, green: 167/255, blue: 83/255),
                                                                    Color(red: 84/255, green: 15/255, blue: 158/255)
                                                                ],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            ).opacity(0.2))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 8)
                                                                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.5), lineWidth: 1)
                                                                    .overlay {
                                                                        Text("2x")
                                                                            .FontMedium(size: 14, color: Color(red: 0/255, green: 255/255, blue: 255/255))
                                                                    }
                                                            }
                                                            .frame(height: 36)
                                                            .cornerRadius(8)
                                                    }
                                                }
                                                .padding(.horizontal)
                                                
                                                Button(action: {
                                                    scratchModel.startGame()
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
                                                                        Text("🎲  Generate Neural Signal  🎲")
                                                                            .FontBold(size: 14, color: .black)
                                                                    }
                                                                }
                                                        }
                                                        .frame(height: 32)
                                                        .cornerRadius(8)
                                                }
                                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                .padding(.horizontal)
                                                .opacity(scratchModel.isGameActive ? 0.5 : 1.0)
                                                .disabled(scratchModel.isGameActive)
                                            }
                                            
                                            VStack {
                                                BingoPlaceholder(text: "SYMBOL VALUES(match 3)")
                                                
                                                VStack(spacing: 15) {
                                                    ForEach(symbolArray, id: \.id) { item in
                                                        HStack {
                                                            HStack(alignment: .bottom, spacing: 5) {
                                                                ForEach(0..<3, id: \.self) { index in
                                                                    Image(item.image)
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: index == 0 ? 24 : 19, height: index == 0 ? 27 : 20)
                                                                }
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Text("\(item.value)x")
                                                                .FontMedium(size: 14)
                                                        }
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
    ScratchView()
}

