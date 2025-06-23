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
    
    // MARK: - UI Components - Container Views
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var contentView = UIView()
    
    // MARK: - UI Components - Book Info Section
    lazy var bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    lazy var bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var authorRowView = InfoStackView(
        axis: .horizontal,
        title: "Author",
        titleFont: .boldSystemFont(ofSize: 16),
        contentFont: .systemFont(ofSize: 18),
        contentColor: .darkGray
    )
    
    lazy var releasedRowView = InfoStackView(
        axis: .horizontal,
        title: "Released",
    )
    
    lazy var pagesRowView = InfoStackView(
        axis: .horizontal,
        title: "Pages",
    )
    
    // MARK: - UI Components - Stack Views
    private lazy var labelVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private lazy var infoHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .top
    }
    
    // MARK: - UI Components - Content Sections
    lazy var dedicationView = InfoStackView(
        axis: .vertical,
        title: "Dedication",
        titleFont: .boldSystemFont(ofSize: 18),
    )
    
    lazy var summaryView = SummaryView()
    lazy var chaptersView = ChaptersView()
    
    private lazy var contentHStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        bookImageView.setContentHuggingPriority(.required, for: .horizontal)
        labelVStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        [bookTitleLabel, authorRowView, releasedRowView, pagesRowView]
            .forEach { labelVStackView.addArrangedSubview($0) }
        [bookImageView, labelVStackView]
            .forEach { infoHStackView.addArrangedSubview($0) }
        [dedicationView, summaryView, chaptersView]
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
