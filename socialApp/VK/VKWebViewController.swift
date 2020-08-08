//
//  VKWebViewController.swift
//  socialApp
//
//  Created by Александр Минк on 22.06.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKWebViewController: UIViewController {

    

    @IBOutlet weak var vkWebView: WKWebView!{
        didSet{
            vkWebView.navigationDelegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7519274"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        let request = URLRequest(url: urlComponents.url!)

        vkWebView.load(request)
        
        
        
    }

    
    
}




extension VKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        Session.instance.token = token!
        
        
        //getFriends(5)
//        getProfilePhotos(5)
//        getGroups(5)
//        getGroupsBySearch("Music", 3)
        
        decisionHandler(.cancel)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarControl") as! UITabBarController
        self.present(vc, animated: true, completion: nil)

    }
}





func getProfilePhotos(_ count: Int) {
    AF.request("https://api.vk.com/method/photos.get?album_id=profile&count=\(count)&photo_sizes=1&access_token=\(Session.instance.token)&v=5.110").responseJSON { (response) in
        print(response)
    }
}



func getGroupsBySearch(_ search: String,_ count: Int) {
    AF.request("https://api.vk.com/method/groups.search?q=\(search)&count=\(count)&access_token=\(Session.instance.token)&v=5.110").responseJSON { (response) in
        print(response)
    }
}
