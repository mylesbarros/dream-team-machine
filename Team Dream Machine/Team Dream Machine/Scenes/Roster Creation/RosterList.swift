//
//  RosterList.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 26.02.2022.
//

import Combine
import SwiftUI

struct RosterList: View {

    // MARK: - Public Properties

    var body: some View {
        GeometryReader { screen in
            ZStack {
                NavigationView {
                    List {
                        ForEach(viewModel.people, id: \.self) { player in
                            Text(player.name)
                        }
                        .onDelete(perform: viewModel.remove)
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
                    .overlay(Group { emptyState() })
                    // Navigation Bar
                    .navigationTitle("Player Roster 🧢")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button("Form Teams") {
                                viewModel.shouldShowCreationInterface = false
                                viewModel.shouldTransitionToPairing = true
                            }
                            .disabled(viewModel.tooFewPlayersToFormTeams)
                        })
                        ToolbarItem(placement: .bottomBar, content: {
                            Button("Add New Players") {
                                withAnimation { viewModel.shouldShowCreationInterface = true }
                            }
                        })
                    }
                }
                Spacer()
                // Player Creation Drawer
                VStack {
                    if viewModel.shouldShowCreationInterface {
                        AddPlayerDrawer(creationDelegate: viewModel)
                            .edgesIgnoringSafeArea([.bottom])
                            .frame(alignment: .bottom)
                            .id("AddPlayerDrawer-Bottom")
                            .transition(.move(edge: .bottom))
                            .offset(x: 0, y: 280 - (viewModel.keyboardHeight / 2))
                    }
                }
                .edgesIgnoringSafeArea([.bottom])
                .frame(height: 240, alignment: .bottom)
            }
            .frame(width: screen.size.width, height: screen.size.height, alignment: .top)
        }
        .fullScreenCover(
            isPresented: $viewModel.shouldTransitionToPairing,
            content: { PlayerPairingCoordinator(rosterProvider: viewModel) }
        )
    }

    // MARK: - Private Properties

    @ObservedObject private var viewModel: RosterListViewModel = .init()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color.TeamResults.title]
        UITableView.appearance().backgroundColor = .clear
    }

    private func emptyState() -> some View {
        if viewModel.people.isEmpty {
            return AnyView(
                Text("You don't have any players.\nNo time like the present to add some!")
                    .foregroundColor(Color.blue)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            )
        } else {
            return AnyView(Text(""))
        }
    }
}

final class RosterListViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var people: [Person] = []

    var tooFewPlayersToFormTeams: Bool { people.count <= 4 }
    @Published var shouldShowCreationInterface: Bool = false
    @Published var shouldTransitionToPairing: Bool = false

    @Published var keyboardHeight: CGFloat = 0

    private var cancellables: Set<AnyCancellable> = []

    init() {
        Publishers.keyboardHeight
            .sink(receiveValue: { newHeight in
                withAnimation { self.keyboardHeight = newHeight }
        })
        .store(in: &cancellables)
    }

    func remove(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
    }

}

extension RosterListViewModel: PlayerCreationDelegate {
    func newPlayerCreated(name: String) {
        let newPlayer = Person(name: name)
        people.insert(newPlayer, at: 0)
    }

    func userRequestedToClosePlayerCreation() {
        withAnimation { shouldShowCreationInterface = false }
    }
}

extension RosterListViewModel: RosterProvider { }
