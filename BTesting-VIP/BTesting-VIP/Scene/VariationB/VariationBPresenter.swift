//
//  VariationBPresenter.swift
//  ABTesting
//
//  Created by Raymond Law on 8/22/17.
//  Copyright (c) 2017 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol VariationBPresentationLogic {
    func formatReceipt(response: VariationB.Buy.Response)
}

class VariationBPresenter: VariationBPresentationLogic {
    weak var viewController: VariationBDisplayLogic?
    
    // MARK: Buy
    func formatReceipt(response: VariationB.Buy.Response) {
        let viewModel = VariationB.Buy.ViewModel()
        viewController?.displayReceipt(viewModel: viewModel)
    }
}
