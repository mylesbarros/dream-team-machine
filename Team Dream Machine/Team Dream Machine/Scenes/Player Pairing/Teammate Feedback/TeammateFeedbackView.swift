//
//  TeammateFeedbackView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeammateFeedbackView: View {

    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth, height: 48, alignment: .center)
            Text("How would you feel about being on a team with...")
                .foregroundColor(.textPrimary)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.system(size: 24))
                .padding(.init(top: 0, leading: 32, bottom: 8, trailing: 32))
            if viewModel.shouldBlankText {
                Text(" ")
                    .frame(width: screenWidth, height: 52, alignment: .center)
            } else {
                Text(viewModel.potentialTeammateName)
                    .foregroundColor(.textName)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: screenWidth, height: 52, alignment: .center)
                    .transition(.stripes(stripes: 6, horizontal: true))
                    .id("TeammateName-\(viewModel.potentialTeammateName)")
            }
            Spacer()
                .frame(width: screenWidth, height: screenHeight / 8, alignment: .center)
            InterestInputView(selectionDelegate: viewModel)
                .frame(maxHeight: .infinity, alignment: .center)
            Spacer()
        }
        .background(Color.background)
    }

    @ObservedObject private var viewModel: TeammateFeedbackViewModel

    private var screenWidth: CGFloat { Device.screen.width }
    private var screenHeight: CGFloat { Device.screen.height }

    init(getFeedbackFor potentialTeammates: [Person], from player: Person, delegate: FeedbackDelegate) {
        viewModel = .init(
            potentialTeammates: potentialTeammates,
            for: player,
            delegatingTo: delegate
        )
    }
}

protocol FeedbackDelegate: AnyObject {
    func userDidProvide(feedback: [PlayerPairing])
}

final class TeammateFeedbackViewModel: ObservableObject {

    @Published var potentialTeammateName: String
    @Published var shouldBlankText: Bool = false

    private var currentTeammate: Person

    private let player: Person
    private var potentialTeammates: [Person]
    private var feedback: [PlayerPairing] = []

    private weak var delegate: FeedbackDelegate?

    init(potentialTeammates: [Person], for player: Person, delegatingTo delegate: FeedbackDelegate) {
        var teammates = potentialTeammates
        currentTeammate = teammates.removeFirst()
        self.potentialTeammates = teammates

        potentialTeammateName = currentTeammate.name
        self.player = player
        self.delegate = delegate
    }
}

extension TeammateFeedbackViewModel: InterestSelectionDelegate {
    func userSelected(interest: PairingInterestLevel) {
        let pairingFeedback = PlayerPairing(
            player: player,
            potentialTeammate: currentTeammate,
            pairingInterest: interest
        )

        feedback.append(pairingFeedback)

        if !potentialTeammates.isEmpty {
            let newTeammateToConsider = potentialTeammates.removeFirst()
            withAnimation {
                DispatchQueue.main.async {
                    self.shouldBlankText = true
                    self.potentialTeammateName = newTeammateToConsider.name
                    self.currentTeammate = newTeammateToConsider
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                withAnimation { self.shouldBlankText = false }
            })
        }
        else {
            delegate?.userDidProvide(feedback: feedback)
        }
    }
}
