//
//  ViewController.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/12/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBlue
        
        // 간단한 Repository 테스트
                testRepository()
            }
            
            private func testRepository() {
                print("=== Repository 테스트 시작 ===")
                
                // Repository 생성
                let jsonService = JSONDataServiceImp()
                let repository = BookRepositoryImp(jsonDataService: jsonService)
                
                // 데이터 로드 테스트
                let result = repository.loadBooks()
                
                switch result {
                case .success(let books):
                    print("✅ 성공! 로드된 책 수: \(books.count)")
                    
                    // 첫 번째 책 정보 출력
                    if let firstBook = books.first {
                        print("📖 첫 번째 책:")
                        print("   제목: \(firstBook.title)")
                        print("   저자: \(firstBook.author)")
                        print("   페이지: \(firstBook.pages)")
                        print("   출간일: \(DateFormatter.longDateFormatter.string(from: firstBook.releaseDate))")
                        print("   챕터 수: \(firstBook.chapters.count)")
                        print("   첫 번째 챕터: \(firstBook.chapters.first ?? "없음")")
                        print("   요약 길이: \(firstBook.summary.count)자")
                    }
                    
                case .failure(let error):
                    print("❌ 실패: \(error)")
                    
                    // 에러 타입별 처리
                    switch error {
                    case .fileNotFound:
                        print("💡 해결방법: data.json 파일이 Bundle에 포함되어 있는지 확인하세요")
                    case .decodingFailed(let decodingError):
                        print("💡 JSON 구조 확인: \(decodingError)")
                    case .loadingFailed(let underlyingError):
                        print("💡 기타 에러: \(underlyingError)")
                    case .emptyData:
                        print("💡 데이터가 비어있습니다")
                    }
                }
                
                print("=== Repository 테스트 종료 ===\n")
            }
}
