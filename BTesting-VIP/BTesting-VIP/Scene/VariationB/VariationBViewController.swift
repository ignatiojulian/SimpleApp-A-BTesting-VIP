//
//  VariationBViewController.swift
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

protocol VariationBDisplayLogic: AnyObject {
    func displayReceipt(viewModel: VariationB.Buy.ViewModel)
}

class VariationBViewController: ProductViewController, VariationBDisplayLogic {
    var interactor: VariationBBusinessLogic?
    var router: (NSObjectProtocol & VariationBRoutingLogic & VariationBDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = VariationBInteractor()
        let presenter = VariationBPresenter()
        let router = VariationBRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        let purchaseFlowABTest = PurchaseFlowABTest(interactorA: nil, interactorB: interactor, router: nil)
        viewController.interactor = purchaseFlowABTest
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Buy
    @IBOutlet weak var thankYouLabel: UILabel!
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        let request = VariationB.Buy.Request()
        interactor?.buy(request: request)
    }
    
    func displayReceipt(viewModel: VariationB.Buy.ViewModel) {
        thankYouLabel.isHidden = false
        performSegue(withIdentifier: "Home", sender: nil)
    }
}
