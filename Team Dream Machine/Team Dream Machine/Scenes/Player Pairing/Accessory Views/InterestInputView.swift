//
//  OpinionInputView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct InterestInputView: View {
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
                )
                if shouldIncludeSpacer {
                    Spacer()
                        .frame(width: 24, height: 16, alignment: .center)
                }
            }
        }.frame(maxHeight: .infinity, alignment: .center)
    }

    private let viewModel: InterestInputViewModel

    init(selectionDelegate: InterestSelectionDelegate) {
        viewModel = .init(delegatingTo: selectionDelegate)
    }
}

protocol InterestSelectionDelegate: AnyObject {
    func userSelected(interest: PairingInterestLevel)
}

final class InterestInputViewModel {

    let inputs: [PairingInterestLevel] = PairingInterestLevel.allCases

    private weak var selectionDelegate: InterestSelectionDelegate?

    init(delegatingTo delegate: InterestSelectionDelegate) {
        selectionDelegate = delegate
    }

    func userDidSelect(input selectedElement: Int) {
        let selectedInput = inputs[selectedElement]
        selectionDelegate?.userSelected(interest: selectedInput)
    }
}
