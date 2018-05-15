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
    
    func fetchLocalNews(completion: @escaping ([News]) -> ()){
        //国内
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E5%86%85", method: .get).validate().responseJSON { response in
            if let data = response.data {
                do{
                        let newsList = try JSONDecoder().decode([News].self, from: data)
                        // to be implement realm action
                        //self.realm.beginWrite()
                    
                        //if realm.object(ofType: newsList., forPrimaryKey: ) == nil{}
                    
                        completion(newsList)
                        } catch let jsonErr{
                        print(jsonErr)
                        }
                }
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
    
    func fetchInternationalNews(completion: @escaping ([News]) -> ()){
        //国际
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E9%99%85").responseJSON { response in
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
    
    func fetchNewsContentTypeOne(completion: @escaping ([News]) -> ()){
        //时事
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E6%B7%B1%E5%BA%A6").responseJSON { response in
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
    
    func fetchNewsContentTypeTwo(completion: @escaping ([News]) -> ()){
        //消息
        Alamofire.request("http://10.10.6.111:3000/api/getNewsContentOnly?contentTag=%E8%B6%8B%E5%8A%BF").responseJSON { response in
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
    
}
