//
//  DetailViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var defaultDescriptionLabel: UILabel!
    @IBOutlet weak var cityWebView: UIWebView!
    
    var cityUrlRequest: NSURLRequest? {
        didSet {
            refreshCityWebView()
        }
    }
    
    
    func refreshCityWebView() {
        if let urlRequest = self.cityUrlRequest {
            if let webView = self.cityWebView {
                self.cityWebView.hidden = false
                webView.loadRequest(urlRequest)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        if cityUrlRequest == nil {
            self.cityWebView.hidden = true
        } else {
            self.refreshCityWebView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

