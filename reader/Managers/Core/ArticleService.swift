//
//  ArticleService.swift
//  reader
//
//  Created by Krina on 10/11/24.
//


import Alamofire
import XCGLogger

class ArticleService {
    private static let logger = XCGLogger.default
    private static let articlesURL = "https://mocki.io/v1/e91eafa6-46f7-4bd1-87f7-2770c7b7e194"

    /// Fetches articles from the specified API.
    /// - Parameter completion: Completion handler with `Result` type containing either the `ArticleResponse` on success or an `Error` on failure.
    static func fetchArticles(completion: @escaping (Result<ArticleResponse, Error>) -> Void) {
        logger.info("Initiating request to fetch articles from \(articlesURL)")
        
        AF.request(articlesURL).validate().responseDecodable(of: ArticleResponse.self) { response in
            switch response.result {
            case .success(let articleResponse):
                logger.info("Successfully fetched \(articleResponse.articles?.count ?? 0) articles")
                completion(.success(articleResponse))
                
            case .failure(let error):
                handleFetchError(error)
                completion(.failure(error))
            }
        }
    }

    /// Logs an error with detailed information if the article fetch fails.
    /// - Parameter error: The `Error` object describing the failure.
    private static func handleFetchError(_ error: Error) {
        let afError = error as? AFError
        logger.error("Failed to fetch articles: \(afError?.errorDescription ?? error.localizedDescription)")
        
        if let responseCode = afError?.responseCode {
            logger.error("Response Code: \(responseCode)")
        }
    }
}
