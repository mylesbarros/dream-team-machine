//
//  TeammateFeedbackView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeammateFeedbackView: View {

    // MARK: - Public Properties

    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth, height: 48, alignment: .center)
            Text("\(viewModel.player.name), how would you feel about being on a team with...")
                .fontWeight(Font.Weight.medium)
                .font(.system(size: 24))
                .foregroundColor(.Feedback.topText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.init(top: 0, leading: 32, bottom: 8, trailing: 32))
            Spacer()
                Text(viewModel.potentialTeammateName)
                .foregroundColor(.Feedback.nameText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: screenWidth, height: 52, alignment: .center)
                .transition(.opacity)
                .id("TeammateName-\(viewModel.potentialTeammateName)")
                Spacer()
                    .frame(height: 16, alignment: .center)
                Image(viewModel.teammateImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 232, height: 232, alignment: .center)
                    .clipShape(Circle())
                    .transition(.scale)
                    .id("TeammateImage-\(viewModel.teammateImageName)")
            Spacer()
            InterestInputView(selectionDelegate: viewModel)
                .frame(alignment: .center)
            Spacer()
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [
                .Feedback.gradientTop,
                .Feedback.gradientBottom
            ]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }

    // MARK: - Private Properties

    @ObservedObject private var viewModel: TeammateFeedbackViewModel

    private var screenWidth: CGFloat { Device.screen.width }
    private var screenHeight: CGFloat { Device.screen.height }

    // MARK: - Initializers

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

    // MARK: - Public Properties

    @Published var potentialTeammateName: String
    @Published var teammateImageName: String

    let player: Person

    // MARK: - Private Properties

    private var currentTeammate: Person

    private var potentialTeammates: [Person]
    private var feedback: [PlayerPairing] = []

    private weak var delegate: FeedbackDelegate?

    private let imageNameFactory = PlayerImageFactory()

    // MARK: - Initializers

    init(potentialTeammates: [Person], for player: Person, delegatingTo delegate: FeedbackDelegate) {
        var teammates = potentialTeammates
        currentTeammate = teammates.removeFirst()
        self.potentialTeammates = teammates

        potentialTeammateName = currentTeammate.name
        teammateImageName = imageNameFactory.imageName(forPlayer: currentTeammate.name)

        self.player = player
        self.delegate = delegate
    }
}

// MARK: - Protocol Extensions

// MARK: InterestSelectionDelegate
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
            DispatchQueue.main.async {
                withAnimation {
                    self.potentialTeammateName = newTeammateToConsider.name
                    self.teammateImageName = self.imageNameFactory.imageName(forPlayer: newTeammateToConsider.name)
                    self.currentTeammate = newTeammateToConsider
                }
            }
        }
        else { delegate?.userDidProvide(feedback: feedback) }
    }
}
