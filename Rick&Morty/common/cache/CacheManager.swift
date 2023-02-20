//
//  CacheManager.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 19.02.2023.
//

import Foundation

protocol ImageCacheProtocol: AnyObject {
    func getImageData(urlString: String) -> Data?
    func insertImageData(_ imageData: Data?, urlString: String)
    func removeImageData(urlString: String)
}

final class CacheManager {
    private lazy var cache: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension CacheManager: ImageCacheProtocol {
    func getImageData(urlString: String) -> Data? {
        lock.lock(); defer { lock.unlock() }
        return cache.object(forKey: urlString as NSString) as? Data
    }
    
    func insertImageData(_ imageData: Data?, urlString: String) {
        guard let imageData = imageData else { return removeImageData(urlString: urlString) }
        
        lock.lock(); defer { lock.unlock() }
        cache.setObject(NSData(data: imageData), forKey: urlString as NSString)
    }
    
    func removeImageData(urlString: String) {
        lock.lock(); defer { lock.unlock() }
        cache.removeObject(forKey: urlString as NSString)
    }
}
