//
//  APIService.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import SwiftyJSON
import Alamofire
import RealmSwift

class APIService: NSObject {
    static let shardInstance = APIService()
    
    
    let realm = try! Realm()
    //var newsResults = try! Realm().objects(News.self)
    //var newsResults = try! Realm().objects(News.self).sorted(byKeyPath: "_id", ascending: false)
    
    func fetchLocalNews(completion: @escaping (Results<News>) -> ()){
//        print(realm.configuration.fileURL ?? "")
        //国内
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E5%86%85", method: .get).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeNewsJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "国内"
                    let result = try! Realm().objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("localeTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
            
            
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([News].self, from: data)
//                    // to be implement realm action
//                    //self.realm.beginWrite()
//
//                    //if realm.object(ofType: newsList., forPrimaryKey: ) == nil{}
//
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
            
            
            //            switch response.result{
            //            case .success( _): break
            //                //let json = JSON(value)
            //                //self.JSONtoData(json: json)
            //                DispatchQueue.main.async {
            //                 //print("loading data")
            //                }
            //            case .failure(let error):
            //                print(error)
            //            }
            
            //            if let data = response.data {
            //                do{
            //                    let newsList = try JSONDecoder().decode([News].self, from: data)
            //                    // to be implement realm action
            //                    completion(newsList)
            //                } catch let jsonErr{
            //                    print(jsonErr)
            //                }
            //            }
        }
    }
    
