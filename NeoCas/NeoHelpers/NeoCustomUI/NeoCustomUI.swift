import SwiftUI

struct BingoPlaceholder: View {
    var text: String
    var body: some View {
        Rectangle()
            .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
            .overlay {
                HStack {
                    Text(text)
                        .FontHeavy(size: 14)
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
                                Text(text)
                                    .FontHeavy(size: 14)
                            )
                        )
                }
                .padding(.horizontal)
            }
            .frame(height: 27)
            .cornerRadius(17)
            .padding(.horizontal)
    }
}

struct SteamPlaceholder: View {
    var text: String
    var body: some View {
        Rectangle()
            .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
            .overlay {
                HStack {
                    Text(text)
                        .FontHeavy(size: 14)
                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color(red: 96/255, green: 196/255, blue: 196/255),
                                    Color(red: 85/255, green: 133/255, blue: 182/255),
                                    Color(red: 166/255, green: 75/255, blue: 167/255)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .mask(
                                Text(text)
                                    .FontHeavy(size: 14)
                            )
                        )
                }
                .padding(.horizontal)
            }
            .frame(height: 27)
            .cornerRadius(17)
            .padding(.horizontal)
    }
}

struct ElemetnalPlaceholder: View {
    var text: String
    var body: some View {
        Rectangle()
            .fill(Color(red: 1/255, green: 9/255, blue: 47/255))
            .overlay {
                HStack {
                    Text(text)
                        .FontHeavy(size: 14)
                        .shadow(color: Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.3), radius: 15)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color(red: 255/255, green: 46/255, blue: 0/255),
                                    Color(red: 255/255, green: 153/255, blue: 2/255),
                                    Color(red: 221/255, green: 255/255, blue: 0/255)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .mask(
                                Text(text)
                                    .FontHeavy(size: 14)
                            )
                        )
                }
                .padding(.horizontal)
            }
            .frame(height: 27)
            .cornerRadius(17)
            .padding(.horizontal)
    }
}

struct PressableButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95
    var animation: Animation = .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .animation(animation, value: configuration.isPressed)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension View {
    func pressableButtonStyle() -> some View {
        self.buttonStyle(PressableButtonStyle())
    }
}
