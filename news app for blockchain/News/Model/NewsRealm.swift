//
//  NewsRealm.swift
//  news app for blockchain
//
//  Created by Rock on 14/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import RealmSwift

final class NewsRealm: Object {
    @objc dynamic var _id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var newsDescription: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var publishedTime: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var localeTag: String = ""
    @objc dynamic var contentTag: String = ""
    override static func primaryKey() -> String? {
        return "_id"
    }
}

extension News: PersistableNews {
   public init(managedObject: NewsRealm) {
        _id = managedObject._id
        title = managedObject.title
        newsDescription = managedObject.newsDescription
        imageURL = managedObject.imageURL
        detail = managedObject.detail
        publishedTime = managedObject.publishedTime
        author = managedObject.author
        localeTag = managedObject.localeTag
        contentTag = managedObject.contentTag
    }
    public func managedObject() -> NewsRealm {
        let news = NewsRealm()
        news._id = _id ?? ""
        news.title = title ?? ""
        news.newsDescription = newsDescription ?? ""
        news.imageURL = imageURL ?? ""
        news.detail = detail ?? ""
        news.publishedTime = publishedTime ?? ""
        news.author = author ?? ""
        news.localeTag = localeTag ?? ""
        news.contentTag = contentTag ?? ""
        return news
    }
}
