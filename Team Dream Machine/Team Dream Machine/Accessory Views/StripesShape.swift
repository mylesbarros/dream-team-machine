//
//  StripesShape.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

extension AnyTransition {
    static func stripes(stripes s: Int, horizontal h: Bool) -> AnyTransition {

        return AnyTransition.asymmetric(
            insertion: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 1, stripes: s, horizontal: h)),
                identity: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 0, stripes: s, horizontal: h))),
            removal: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(insertion: false, pct: 1, stripes: s, horizontal: h)),
                identity: ShapeClipModifier(shape: StripesShape(insertion: false, pct: 0, stripes: s, horizontal: h))))
    }

}

struct StripesShape: Shape {
    let insertion: Bool
    var pct: CGFloat
    let stripes: Int
    let horizontal: Bool

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if horizontal {
            let stripeHeight = rect.height / CGFloat(stripes)

            for i in 0..<(stripes) {
                let j = CGFloat(i)

                if insertion {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight, width: rect.width, height: stripeHeight * (1-pct)))
                } else {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight + (stripeHeight * pct), width: rect.width, height: stripeHeight * (1-pct)))
                }
            }
        } else {
            let stripeWidth = rect.width / CGFloat(stripes)

            for i in 0..<(stripes) {
                let j = CGFloat(i)

                if insertion {
                    path.addRect(CGRect(x: j * stripeWidth, y: 0, width: stripeWidth * (1-pct), height: rect.height))
                } else {
                    path.addRect(CGRect(x: j * stripeWidth + (stripeWidth * pct), y: 0, width: stripeWidth * (1-pct), height: rect.height))
                }
            }
        }

        return path
    }
}

struct CircleClipShape: Shape {
    var pct: CGFloat

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        var bigRect = rect
        bigRect.size.width = bigRect.size.width * 2 * (1-pct)
        bigRect.size.height = bigRect.size.height * 2 * (1-pct)
        bigRect = bigRect.offsetBy(dx: -rect.width/2.0, dy: -rect.height/2.0)

        path = Circle().path(in: bigRect)

        return path
    }
}

struct ShapeClipModifier<S: Shape>: ViewModifier {
    let shape: S

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}
