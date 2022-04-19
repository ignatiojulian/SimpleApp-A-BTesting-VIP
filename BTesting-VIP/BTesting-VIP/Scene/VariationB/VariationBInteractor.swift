//
//  VariationBInteractor.swift
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

protocol VariationBBusinessLogic {
    func buy(request: VariationB.Buy.Request)
}

protocol VariationBDataStore {}

class VariationBInteractor: VariationBBusinessLogic, VariationBDataStore {
    var presenter: VariationBPresentationLogic?
    var worker: VariationBWorker?
    
    // MARK: Buy
    func buy(request: VariationB.Buy.Request) {
        let response = VariationB.Buy.Response()
        presenter?.formatReceipt(response: response)
    }
}
