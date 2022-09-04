//
//  PostAPI.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 29/01/1444 AH.
//

import Foundation
import SwiftyJSON
import Alamofire
class PostAPI: API{
  
    static func GetAllPosts(page:Int,tag:String?,completionHandler:@escaping ([Post],Int) -> ()){
        var postUrl = "\(baseUrl)/post"
        if var thetag = tag{
            thetag = thetag.trimmingCharacters(in: .whitespaces)
            postUrl = "\(baseUrl)/tag/\(thetag)/post"//if there is tag this url will be enabled
            
        }
    
        let params = ["page":"\(page)"]
        
        
        AF.request(postUrl,parameters: params,encoder: URLEncodedFormParameterEncoder.default,headers: headers).responseJSON { res in
      
        let jsonData = JSON(res.value)
        let data = jsonData["data"]
            let total = jsonData["total"].intValue
        let decoder = JSONDecoder()
        
        do {
            let posts =  try decoder.decode([Post].self, from: data.rawData())//fill the post array with the info i will get
            
            completionHandler(posts,total) //func that will called in this class that will do things in the other class
         
        }catch let Error{
            print(Error)
        }
        
    }
    
  }
    
    
    static func AddNewPost(text:String,userId:String,completionHandler:@escaping () -> ()){
        let userUrl = "\(baseUrl)/post/create"
        let params = [
            "owner":userId,
            "text":text
            
        ]
        
        AF.request(userUrl,method :.post,parameters: params,encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { res in
            switch res.result{
            case .success:
                    completionHandler()
            case .failure(let error):
                print(error)
            }
            
        }

        
    }
    
    static func GetPostComments(postid:String,completionHandler:@escaping ([Comment]) -> ()){
        let commentsUrl = "\(baseUrl)/post/\(postid)/comment"
        
        AF.request(commentsUrl,headers: headers).responseJSON { res in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
        
            let decoder = JSONDecoder()
            
            do {
                let comments =  try decoder.decode([Comment].self, from: data.rawData())//fill the post array with the info i will get
               completionHandler(comments)
              
            }catch let Error{
                print(Error)
            }
        }
        
        
        
    }
    
    
    
    
    static func AddNewComment(postId:String,userId:String,message:String,completionHandler:@escaping () -> ()){
        let userUrl = "\(baseUrl)/comment/create"
        let params = [
            "post":postId,
            "message":message,
            "owner":userId
            
        ]
        
        AF.request(userUrl,method :.post,parameters: params,encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { res in
            switch res.result{
            case .success:
                    completionHandler()
            case .failure(let error):
                print(error)
            }
            
        }

        
    }
    
    
    
    
    static func GetAllTags(completionHandler:@escaping ([String]) -> ()){
        //the return value gonna be array of string
    let tagUrl = "\(baseUrl)/tag"
   
    
    AF.request(tagUrl,headers: headers).responseJSON { res in
      
        let jsonData = JSON(res.value)
        var data = jsonData["data"]
       data.arrayObject?.remove(at: 0)//to delete index from json array
    
        let decoder = JSONDecoder()
        
        do {
            let tags =  try decoder.decode([String].self, from: data.rawData())//fill the string array with the info i will get
            
            completionHandler(tags) //func that will called in this class that will do things in the other class
         
        }catch let Error{
            print(Error)
        }
        
    }
    
  }
    
    
}



