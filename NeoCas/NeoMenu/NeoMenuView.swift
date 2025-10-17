import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let desc: String
    let color: Color
    let goal: Int
    var currentValue: Int = 0
    var isAchieved: Bool = false
}

struct NeoMenuView: View {
    @StateObject var neoMenuModel =  NeoMenuViewModel()
    @State var showAlert = false
    @State private var selectedStatus = "Profile"
    let status = ["Profile", "Achievements", "Statistics"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                    .frame(height: 130)
                    .ignoresSafeArea(edges: .top)
            }
            
            VStack {
                VStack(spacing: 21) {
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
                                                HStack {
                                                    Image(systemName: "arrow.left")
                                                        .foregroundStyle(.black)
                                                    
                                                    Text("Back to Menu")
                                                        .FontBold(size: 14, color: .black)
                                                }
                                            }
                                    }
                                    .frame(width: 147, height: 32)
                                    .cornerRadius(8)
                            }
                            .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255), radius: 15)
                            .pressableButtonStyle()
                            
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 7/255, green: 44/255, blue: 61/255),
                                                          Color(red: 19/255, green: 38/255, blue: 65/255),
                                                          Color(red: 9/255, green: 38/255, blue: 54/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0/255, green: 255/255, blue: 255/255))
                                    .overlay {
                                        HStack {
                                            ForEach(status, id: \.self) { item in
                                                Button(action: {
                                                    withAnimation {
                                                        selectedStatus = item
                                                    }
                                                }) {
                                                    Rectangle()
                                                        .fill(selectedStatus == item ? LinearGradient(colors: [Color(red: 167/255, green: 174/255, blue: 174/255),
                                                                                                               Color(red: 231/255, green: 231/255, blue: 231/255)], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            Text(item)
                                                                .FontMedium(size: 14, color: selectedStatus == item ? .black : .white)
                                                        }
                                                        .frame(width: 115, height: 27)
                                                        .cornerRadius(20)
                                                }
                                                .pressableButtonStyle()
                                            }
                                        }
                                    }
                            }
                            .frame(height: 36)
                            .cornerRadius(20)
                            .padding(.top, UIScreen.main.bounds.width > 600 ? 40 : 10)
                        
                        switch selectedStatus {
                        case "Profile":
                            ProfileView()
                        case "Achievements":
                            AcivView()
                        case "Statistics":
                            StatView()
                        default:
                            Text("OPAChKI")
                        }
                    }
                    .padding(.top)
                    
                }
            }
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    NeoMenuView()
}
