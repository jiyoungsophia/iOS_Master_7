//
//  ChaptersView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/19/25.
//

import UIKit

final class ChaptersView: UIView {
    
    // MARK: - Properties
    var chapters: [String] = [] {
        didSet {
            updateChapters()
        }
    }
    
    // MARK: - UI Components
    private lazy var titleLabel = UILabel().then {
        $0.text = "Chapters"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    private lazy var chapterVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
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
    private func setupView() {
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(chapterVStackView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        chapterVStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func updateChapters() {
        chapterVStackView.clearArrangedSubviews()
        chapterVStackView.addArrangedSubviews(from: chapters) { text, _ in
            return UILabel().then {
                $0.text = text
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = .darkGray
                $0.numberOfLines = 0
            }
        }
    }
}
