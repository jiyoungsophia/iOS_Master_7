//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import UIKit
import SnapKit
import Then

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    private let viewModel: CalculatorViewModel
    
    // MARK: - UI Components
    
    private let currencyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .text
        $0.textAlignment = .center
    }
    
    private let countryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
        $0.textAlignment = .center
    }
    
    private let VStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let amountTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 16)
        $0.borderStyle = .roundedRect
        $0.keyboardType = .decimalPad
        $0.textAlignment = .center
        $0.placeholder = Constants.amountPlaceholder
    }
    
    private let convertButton = UIButton().then {
        $0.backgroundColor = .button
        $0.setTitle(Constants.convertButtonTitle, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.layer.cornerRadius = 8
    }
    
    private let resultLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .text
        $0.text = Constants.resultLabelText
    }
    
    // MARK: - Initializer
    
    init(exchangeRate: ExchangeRate) {
        self.viewModel = CalculatorViewModel(exchangeRate: exchangeRate)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
        setupBinding()
        render(state: viewModel.state)
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .background
        title = Constants.calculatorTitle
        
        VStackView.addArrangedSubview(currencyLabel)
        VStackView.addArrangedSubview(countryLabel)
        
        [VStackView, amountTextField, convertButton, resultLabel]
            .forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        VStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        amountTextField.snp.makeConstraints {
            $0.top.equalTo(VStackView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        convertButton.snp.makeConstraints {
            $0.top.equalTo(amountTextField.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(convertButton.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Binding
    
    private func setupBinding() {
        viewModel.onStateChanged = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.render(state: self.viewModel.state)
            }
        }
    }
    
    private func render(state: CalculatorState) {
        currencyLabel.text = state.exchangeRate.currency
        countryLabel.text = state.exchangeRate.country
        
        resultLabel.text = state.calculatedResult
        
        if let errorMessage = state.errorMessage?.localizedDescription {
            coordinator?.showAlert(message: errorMessage) { [weak self] in
                self?.amountTextField.text = ""
            }
        }
    }
    
    // MARK: - Actions
    
    private func setupAction() {
        convertButton.addTarget(
            self,
            action: #selector(convertButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    private func convertButtonTapped() {
        viewModel.action?(.calculate(amountTextField.text))
    }
}
