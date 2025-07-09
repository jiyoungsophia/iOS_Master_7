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
    
    private let viewModel = ExchangeRateViewModel()
    
    private let searchBar = UISearchBar().then {
        $0.backgroundColor = .background
        $0.placeholder = "통화 검색"
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.rowHeight = 60
        $0.register(ExchangeRateTableViewCell.self, forCellReuseIdentifier: ExchangeRateTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBinding()
        
        viewModel.loadExchangeRates()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        [searchBar, tableView]
            .forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupBinding() {
        viewModel.onExchangeRateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onErrorOccurred = { [weak self] errorMessage in
            self?.showErrorAlert(errorMessage)
        }
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(
            title: "오류",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension ExchangeRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.identifier,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return UITableViewCell()
        }
        
        let exchangeRate = viewModel.exchangeRates[indexPath.row]
        cell.configure(exchangeRate)
        return cell
    }
}

extension ExchangeRateViewController: UITableViewDelegate {
    
}
