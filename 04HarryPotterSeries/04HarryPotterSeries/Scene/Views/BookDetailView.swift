//
//  BookDetailView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/18/25.
//

import UIKit
import SnapKit
import Then

class BookDetailView: UIView {
    // MARK: - 책 정보 영역
    let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    let authorRowView = InfoStackView(
        axis: .horizontal,
        title: "Author",
        titleFont: .boldSystemFont(ofSize: 16),
        contentFont: .systemFont(ofSize: 18),
        contentColor: .darkGray
    )
    
    let releasedRowView = InfoStackView(
        axis: .horizontal,
        title: "Released",
    )
    
    let pagesRowView = InfoStackView(
        axis: .horizontal,
        title: "Pages",
    )
    
    let labelVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let infoHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .top
    }
    
    // MARK: -
    let dedicationView = InfoStackView(
        axis: .vertical,
        title: "Dedication",
        titleFont: .boldSystemFont(ofSize: 18),
    )
    
    let summaryView = InfoStackView(
        axis: .vertical,
        title: "Summary",
        titleFont: .boldSystemFont(ofSize: 18),
    )
    
    let contentHStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        backgroundColor = .white
        
        bookImageView.setContentHuggingPriority(.required, for: .horizontal)
        labelVStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        [bookTitleLabel, authorRowView, releasedRowView, pagesRowView]
            .forEach { labelVStackView.addArrangedSubview($0) }
        [bookImageView, labelVStackView]
            .forEach { infoHStackView.addArrangedSubview($0) }
        [dedicationView, summaryView]
            .forEach { contentHStackView.addArrangedSubview($0)}
        
        self.addSubview(infoHStackView)
        self.addSubview(contentHStackView)
        
    }
    
    func setupConstraints() {
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        
        infoHStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        contentHStackView.snp.makeConstraints {
            $0.top.equalTo(infoHStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
