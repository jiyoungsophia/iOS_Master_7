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
    private let viewModel: BookViewModel
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let seriesButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let bookDetailView = BookDetailView()
    
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBindings()
        
        viewModel.loadBooks()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(seriesButton)
        view.addSubview(bookDetailView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().inset(20)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(40)
        }
        
        bookDetailView.snp.makeConstraints {
            $0.top.equalTo(seriesButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupBindings() {
        viewModel.onDataLoaded = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(error: error)
        }
    }
    
    private func updateUI() {
        titleLabel.text = viewModel.bookTitle
        seriesButton.setTitle(viewModel.seriesNumber, for: .normal)
        
        bookDetailView.bookTitleLabel.text = viewModel.bookTitle
        bookDetailView.authorRowView.content = viewModel.author
        bookDetailView.releasedRowView.content = viewModel.releaseDate
        bookDetailView.pagesRowView.content = viewModel.pages
        bookDetailView.bookImageView.image = UIImage(named: viewModel.bookImageName)
        bookDetailView.dedicationView.content  = viewModel.dedication
        bookDetailView.summaryView.content  = viewModel.summary
    }
    
    private func showErrorAlert(error: DataServiceError) {
        let alert = UIAlertController(
            title: "error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
    }
}
