//
//  VariationAInteractor.swift
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

protocol HomeDisplayLogic: AnyObject {
    func displayProduct(viewModel: Home.ViewProduct.ViewModel)
    func displayBuyersCount(viewModel: Home.UpdateBuyersCount.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        let purchaseFlowABTest = PurchaseFlowABTest(interactorA: nil, interactorB: nil, router: router)
        viewController.router = purchaseFlowABTest
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
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
    
    // MARK: View lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBuyersCount()
    }
    
    // MARK: View product
    @IBAction func viewProductButtonTapped(_ sender: Any) {
        let request = Home.ViewProduct.Request()
        interactor?.viewProduct(request: request)
    }
    
    func displayProduct(viewModel: Home.ViewProduct.ViewModel) {
        router?.routeToProduct(segue: nil)
    }
    
    // MARK: Update buyers count
    @IBOutlet weak var buyersCount: UILabel!
    
    func updateBuyersCount() {
        let request = Home.UpdateBuyersCount.Request()
        interactor?.updateBuyersCount(request: request)
    }
    
    func displayBuyersCount(viewModel: Home.UpdateBuyersCount.ViewModel) {
        buyersCount.text = viewModel.counts
    }
}
