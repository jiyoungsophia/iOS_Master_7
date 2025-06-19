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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let labelVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let infoHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .top
    }
    
    
    private let contentHStackView = UIStackView().then {
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
        scrollView.backgroundColor = .systemYellow
        contentView.backgroundColor = .systemBlue
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        bookImageView.setContentHuggingPriority(.required, for: .horizontal)
        labelVStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        [bookTitleLabel, authorRowView, releasedRowView, pagesRowView]
            .forEach { labelVStackView.addArrangedSubview($0) }
        [bookImageView, labelVStackView]
            .forEach { infoHStackView.addArrangedSubview($0) }
        [dedicationView, summaryView]
            .forEach { contentHStackView.addArrangedSubview($0)}
        
        contentView.addSubview(infoHStackView)
        contentView.addSubview(contentHStackView)
        
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        
        infoHStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        contentHStackView.snp.makeConstraints {
            $0.top.equalTo(infoHStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
