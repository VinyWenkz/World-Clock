//
//  DetailViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var cityWebView: UIWebView!
    
    var cityUrlRequest: NSURLRequest? {
        didSet {
            refreshCityWebView()
        }
    }
    
    
    func refreshCityWebView() {
        if let urlRequest = self.cityUrlRequest {
            if let webView = self.cityWebView {
                webView.loadRequest(urlRequest)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.refreshCityWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

