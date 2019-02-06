//
//  ImageLoader.swift
//  ProjectName
//
//  Created by AuthorName.
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//

import Foundation
//import Nuke
//
//class ImageLoader {
//    
//    static let shared = ImageLoader()
//    
//    // デフォルトのキャッシュ設定
//    static var defaultConfig: URLSessionConfiguration {
//        let config = URLSessionConfiguration.default
//        let urlCache = Nuke.DataLoader.sharedUrlCache
//        
//        // `expires → max-age` の順にキャッシュを確認する
//        config.urlCache = MoreCache(memoryCapacity: urlCache.memoryCapacity, diskCapacity: urlCache.diskCapacity, diskPath: "")
//        
//        // NOTE: NSURLRequestReturnCacheDataElseLoad
//        // 有効期限または有効期限に関係なく既存のキャッシュデータを使用して要求を満たす必要があることを指定。
//        // 要求に対応するキャッシュに既存のデータがない場合、データは元のソースからロードされる。
//        config.requestCachePolicy = .returnCacheDataElseLoad
//        return config
//    }
//    
//    // キャッシュ設定を反映した Nuke.Manager
//    let nuke = { () -> Nuke.Manager in
//        let loader = Nuke.Loader(loader: Nuke.DataLoader(configuration: defaultConfig))
//        return Nuke.Manager(loader: loader, cache: Cache.shared)
//    }()
//}
