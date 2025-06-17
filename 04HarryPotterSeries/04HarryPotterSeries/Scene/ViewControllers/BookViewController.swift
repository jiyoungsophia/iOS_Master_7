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
    private let titleLabel = UILabel().then {
        $0.text = "Harry Potter and the Philosopher's Stone"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let seriesButton = UIButton().then {
        $0.setTitle("1", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(seriesButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(40)
        }
    }
}
