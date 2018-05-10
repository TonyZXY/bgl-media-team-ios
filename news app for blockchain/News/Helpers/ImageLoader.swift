//
//  ImageLoader.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {
    
    static let instance = ImageLoader()
    
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(imageURL:String) -> UIImage{
        var image:UIImage? = nil
        let url = URL(string: imageURL)
        if let imageFromCache = imageCache.object(forKey: imageURL as AnyObject) as? UIImage{
            image = imageFromCache
        }else{
            do{
                image = try UIImage(data: Data(contentsOf: url!))!
            }catch let err{
                print(err)
            }
            imageCache.setObject(image!, forKey: imageURL as AnyObject)
        }
        
        return image!
    }
}

