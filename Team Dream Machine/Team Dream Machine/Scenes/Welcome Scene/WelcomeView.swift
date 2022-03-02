//
//  WelcomeView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                CloudView(type: .driftingLeft, position: .backgroundFurther, verticalOffset: screenGeometry.size.height / 2 - 110)
                CloudView(type: .driftingLeft, position: .backgroundCloser, verticalOffset: screenGeometry.size.height / 2 - 80)
                VStack {
                    Spacer()
                    Text("Dream Team Machine")
                        .font(.custom("KirbyClassic", size: 30))
                        .foregroundColor(.yellow)
                        .frame(alignment: .center)
                    Spacer()
                }
                CloudView(type: .smokey, position: .foregroundFurther, verticalOffset: screenGeometry.size.height / 2 + 90)
                CloudView(type: .bubbly, position: .foregroundCloser, verticalOffset: screenGeometry.size.height / 2)
            }
            .frame(maxWidth: screenGeometry.size.width, maxHeight: screenGeometry.size.height, alignment: .topLeading)
            .background(LinearGradient(
                gradient: Gradient(colors: [.sky, .white]),
                startPoint: .top,
                endPoint: .bottom
            ))
        }
    }

    init() {
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print("\(fontName)")
            }
        }
    }
}
