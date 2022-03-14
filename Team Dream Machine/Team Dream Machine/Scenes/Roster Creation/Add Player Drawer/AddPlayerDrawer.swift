//
//  AddPlayerDrawer.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 26.02.2022.
//

import SwiftUI

struct AddPlayerDrawer: View {

    // MARK: - Public Properties

    var body: some View {
        VStack {
            // Header
            Text("New Player")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .center)
                .padding(.init(top: 16, leading: 0, bottom: 32, trailing: 0))
            // Name Input
            TextField("New player name", text: $viewModel.newPlayerName)
                .textFieldStyle(.roundedBorder)
                .frame(width: 240, height: 44, alignment: .center)
            Spacer()
                .frame(width: screenWidth, height: 32, alignment: .center)
            HStack {
                Spacer()
                    .frame(width: 32, height: 44, alignment: .leading)
                Button(action: { viewModel.userDidTapToClose() }, label: {
                    Text("Close")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                })
                .frame(width: 54, height: 44, alignment: .leading)
                Spacer()
                Button(action: { viewModel.userDidTapToAddPlayer() }, label: {
                    Text("Add")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                })
                .frame(width: 54, height: 44, alignment: .trailing)
                Spacer()
                    .frame(width: 32, height: 44, alignment: .trailing)
            }
            .frame(width: screenWidth, height: 44, alignment: .center)
            .padding(.init(top: 0, leading: 0, bottom: 32, trailing: 0))
        }
        .frame(width: screenWidth, height: 240, alignment: .center)
        .background(Color.Roster.bottomDrawer)
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }

    // MARK: - Private Properties

    @ObservedObject private var viewModel: AddPlayerViewModel

    private var screenWidth: CGFloat { Device.screen.width }

    // MARK: - Initializers

    init(creationDelegate: PlayerCreationDelegate) {
        viewModel = .init(delegate: creationDelegate)
    }
}

