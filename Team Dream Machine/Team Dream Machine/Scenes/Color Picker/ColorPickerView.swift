//
//  ColorPickerView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import Combine
import SwiftUI

struct ColorPickerView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                TextField("D7E5F0", text: $viewModel.selectedStartColor)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                TextField("FDFD96", text: $viewModel.selectedEndColor)
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            .frame(alignment: .bottom)
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [viewModel.startColor, viewModel.endColor]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }

    @ObservedObject private var viewModel: ColorPickerViewModel = .init()
}

final class ColorPickerViewModel: ObservableObject {

    @Published var selectedStartColor: String = ""
    @Published var selectedEndColor: String = ""

    @Published var startColor: Color = .init(hex: "D7E5F0")
    @Published var endColor: Color = .init(hex: "FDFD96")

    private var cancellables: Set<AnyCancellable> = .init()

    init() {
        $selectedStartColor
            .sink(receiveValue: { newStartHex in
                guard newStartHex.count == 6 else { return }

                withAnimation {
                    self.startColor = .init(hex: newStartHex)
                }
            })
            .store(in: &cancellables)

        $selectedEndColor
            .sink(receiveValue: { newEndHex in
                guard newEndHex.count == 6 else { return }
                
                withAnimation {
                    self.endColor = .init(hex: newEndHex)
                }
            })
            .store(in: &cancellables)
    }

}

extension Color {
    init(hex: String) {
        var cleanedHex = hex
        cleanedHex.removeAll(where: { $0 == "#" })
        let hex = cleanedHex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

