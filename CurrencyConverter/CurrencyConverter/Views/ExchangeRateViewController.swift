//
//  ExchangeRateViewController.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import UIKit
import SnapKit
import Then

class ExchangeRateViewController: UIViewController {
    
    private var exchangeRates: [ExchangeRate] = []
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.rowHeight = 60
        $0.register(ExchangeRateTableViewCell.self, forCellReuseIdentifier: ExchangeRateTableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadMockData()
        
//        Task {
//            let service = ExchangeRateService()
//            let result = await service.fetchExchangeRate()
//            
//            switch result {
//            case .success(let rates):
//                print("✅ 성공! \(rates.count)개 환율 받음")
//                rates.prefix(5).forEach { print("  \($0.currency): \($0.rate)") }
//            case .failure(let error):
//                print("❌ 실패: \(error)")
//            }
//        }
    }
    
    private func setupUI() {
        [tableView]
            .forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadMockData() {
        // 임시 목 데이터
        exchangeRates = [
            ExchangeRate(currency: "USD", rate: 1.0000),
            ExchangeRate(currency: "KRW", rate: 1340.50),
            ExchangeRate(currency: "JPY", rate: 151.23),
            ExchangeRate(currency: "EUR", rate: 0.8542),
            ExchangeRate(currency: "GBP", rate: 0.7321),
            ExchangeRate(currency: "CNY", rate: 7.2156),
            ExchangeRate(currency: "CAD", rate: 1.3421),
            ExchangeRate(currency: "AUD", rate: 1.5234)
        ]
        
        tableView.reloadData()
    }

}

extension ExchangeRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.identifier,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return UITableViewCell()
        }
        
        let exchangeRate = exchangeRates[indexPath.row]
        cell.configure(exchangeRate)
        return cell
    }
}

extension ExchangeRateViewController: UITableViewDelegate {
    
}
