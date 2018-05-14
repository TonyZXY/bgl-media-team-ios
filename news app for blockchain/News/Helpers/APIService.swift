//
//  APIService.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class APIService: NSObject {
    static let shardInstance = APIService()
    
    let realm = try! Realm()
    
    
    
    func fetchLocalNews(completion: @escaping (Results<News>) -> ()){
        //国内
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E5%86%85", method: .get).validate().responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    // to be implement realm action
                    self.realm.beginWrite()
                    for news in newsList {
                        if self.realm.object(ofType: News.self, forPrimaryKey: news._id) == nil{
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime])
                        } else {
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime], update: true)
                        }
                    }
                    try! self.realm.commitWrite()
                    let tag = "国内"
                    let newsListToView = try! self.realm.objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("localeTag == %@",tag)
                    print(newsListToView.count)
                    completion(newsListToView)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchInternationalNews(completion: @escaping (Results<News>) -> ()){
        //国际
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E9%99%85").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    self.realm.beginWrite()
                    for news in newsList {
                        if self.realm.object(ofType: News.self, forPrimaryKey: news._id) == nil{
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime])
                        } else {
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime], update: true)
                        }
                    }
                    try! self.realm.commitWrite()
                    
                    let tag = "国际"
                    let newsListToView = try! self.realm.objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("localeTag == %@",tag)
                    // to be implement realm action
                    completion(newsListToView)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchNewsContentTypeOne(completion: @escaping (Results<News>) -> ()){
        //深度
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E6%B7%B1%E5%BA%A6").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    self.realm.beginWrite()
                    for news in newsList {
                        if self.realm.object(ofType: News.self, forPrimaryKey: news._id) == nil{
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime])
                        } else {
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime], update: true)
                        }
                    }
                    try! self.realm.commitWrite()
                    
                    let tag = "深度"
                    let newsListToView = try! self.realm.objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("contentTag == %@",tag)
                    // to be implement realm action
                    completion(newsListToView)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchNewsContentTypeTwo(completion: @escaping (Results<News>) -> ()){
        //趋势
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E8%B6%8B%E5%8A%BF").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    self.realm.beginWrite()
                    for news in newsList {
                        if self.realm.object(ofType: News.self, forPrimaryKey: news._id) == nil{
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime])
                        } else {
                            self.realm.create(News.self, value: [news._id,news.author,news.contentTag,news.detail,news.imageURL,news.localeTag,news.newsDescription,news.publishedTime], update: true)
                        }
                    }
                    try! self.realm.commitWrite()
                    
                    let tag = "趋势"
                    let newsListToView = try! self.realm.objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("contentTag == %@",tag)
                    // to be implement realm action
                    completion(newsListToView)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchNewsContentTypeThree(completion: @escaping ([News]) -> ()){
        Alamofire.request("http://10.10.6.111:3000/api/news").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    
    func fetchGenuineContentTypeOne(completion: @escaping ([Genuine]) -> ()){
        //原创文章
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E5%8E%9F%E5%88%9B%E6%96%87%E7%AB%A0").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchGenuineContentTypeTwo(completion: @escaping ([Genuine]) -> ()){
        //百科
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E7%99%BE%E7%A7%91").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchGenuineContentTypeThree(completion: @escaping ([Genuine]) -> ()){
        //分析
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E5%88%86%E6%9E%90").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchGenuineContentTypeFour(completion: @escaping ([Genuine]) -> ()){
        Alamofire.request("http://10.10.6.111:3000/api/news").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchVideo(completion: @escaping ([Video]) -> ()){
        Alamofire.request("http://10.10.6.111:3000/api/videos").responseJSON { response in
            if let data = response.data {
                do{
                    let newsList = try JSONDecoder().decode([Video].self, from: data)
                    // to be implement realm action
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
}
