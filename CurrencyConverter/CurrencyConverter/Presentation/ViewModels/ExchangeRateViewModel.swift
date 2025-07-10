//
//  ExchangeRateViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

enum ExchangeRateAction {
    case loadExchangeRates
    case filterExchangeRates(String)
}

struct ExchangeRateState {
    var allExchangeRates: [ExchangeRate]
    var filteredExchangeRates: [ExchangeRate]
    var errorMessage: String?
    
    init() {
        self.allExchangeRates = []
        self.filteredExchangeRates = []
        self.errorMessage = nil
    }
}

class ExchangeRateViewModel{
    
    private let exchangeRateService: ExchangeRateService
    
    typealias Action = ExchangeRateAction
    typealias State = ExchangeRateState
    
    var action: ((ExchangeRateAction) -> Void)?
    
    private(set) var state: ExchangeRateState {
        didSet {
            self.onStateChanged?()
        }
    }
    
    var onStateChanged: (() -> Void)?
    
    init(exchangeRateService: ExchangeRateService = ExchangeRateService()) {
        self.exchangeRateService = exchangeRateService
        self.state = ExchangeRateState()
        
        self.action = { [weak self] action in
            self?.handleAction(action)
        }
    }
    
    private func handleAction(_ action: ExchangeRateAction) {
        switch action {
        case .loadExchangeRates:
            self.loadExchangeRates()
        case .filterExchangeRates(let searchText):
            self.filterExchangeRates(with: searchText)
        }
    }
    
    func loadExchangeRates() {
        state.errorMessage = nil
        
        exchangeRateService.fetchExchangeRate { [weak self] result in
            switch result {
            case .success(let rates):
                self?.state.allExchangeRates = rates
                self?.state.filteredExchangeRates = rates
                
            case .failure(let error):
                self?.state.errorMessage = error.localizedDescription
                self?.state.allExchangeRates = []
                self?.state.filteredExchangeRates = []
            }
        }
    }
    
    func filterExchangeRates(with searchText: String) {
        if searchText.isEmpty {
            state.filteredExchangeRates = state.allExchangeRates
        } else {
            state.filteredExchangeRates = state.allExchangeRates.filter { rate in
                rate.currency.localizedCaseInsensitiveContains(searchText) || rate.country.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
