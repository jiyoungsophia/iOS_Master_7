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
    
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    private let viewModel = ExchangeRateViewModel()
    
    // MARK: - UI Components
    
    private let searchBar = UISearchBar().then {
        $0.backgroundColor = .background
        $0.placeholder = "통화 검색"
        $0.searchBarStyle = .minimal
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.rowHeight = 60
        $0.register(ExchangeRateTableViewCell.self, forCellReuseIdentifier: ExchangeRateTableViewCell.identifier)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        setupBinding()
        
        viewModel.loadExchangeRates()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        title = "환율 정보"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        [searchBar, tableView]
            .forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    // MARK: - Binding
    
    private func setupBinding() {
        viewModel.onExchangeRateChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.updateTableView()
            }
        }
        
        viewModel.onErrorOccurred = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(errorMessage)
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    private func updateTableView() {
        tableView.reloadData()
        
        let isEmpty = viewModel.filteredExchangeRates.isEmpty
        let isSearching = !(searchBar.text?.isEmpty ?? true)
        
        if isEmpty && isSearching {
            showEmptyState()
        } else {
            hideEmptyState()
        }
    }
    
    private func showEmptyState() {
        let emptyLabel = UILabel().then {
            $0.text = "검색 결과 없음"
            $0.textColor = .secondaryLabel
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 18, weight: .medium)
        }
        
        tableView.backgroundView = emptyLabel
        tableView.separatorStyle = .none
    }
    
    private func hideEmptyState() {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
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

// MARK: - UITableViewDataSource

extension ExchangeRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredExchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.identifier,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return UITableViewCell()
        }
        
        // 간헐적으로 나타나는 크래시 예방
        guard indexPath.row < viewModel.filteredExchangeRates.count else {
            return cell
        }
        
        let exchangeRate = viewModel.filteredExchangeRates[indexPath.row]
        cell.configure(exchangeRate)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExchangeRateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedExchangeRate = viewModel.filteredExchangeRates[indexPath.row]
        coordinator?.pushToCalculator(with: selectedExchangeRate)
    }
}

// MARK: - UISearchBarDelegate

extension ExchangeRateViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterExchangeRates(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterExchangeRates(with: "")
    }
}
