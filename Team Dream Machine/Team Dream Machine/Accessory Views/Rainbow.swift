//
//  Rainbow.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct Rainbow: ViewModifier {
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader { (proxy: GeometryProxy) in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: self.hueColors),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .frame(width: proxy.size.width)
                }
            })
            .mask(content)
    }
}

extension View {
    func rainbow() -> some View {
        self.modifier(Rainbow())
    }
}

struct RainbowAnimation: ViewModifier {

    @State var isOn: Bool = false
    let hueColors: [Color]

    var duration: Double
    var animation: Animation {
        Animation
            .linear(duration: duration)
            .repeatForever(autoreverses: false)
    }

    init(duration: Double, hueColors: [Color] = []) {
        self.duration = duration
        if hueColors.isEmpty {
            self.hueColors = stride(from: 0, to: 1, by: 0.01).map {
                Color(hue: $0, saturation: 1, brightness: 1)
            }
        } else {
            self.hueColors = hueColors
        }
    }

    func body(content: Content) -> some View {
        let gradient = LinearGradient(gradient: Gradient(colors: hueColors+hueColors), startPoint: .leading, endPoint: .trailing)
        return content.overlay(GeometryReader { proxy in
            ZStack {
                gradient
                    .frame(width: 2 * proxy.size.width)
                    .offset(x: self.isOn ? -proxy.size.width : 0)
            }
        })
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(self.animation) { self.isOn = true }
            }
        }
        .mask(content)
    }
}

extension View {
    func rainbowAnimation(duration: Double = 4, colors: [Color] = []) -> some View {
        self.modifier(RainbowAnimation(duration: duration, hueColors: colors))
    }
}

