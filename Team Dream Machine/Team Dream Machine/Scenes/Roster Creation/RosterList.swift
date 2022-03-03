//
//  RosterList.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 26.02.2022.
//

import SwiftUI

struct RosterList: View {

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.people) { person in
                    Text(person.name)
                }
                .animation(.easeInOut)
                .background(LinearGradient(
                    gradient: Gradient(colors: [
                        .Roster.rosterGradientTop,
                        .Roster.rosterGradientBottom
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .overlay(Group {
                    emptyState()
                })
                // Navigation Bar
                .navigationTitle("Player Roster 🧢")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button("Form Teams") {
                            viewModel.shouldShowCreationInterface = false
                            viewModel.shouldTransitionToPairing = true
                        }
                    })
                    ToolbarItem(placement: .bottomBar, content: {
                        Button("Add New Players") {
                            withAnimation { viewModel.shouldShowCreationInterface = true }
                        }
                    })
                }
            }
            // Player Creation Drawer
            VStack {
                if viewModel.shouldShowCreationInterface {
                    AddPlayerDrawer(creationDelegate: viewModel)
                        .frame(alignment: .bottom)
                        .edgesIgnoringSafeArea([.bottom])
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldTransitionToPairing, content: { PlayerPairingCoordinator(rosterProvider: viewModel) })
    }

    // MARK: - Private Properties

    @ObservedObject private var viewModel: RosterListViewModel = .init()
    @State private var viewDidAppear: Bool = false

    private let pairingSceneFactory = PairingSceneLinkFactory()
    private var screenWidth: CGFloat { Device.screen.width }

    private func emptyState() -> some View {
        if viewModel.people.isEmpty {
            return AnyView(Text("You don't have any players.\nNo time like the present to add some!")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center))
        } else {
            return AnyView(Text(""))
        }
    }

    init() {
        UITableView.appearance().backgroundColor = .clear
    }
}

final class RosterListViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var people: [Person] = [
        .init(name: "Kaja"),
        .init(name: "Myles"),
        .init(name: "Nora"),
        .init(name: "Xanthe"),
        .init(name: "Danya"),
        .init(name: "Loran"),
        .init(name: "Honza"),
        .init(name: "Adam"),
        .init(name: "Anička")
    ]
    @Published var shouldShowCreationInterface: Bool = false
    @Published var shouldTransitionToPairing: Bool = false

    @Published var keyboardHeight: CGFloat = 0

}

extension RosterListViewModel: RosterProvider { }

extension RosterListViewModel: PlayerCreationDelegate {
    func newPlayerCreated(name: String) {
        let newPlayer = Person(name: name)
        people.append(newPlayer)
    }

    func userRequestedToClosePlayerCreation() {
        withAnimation { shouldShowCreationInterface = false }
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
