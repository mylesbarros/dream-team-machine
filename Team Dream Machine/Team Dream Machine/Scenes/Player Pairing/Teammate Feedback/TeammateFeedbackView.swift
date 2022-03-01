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
                .frame(width: screenWidth, height: 32, alignment: .center)
            Text("How would you feel about being on a team with...")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.init(top: 0, leading: 32, bottom: 8, trailing: 32))
            Text(viewModel.potentialTeammateName)
                .foregroundColor(.pink)
                .font(.title)
                .transition(.opacity)
                .id("TeammateName-\(viewModel.potentialTeammateName)")
            Spacer()
                .frame(width: screenWidth, height: screenHeight / 8, alignment: .center)
            InterestInputView(selectionDelegate: viewModel)
                .frame(maxHeight: .infinity, alignment: .center)
            Spacer()
        }
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
            currentTeammate = potentialTeammates.removeFirst()
            withAnimation { self.potentialTeammateName = currentTeammate.name }
        }
        else {
            delegate?.userDidProvide(feedback: feedback)
        }
    }
}
