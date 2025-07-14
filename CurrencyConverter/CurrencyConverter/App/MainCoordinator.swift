//
//  MainCoordinator.swift
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
    
    private let appStateManager: AppStateManagerProtocol = AppStateManager.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.view.backgroundColor = .systemBackground
    }
    
    func start() {
        if let savedState = appStateManager.loadAppState() {
            restoreFromSavedState(savedState)
        } else {
            showExchangeRate()
        }
    }
    
    func showExchangeRate() {
        let exchangeRateVC = ExchangeRateViewController()
        exchangeRateVC.coordinator = self
        navigationController.setViewControllers([exchangeRateVC], animated: false)
        
        appStateManager.saveAppState(screen: .exchangeRateList, currency: nil)
    }
    
    func pushToCalculator(with exchangeRate: ExchangeRate) {
        let viewModel = CalculatorViewModel(exchangeRate: exchangeRate)
        let calculatorVC = CalculatorViewController(viewModel: viewModel)
        calculatorVC.coordinator = self
        navigationController.pushViewController(calculatorVC, animated: true)
        
        appStateManager.saveAppState(screen: .calculator, currency: exchangeRate.currency)
    }
    
    private func restoreFromSavedState(_ state: (screen: ScreenType, currency: String?)) {
        switch state.screen {
        case .exchangeRateList:
            showExchangeRate()
        case .calculator:
            guard let currency = state.currency else {
                showExchangeRate()
                return
            }
            restoreCaculatorScreen(currency: currency)
        }
    }
    
    private func restoreCaculatorScreen(currency: String) {
        let lastRates = ExchangeRateRecordManager.shared.getLastRates()
        
        guard let rate = lastRates[currency] else {
            showExchangeRate()
            return
        }
        
        let exchangeRate = ExchangeRate(
            currency: currency,
            country: CurrencyMapping.getCountryName(from: currency),
            rate: rate
        )
        
        let exchangeRateVC = ExchangeRateViewController()
        exchangeRateVC.coordinator = self
        
        let viewModel = CalculatorViewModel(exchangeRate: exchangeRate)
        let calculatorVC = CalculatorViewController(viewModel: viewModel)
        calculatorVC.coordinator = self
        
        navigationController.setViewControllers([exchangeRateVC, calculatorVC], animated: false)
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
