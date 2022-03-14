//
//  OpinionInputView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct InterestInputView: View {

    // MARK: - Public Properties

    var body: some View {
        HStack {
            ForEach(0 ..< viewModel.inputs.count, id: \.self) { index in
                let shouldIncludeSpacer: Bool = (index != (viewModel.inputs.count - 1))
                Button(
                    action: { viewModel.userDidSelect(input: index) },
                    label: {
                        Text(viewModel.inputs[index].rawValue)
                            .font(.system(size: 52))
                    }
                ).buttonStyle(OpinionButtonStyle())
                if shouldIncludeSpacer {
                    Spacer()
                        .frame(width: 24, height: 16, alignment: .center)
                }
            }
        }.frame(maxHeight: .infinity, alignment: .center)
    }

    // MARK: - Private Properties

    private let viewModel: InterestInputViewModel

    // MARK: - Initializers

    init(selectionDelegate: InterestSelectionDelegate) {
        viewModel = .init(delegatingTo: selectionDelegate)
    }
}

protocol InterestSelectionDelegate: AnyObject {
    func userSelected(interest: PairingInterestLevel)
}

final class InterestInputViewModel {

    // MARK: - Public Properties

    let inputs: [PairingInterestLevel] = PairingInterestLevel.allCases

    // MARK: - Private Properties

    private weak var selectionDelegate: InterestSelectionDelegate?

    // MARK: - Initializers

    init(delegatingTo delegate: InterestSelectionDelegate) {
        selectionDelegate = delegate
    }

    // MARK: - User I/O

    func userDidSelect(input selectedElement: Int) {
        let selectedInput = inputs[selectedElement]
        selectionDelegate?.userSelected(interest: selectedInput)
    }
}

struct OpinionButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1)
        }
}
