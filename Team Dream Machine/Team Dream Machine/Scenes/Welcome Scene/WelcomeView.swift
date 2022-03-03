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
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 84, height: 84)
                        .foregroundColor(.init(hex: "FDFD96"))
                        .offset(x: 118, y: -264)
                    ZStack {
                        CloudView(
                            type: .flowingLeft,
                            position: .backgroundCloser,
                            verticalOffset: screenGeometry.size.height / 2 - 300,
                            screenWidth: screenGeometry.size.width
                        )
                        CloudView(
                            type: .driftingLeft,
                            position: .backgroundCloser,
                            verticalOffset: screenGeometry.size.height / 2 - 110,
                            screenWidth: screenGeometry.size.width
                        )
                        CloudView(
                            type: .smokey,
                            position: .backgroundCloser,
                            verticalOffset: screenGeometry.size.height / 2 - 80,
                            screenWidth: screenGeometry.size.width
                        )
                    }.frame(width: screenGeometry.size.width)
                    PlaneView(screenWidth: screenGeometry.size.width)
                        .frame(alignment: .trailing)
                    Spacer()
                    VStack {
                        Image("WelcomeText")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 340, height: 340, alignment: .center)
                            .foregroundColor(.init(hex: "FDFD96"))
                            .scaledToFit()
                        Text("Dream Team Machine")
                            .font(.custom("KirbyClassic", size: 34))
                            .foregroundColor(.init(hex: "FDFD96"))
                            .shadow(color: .pink, radius: 3, x: 0, y: 0)
                            .frame(alignment: .center)
                            .offset(x: 0, y: -60)
                    }
                    .offset(x: 0, y: -70)
                    Spacer()
                    ZStack {
                        CloudView(
                            type: .smokey,
                            position: .foregroundFurther,
                            verticalOffset: screenGeometry.size.height / 2 + 40,
                            screenWidth: screenGeometry.size.width
                        )
                        CloudView(
                            type: .flowingRight,
                            position: .backgroundFurther,
                            verticalOffset: screenGeometry.size.height / 2 - 210,
                            screenWidth: screenGeometry.size.width
                        )
                        CloudView(
                            type: .driftingLeft,
                            position: .backgroundFurther,
                            verticalOffset: screenGeometry.size.height / 2 - 140,
                            screenWidth: screenGeometry.size.width
                        )
                        CloudView(
                            type: .bubbly,
                            position: .foregroundCloser,
                            verticalOffset: screenGeometry.size.height / 2 - 4,
                            screenWidth: screenGeometry.size.width,
                            hardcodedStartingX: -130
                        )
                        CloudView(
                            type: .flowingRight,
                            position: .foregroundCloser,
                            verticalOffset: screenGeometry.size.height / 2 + 110,
                            screenWidth: screenGeometry.size.width
                        )
                    }.frame(width: screenGeometry.size.width)
                }
                .frame(maxWidth: screenGeometry.size.width, maxHeight: screenGeometry.size.height, alignment: .topLeading)
                VStack {
                    Spacer()
                    if viewModel.showTapToContinue {
                        Text("Tap to Continue")
                            .font(.custom("KirbyClassic", size: 24))
                            .fontWeight(.bold)
                            .id("TapToContinueLabelText")
                            .foregroundColor(Color(hex: "DB9065"))
                        Spacer()
                    }
                }
                .id("BottomTapStack")
                .frame(height: 100, alignment: .bottom)
                .transition(.opacity)
            }
            .background(LinearGradient(
                gradient: Gradient(colors: [.Welcome.sky, .white]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .gesture(TapGesture().onEnded({
                guard viewModel.showTapToContinue else { return }
                self.viewModel.navigateToRosterList = true
            }))
        }
        .fullScreenCover(isPresented: $viewModel.navigateToRosterList, content: { RosterList() })
    }

    @ObservedObject private var viewModel: WelcomeViewModel = .init()
}

final class WelcomeViewModel: ObservableObject {

    @Published var showTapToContinue: Bool = false
    @Published var navigateToRosterList: Bool = false

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            withAnimation { self.showTapToContinue = true }
        })
    }
}
