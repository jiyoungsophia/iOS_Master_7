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
    case toggleFavorite(String)
}

struct ExchangeRateState {
    var allExchangeRates: [ExchangeRate]
    var filteredExchangeRates: [ExchangeRate]
    var favoriteCurrencies: Set<String>
    var exchangeRateTrends: [String: TrendDirection] = [:]
    var currentSearchText: String
    var errorMessage: String?
    
    init() {
        self.allExchangeRates = []
        self.filteredExchangeRates = []
        self.favoriteCurrencies = []
        self.currentSearchText = ""
        self.errorMessage = nil
    }
}

class ExchangeRateViewModel: ViewModelProtocol {
    
    private let exchangeRateService: ExchangeRateService
    private let favoriteCurrencyManager: FavoriteCurrencyManagerProtocol
    private let recordManager: ExchangeRateRecordManagerProtocol
    
    typealias Action = ExchangeRateAction
    typealias State = ExchangeRateState
    
    var action: ((ExchangeRateAction) -> Void)?
    
    private(set) var state: ExchangeRateState {
        didSet {
            self.onStateChanged?()
        }
    }
    
    var onStateChanged: (() -> Void)?
    
    init(
        exchangeRateService: ExchangeRateService = ExchangeRateService(),
        favoriteCurrencyManager: FavoriteCurrencyManagerProtocol = FavoriteCurrencyManager.shared,
        recordManager: ExchangeRateRecordManagerProtocol = ExchangeRateRecordManager.shared
    ) {
        self.exchangeRateService = exchangeRateService
        self.favoriteCurrencyManager = favoriteCurrencyManager
        self.recordManager = recordManager
        self.state = ExchangeRateState()
        
        loadFavoritesFromCoreData()
        
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
        case .toggleFavorite(let currency):
            self.toggleFavorite(currency)
        }
    }
    
    func loadExchangeRates() {
        state.errorMessage = nil
        
        exchangeRateService.fetchExchangeRate { [weak self] result in
            switch result {
            case .success(let response):
                let newUpdateTime = response.timeLastUpdateUnix
                let lastSavedTime = self?.recordManager.getLastUpdateTime()
                
                if newUpdateTime == lastSavedTime {
                    // 같은 시간 -> 저장된 트렌드 사용
                    let trendRecords = self?.recordManager.getTrendRecords() ?? [:]
                    self?.state.exchangeRateTrends = trendRecords
                } else {
                    // 다른 시간 -> 비교 후 새 트렌드 계산
                    let oldRates = self?.recordManager.getLastRates() ?? [:]
                    let newRates = response.rates
                    let newTrends = self?.calculateTrends(old: oldRates, new: newRates) ?? [:]
                    
                    self?.state.exchangeRateTrends = newTrends
                    
                    // 새 데이터와 트렌드 저장
                    self?.recordManager.saveRecords(
                        rates: newRates,
                        trends: newTrends,
                        updateTime: newUpdateTime
                    )
                }
                
                self?.state.allExchangeRates = response.toExchangeRates()
                self?.state.filteredExchangeRates = self?.sortExchangeRates(response.toExchangeRates()) ?? []
                
            case .failure(let error):
                self?.state.errorMessage = error.localizedDescription
                self?.state.allExchangeRates = []
                self?.state.filteredExchangeRates = []
            }
        }
    }
    
    func filterExchangeRates(with searchText: String) {
        state.currentSearchText = searchText
        let baseRates: [ExchangeRate]
        
        if searchText.isEmpty {
            baseRates = state.allExchangeRates
        } else {
            baseRates = state.allExchangeRates.filter { rate in
                rate.currency.localizedCaseInsensitiveContains(searchText) || rate.country.localizedCaseInsensitiveContains(searchText)
            }
        }
        state.filteredExchangeRates = sortExchangeRates(baseRates)
    }
    
    func toggleFavorite(_ currency: String) {
        if isFavorite(currency) {
            favoriteCurrencyManager.removeFavorite(currency)
            state.favoriteCurrencies.remove(currency)
        } else {
            favoriteCurrencyManager.addFavorite(currency)
            state.favoriteCurrencies.insert(currency)
        }
        
        filterExchangeRates(with: state.currentSearchText)
    }
    
    func isFavorite(_ currency: String) -> Bool {
        return state.favoriteCurrencies.contains(currency)
    }
    
    
    private func sortExchangeRates(_ rates: [ExchangeRate]) -> [ExchangeRate] {
        return rates.sorted {
            if isFavorite($0.currency) != isFavorite($1.currency) {
                return isFavorite($0.currency)
            }
            return $0.currency < $1.currency
        }
    }
    
    private func loadFavoritesFromCoreData() {
        let savedFavorites = favoriteCurrencyManager.loadFavoriteCurrencies()
        state.favoriteCurrencies = savedFavorites
    }
    
    private func calculateTrends(old: [String: Double], new: [String: Double]) -> [String: TrendDirection] {
        var trends: [String: TrendDirection] = [:]
        
        for (currency, newRate) in new {
            guard let oldRate = old[currency] else {
                trends[currency] = TrendDirection.none
                continue
            }
            
            let difference = newRate - oldRate
            
            if abs(difference) <= 0.00001 {
                trends[currency] = TrendDirection.none
            } else if difference > 0 {
                trends[currency] = .up
            } else {
                trends[currency] = .down
            }
        }
        
        return trends
    }
}
