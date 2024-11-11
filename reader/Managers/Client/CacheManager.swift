//
//  CacheManager.swift
//  Reader
//
//  Created by Krina on 10/11/24.
//

import Cache
import XCGLogger

class CacheManager {
    private var storage: Storage<String, [Articles]>!
    private let logger = XCGLogger.default
    
    init() {
        let diskConfig = DiskConfig(name: "ArticleCache", expiry: .seconds(604800)) // Set cache expiry to 7 days for automatic cleanup
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
        
        do {
            storage = try Storage<String, [Articles]>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: [Articles].self)
            )
            logger.info("Cache initialized successfully with configurations.")
        } catch {
            logger.error("Failed to initialize cache storage: \(error.localizedDescription)")
        }
    }
    
    /// Saves articles to cache.
    func saveArticles(_ articles: [Articles]) {
        do {
            try storage.setObject(articles, forKey: "articles")
            logger.info("Articles saved to cache successfully.")
        } catch {
            logger.error("Failed to save articles to cache: \(error.localizedDescription)")
        }
    }
    
    /// Loads articles from cache.
    func loadArticles() -> [Articles]? {
        do {
            let articles = try storage.object(forKey: "articles")
            logger.info("Articles loaded from cache successfully.")
            return articles
        } catch {
            logger.warning("No cached articles found or failed to load articles: \(error.localizedDescription)")
            return nil
        }
    }
}
