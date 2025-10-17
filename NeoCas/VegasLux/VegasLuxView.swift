import SwiftUI

struct VegasLuxView: View {
    @StateObject var scratchModel =  VegasLuxViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert = false
    let symbolArray = [Symbol(image: "vegas1", value: "100"),
                       Symbol(image: "vegas2", value: "50"),
                       Symbol(image: "vegas3", value: "10"),
                       Symbol(image: "vegas4", value: "5"),
                       Symbol(image: "vegas5", value: "3"),
                       Symbol(image: "vegas6", value: "2")]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                ZStack(alignment: .top) {
                    ZStack {
                        Image(.vegasBG)
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
                                        .fill(LinearGradient(
                                            colors: [
                                                Color(red: 255/255, green: 0/255, blue: 0/255),
                                                Color(red: 255/255, green: 225/255, blue: 2/255),
                                                Color(red: 255/255, green: 0/255, blue: 0/255)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ))
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
                            
                            Text("VEGAS LUX")
                                .FontHeavy(size: 30)
                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                .overlay(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 255/255, green: 0/255, blue: 0/255),
                                            Color(red: 255/255, green: 225/255, blue: 2/255),
                                            Color(red: 255/255, green: 0/255, blue: 0/255)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .mask(
                                        Text("VEGAS LUX")
                                            .FontHeavy(size: 30)
                                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                    )
                                )
                        }
                        
                        ScrollView(showsIndicators: false) {
                            Rectangle()
                                .fill(LinearGradient(
                                    colors: [
                                        Color(red: 167/255, green: 205/255, blue: 2/255),
                                        Color(red: 125/255, green: 184/255, blue: 5/255),
                                        Color(red: 168/255, green: 73/255, blue: 4/255),
                                        Color(red: 168/255, green: 1/255, blue: 10/255),
                                        Color(red: 17/255, green: 46/255, blue: 158/255)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(height: 703)
                                .overlay {
                                    VStack(spacing: 10) {
                                        VStack(spacing: 15) {
                                            VStack {
                                                ElemetnalPlaceholder(text: "YOUR GUESS")
                                                
                                                ForEach(0..<3, id: \.self) { row in
                                                    HStack(spacing: 0) {
                                                        ForEach(0..<5, id: \.self) { col in
                                                            Rectangle()
                                                                .fill(
                                                                    LinearGradient(
                                                                        colors: [Color.white, Color(red: 66/255, green: 12/255, blue: 55/255)],
                                                                        startPoint: .topLeading,
                                                                        endPoint: .bottomTrailing
                                                                    )
                                                                )
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 14)
                                                                        .stroke(Color(red: 106/255, green: 116/255, blue: 132/255), lineWidth: 3)
                                                                        .overlay(
                                                                            Image(scratchModel.slots[row][col])
                                                                                .resizable()
                                                                                .aspectRatio(contentMode: .fit)
                                                                                .frame(width: 46, height: 46)
                                                                        )
                                                                }
                                                                .frame(width: 57, height: 58)
                                                                .cornerRadius(14)
                                                                .padding(.horizontal, 5)
                                                                .shadow(
                                                                    color: scratchModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color(red: 168/255, green: 42/255, blue: 7/255) : .clear,
                                                                    radius: scratchModel.isSpinning ? 0 : 25
                                                                )
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            VStack {
                                                ElemetnalPlaceholder(text: "BET AMOUNT")
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
                                                    if scratchModel.coin != 0 {
                                                        scratchModel.spin()
                                                    } else {
                                                        showAlert = true
                                                    }
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(
                                                            colors: [
                                                                Color(red: 255/255, green: 0/255, blue: 0/255),
                                                                Color(red: 255/255, green: 225/255, blue: 2/255),
                                                                Color(red: 255/255, green: 0/255, blue: 0/255)
                                                            ],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        ))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                                                .overlay {
                                                                    HStack {
                                                                        Text("SPIN TO WIN")
                                                                            .FontBold(size: 14)
                                                                    }
                                                                }
                                                        }
                                                        .frame(height: 32)
                                                        .cornerRadius(8)
                                                }
                                                .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                                                .padding(.horizontal)
                                                .alert(isPresented: $showAlert) {
                                                    Alert(
                                                        title: Text("Not enough coins"),
                                                        message: Text("You do not have enough coins to spin."),
                                                        dismissButton: .default(Text("Ok"))
                                                    )
                                                }
                                            }
                                            
                                            VStack {
                                                ElemetnalPlaceholder(text: "SYMBOL VALUES(match 3)")
                                                
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
                                .padding(.top, UIScreen.main.bounds.width > 600 ? 60 : 15)
                        }
                    }
                }
                .padding([.top, .horizontal])
            }
            
            if scratchModel.isWin {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    
                    Image(.vegasWin)
                    
                    VStack(spacing: 60) {
                        Image(.vegasWinLabel)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 310, height: 215)
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 250, height: 52)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 165/255, green: 144/255, blue: 97/255), lineWidth: 3)
                                    .overlay {
                                        HStack(spacing: 5) {
                                            Text("+\(scratchModel.win)")
                                                .FontMedium(size: 40, color: .white)
                                            
                                            Image(.coin)
                                                .resizable()
                                                .frame(width: 46, height: 46)
                                        }
                                    }
                            }
                            .cornerRadius(8)
                            .shadow(color: Color(red: 255/255, green: 225/255, blue: 2/255), radius: 10)
                        
                        Button(action: {
                            scratchModel.isWin.toggle()
                        }) {
                            Rectangle()
                                .fill(LinearGradient(
                                    colors: [
                                        Color(red: 255/255, green: 0/255, blue: 0/255),
                                        Color(red: 255/255, green: 225/255, blue: 2/255),
                                        Color(red: 255/255, green: 0/255, blue: 0/255)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 0/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                        .overlay {
                                            Text("CLAIM!")
                                                .FontBold(size: 28)
                                        }
                                }
                                .frame(width: 270, height: 54)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VegasLuxView()
}

