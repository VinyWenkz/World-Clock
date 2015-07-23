//
//  DetailViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var defaultDescriptionLabel: UILabel!
    @IBOutlet weak var cityWebView: UIWebView!
    
    @IBOutlet var webViewActivityIndicator: UIActivityIndicatorView!
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
        
        self.cityWebView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.webViewActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webViewActivityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.webViewActivityIndicator.stopAnimating()
        var alert = UIAlertView(title: NSLocalizedString("NOT_CONNECTED_TO_THE_INTERNET", comment: "Not Connected to the Internet"),
            message: NSLocalizedString("CHECK_YOUR_INTERNET_CONNECTION", comment: "Please check your internet connection"), delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: "OK"))
        alert.show()
        self.cityWebView.hidden = true
    }

}

