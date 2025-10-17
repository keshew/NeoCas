import SwiftUI

struct NeoMenuModel {
 
}

struct StatsModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var value: String
    var color: Color
}