    func fetchInternationalNews(completion: @escaping (Results<News>) -> ()){
        //国际
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E9%99%85").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeNewsJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "国际"
                    let result = try! Realm().objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("localeTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
            
            
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([News].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
    func fetchNewsContentTypeOne(completion: @escaping (Results<News>) -> ()){
        //深度
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E6%B7%B1%E5%BA%A6").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeNewsJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "深度"
                    let result = try! Realm().objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("contentTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
            
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([News].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
    func fetchNewsContentTypeTwo(completion: @escaping (Results<News>) -> ()){
        //趋势
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E8%B6%8B%E5%8A%BF").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeNewsJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "趋势"
                    let result = try! Realm().objects(News.self).sorted(byKeyPath: "_id", ascending: false).filter("contentTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
            
            
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([News].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
//
//    func fetchNewsContentTypeThree(completion: @escaping ([News]) -> ()){
//        Alamofire.request("http://10.10.6.111:3000/api/news").responseJSON { response in
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([News].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
//        }
//    }
    
    
    func fetchGenuineContentTypeOne(completion: @escaping (Results<Genuine>) -> ()){
        //原创文章
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E5%8E%9F%E5%88%9B%E6%96%87%E7%AB%A0").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeGenuineJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "原创文章"
                    let result = try! Realm().objects(Genuine.self).sorted(byKeyPath: "_id", ascending: false).filter("genuineTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
    func fetchGenuineContentTypeTwo(completion: @escaping (Results<Genuine>) -> ()){
        //百科
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E7%99%BE%E7%A7%91").responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeGenuineJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "百科"
                    let result = try! Realm().objects(Genuine.self).sorted(byKeyPath: "_id", ascending: false).filter("genuineTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
            
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
    func fetchGenuineContentTypeThree(completion: @escaping (Results<Genuine>) -> ()){
        //分析
        Alamofire.request("http://10.10.6.111:3000/api/getgenuine?genuineTag=%E5%88%86%E6%9E%90").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeGenuineJSON(json: json)
                DispatchQueue.main.async {
                    let tag = "分析"
                    let result = try! Realm().objects(Genuine.self).sorted(byKeyPath: "_id", ascending: false).filter("genuineTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
//    func fetchGenuineContentTypeFour(completion: @escaping ([Genuine]) -> ()){
//        Alamofire.request("http://10.10.6.111:3000/api/news").responseJSON { response in
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([Genuine].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
//        }
//    }
    
    func fetchVideo(completion: @escaping (Results<Video>) -> ()){
        Alamofire.request("http://10.10.6.111:3000/api/videos").responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                self.decodeVideoJSON(json: json)
                DispatchQueue.main.async {
//                    let tag = "分析"
                    let result = try! Realm().objects(Video.self).sorted(byKeyPath: "_id", ascending: false)
//                        .filter("localeTag = %@",tag)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
//            if let data = response.data {
//                do{
//                    let newsList = try JSONDecoder().decode([Video].self, from: data)
//                    // to be implement realm action
//                    completion(newsList)
//                } catch let jsonErr{
//                    print(jsonErr)
//                }
//            }
        }
    }
    
    //    private func JSONtoData(json: JSON){
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "MMM d, yyyy, h:ma"
    //        realm.beginWrite()
    //        if let collection = json[].array{
    //            for item in collection {
    //                let date = dateFormatter.date(from: item["publishedTime"].string!)
    //                let _id = "\(item["id"].string!)"
    //                if realm.object(ofType: News.self, forPrimaryKey: _id) == nil {
    //                    realm.create(News.self, value: [_id, item["title"].string, item["newsDescription"].string, item["imageURL"].string, item["detail"].string, item["publishedTiem"].string, item["author"].string, item["localeTag"].string, item["contentTag"].string])
    //
    //                }
    //            }
    //        }
    //
    //    }
    
    func decodeNewsJSON(json: JSON){
        realm.beginWrite()
        if let collection = json.array{
            for item in collection {
                let id = item["_id"].string!
                let title = item["title"].string!
                let newsDescription = item["newsDescription"].string!
                let imageURL = item["imageURL"].string!
                let detail = item["detail"].string!
                let publishedTime = item["publishedTime"].string!.timeFormatter()
                let author = item["author"].string!
                let localeTag = item["localeTag"].string!
                let contentTag = item["contentTag"].string!
                
                if realm.object(ofType: News.self, forPrimaryKey: id) == nil {
                    realm.create(News.self, value: [id,title,newsDescription,imageURL,detail,publishedTime,author,localeTag,contentTag])
                } else {
                    realm.create(News.self, value: [id,title,newsDescription,imageURL,detail,publishedTime,author,localeTag,contentTag], update: true)
                }
            }
        }
        try! realm.commitWrite()
    }
    
    func decodeGenuineJSON(json: JSON){
        realm.beginWrite()
        if let collection = json.array{
            for item in collection {
                let id = item["_id"].string!
                let title = item["title"].string!
                let genuineDescription = item["genuineDescription"].string!
                let imageURL = item["imageURL"].string!
                let detail = item["detail"].string!
                let publishedTime = item["publishedTime"].string!.timeFormatter()
                let author = item["author"].string!
                let genuineTag = item["genuineTag"].string!
                
                if realm.object(ofType: Genuine.self, forPrimaryKey: id) == nil {
                    realm.create(Genuine.self, value: [id, title, genuineDescription, imageURL, detail, publishedTime, author, genuineTag])
                }else {
                    realm.create(Genuine.self, value: [id, title, genuineDescription, imageURL, detail, publishedTime, author, genuineTag], update: true)
                }
            }
        }
        try! realm.commitWrite()
    }
    
    func decodeVideoJSON(json: JSON){
        realm.beginWrite()
        if let collection = json.array{
            for item in collection {
                let id = item["_id"].string!
                let title = item["title"].string!
                let videoDescription = item["videoDescription"].string!
                let imageURL = item["imageURL"].string!
                let url = item["url"].string!
                let publishedTime = item["publishedTime"].string!.timeFormatter()
                let author = item["author"].string!
                let localeTag = item["localeTag"].string!
                let typeTag = item["typeTag"].string!
                
                if realm.object(ofType: Video.self, forPrimaryKey: id) == nil {
                    realm.create(Video.self, value: [id, title, videoDescription, imageURL, url, publishedTime, author, localeTag, typeTag])
                }else {
                    realm.create(Video.self, value: [id, title, videoDescription, imageURL, url, publishedTime, author, localeTag, typeTag], update: true)
                }
            }
        }
        try! realm.commitWrite()
    }
    
}
