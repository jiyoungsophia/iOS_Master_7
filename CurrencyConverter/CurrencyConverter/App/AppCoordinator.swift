//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.view.backgroundColor = .systemBackground
    }
    
    func start() {
        let exchangeRateVC = ExchangeRateViewController()
        exchangeRateVC.coordinator = self
        navigationController.pushViewController(exchangeRateVC, animated: false)
    }
    
    func pushToCalculator(with exchangeRate: ExchangeRate) {
        let calculatorVC = CalculatorViewController(exchangeRate: exchangeRate)
        calculatorVC.coordinator = self
        navigationController.pushViewController(calculatorVC, animated: true)
    }
    
    func showAlert(
        title: String = "오류",
        message: String?,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in 
            completion?()
        })
        navigationController.present(alert, animated: true)
    }
}
