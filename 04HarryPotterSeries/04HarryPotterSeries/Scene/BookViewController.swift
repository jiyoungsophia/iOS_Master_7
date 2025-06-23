//
//  BookViewController.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/17/25.
//

import UIKit
import SnapKit
import Then

class BookViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: BookViewModel
    
    // MARK: - UI Components
    private lazy var titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private var seriesButtons: [UIButton] = []

    private lazy var seriesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    private lazy var bookDetailView = BookDetailView()
    
    // MARK: - Initializers
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
        
        viewModel.loadBooks()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(seriesStackView)
        view.addSubview(bookDetailView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesStackView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().inset(20)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(40)
        }
        
        bookDetailView.snp.makeConstraints {
            $0.top.equalTo(seriesStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20) 
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBindings() {
        viewModel.onDataLoaded = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(error: error)
        }
        
        bookDetailView.summaryView.onExpandedStateChanged = { [weak self] isExpanded in
            self?.viewModel.saveSummaryExpandedState(isExpanded)
        }
    }
    
    private func updateUI() {
        titleLabel.text = viewModel.bookTitle
        
        if seriesButtons.isEmpty {
            createSeriesButtons(count: viewModel.totalBooksCount)
        } 
        updateButtonSelection(selectedIndex: viewModel.selectedBookIndex)

        bookDetailView.bookTitleLabel.text = viewModel.bookTitle
        bookDetailView.authorRowView.content = viewModel.author
        bookDetailView.releasedRowView.content = viewModel.releaseDate
        bookDetailView.pagesRowView.content = viewModel.pages
        bookDetailView.bookImageView.image = UIImage(named: viewModel.bookImageName)
        bookDetailView.dedicationView.content  = viewModel.dedication
        bookDetailView.summaryView.content  = viewModel.summary
        bookDetailView.summaryView.initialExpandedState = viewModel.loadSummaryExpandedState()
        bookDetailView.chaptersView.chapters = viewModel.chapters
    }
    
    private func createSeriesButtons(count: Int) {
        seriesStackView.clearArrangedSubviews()
        
        seriesStackView.addArrangedSubviews(from: 0..<count) { _, index in
            let button = UIButton().then {
                $0.setTitle("\(index + 1)", for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 16)
                $0.layer.cornerRadius = 20
                $0.clipsToBounds = true
                $0.tag = index
                $0.addTarget(self, action: #selector(seriesButtonTapped(_:)), for: .touchUpInside)
                
                $0.snp.makeConstraints {
                    $0.width.height.equalTo(40)
                }
            }
            seriesButtons.append(button)
            return button
        }
        updateButtonSelection(selectedIndex: viewModel.selectedBookIndex)
    }
    
    private func updateButtonSelection(selectedIndex: Int) {
        seriesButtons.enumerated().forEach { index, button in
            if index == selectedIndex {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray5
                button.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }
    
    // MARK: - Private Methods
    private func showErrorAlert(error: DataServiceError) {
        let alert = UIAlertController(
            title: "error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc
    private func seriesButtonTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        viewModel.selectBook(at: selectedIndex)
    }
}
