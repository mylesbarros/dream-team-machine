//
//  TeammateFeedbackView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import Animalese_Swift
import AVFoundation
import SwiftUI

struct TeammateFeedbackView: View {

    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth, height: 48, alignment: .center)
            Text("How would you feel about being on a team with...")
                .foregroundColor(.init(hex: "#581F18"))
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.system(size: 24))
                .padding(.init(top: 0, leading: 32, bottom: 8, trailing: 32))
            Spacer()
                Text(viewModel.potentialTeammateName)
                .foregroundColor(.init(hex: "#E06C9F"))
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
                    .frame(width: 212, height: 212, alignment: .center)
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
                .init(hex: "F6F5AE"),
                .init(hex: "FFD1BA")
            ]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }

    @ObservedObject private var viewModel: TeammateFeedbackViewModel

    private var screenWidth: CGFloat { Device.screen.width }
    private var screenHeight: CGFloat { Device.screen.height }

    @State var player: AVAudioPlayer!

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
    @Published var teammateImageName: String

    private var currentTeammate: Person

    private let player: Person
    private var potentialTeammates: [Person]
    private var feedback: [PlayerPairing] = []

    private weak var delegate: FeedbackDelegate?

    private let imageNameFactory = PlayerImageFactory()

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
        else {
            delegate?.userDidProvide(feedback: feedback)
        }
    }
}
