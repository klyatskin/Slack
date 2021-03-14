//
//  SearchCache.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation

class SearchCache {
    
    
    typealias SearchCacheType = [String: Data]
    
    static let shared = SearchCache()
    private var cache: SearchCacheType = [:]
    
    
    private var cacheFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("searchCache.plist")
    }

    
    private init() {
        cache = NSKeyedUnarchiver.unarchiveObject(withFile: cacheFilePath.path) as? SearchCacheType ?? [:]
    }
    
    
    func reset() {
        cache = [:]
    }

    func swap() {
        NSKeyedArchiver.archiveRootObject(cache, toFile: cacheFilePath.path)
    }
    
    
    func cached(for query: String) -> Data? {
        return cache[query.lowercased()]
    }

    
    func cache(_ query: String, data: Data) {
        cache[query.lowercased()] = data
    }
}
