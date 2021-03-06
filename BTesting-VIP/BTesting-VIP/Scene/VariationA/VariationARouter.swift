//
//  VariationARouter.swift
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

@objc protocol VariationARoutingLogic {
    func routeToHome(segue: UIStoryboardSegue?)
}

protocol VariationADataPassing {
    var dataStore: VariationADataStore? { get }
}

class VariationARouter: NSObject, VariationARoutingLogic, VariationADataPassing {
    weak var viewController: VariationAViewController?
    var dataStore: VariationADataStore?
    
    // MARK: Routing
    func routeToHome(segue: UIStoryboardSegue?) {}
    
    // MARK: Navigation
    func navigateToHome(source: VariationAViewController, destination: HomeViewController) {}
    
    // MARK: Passing data
    func passDataToHome(source: VariationADataStore, destination: inout HomeDataStore) {}
}
