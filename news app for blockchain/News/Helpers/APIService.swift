//
//  APIService.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import Alamofire

class APIService: NSObject {
    static let shardInstance = APIService()
    
    func fetchLocalNews(completion: @escaping ([News]) -> ()){
        //国内
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E5%86%85", method: .get).validate().responseJSON { response in
            if let data = response.data {
                print(data)
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
    func fetchInternationalNews(completion: @escaping ([News]) -> ()){
        //国际
        Alamofire.request("http://10.10.6.111:3000/api/getNewsLocaleOnly?localeTag=%E5%9B%BD%E9%99%85").responseJSON { response in
            if let data = response.data {
                print(data)
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
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
                print(data)
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
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
                print(data)
                do{
                    let newsList = try JSONDecoder().decode([News].self, from: data)
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
                    print(data)
                    completion(newsList)
                } catch let jsonErr{
                    print(jsonErr)
                }
            }
        }
    }
    
}
