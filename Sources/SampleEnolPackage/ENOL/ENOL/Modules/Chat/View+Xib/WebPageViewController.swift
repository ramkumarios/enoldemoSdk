//
//  WebPageViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 20/02/23.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    @IBOutlet weak var webView_: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: intial Setup
    func initialSetup(){
//        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.webView_.frame.size.height))
//            self.view.addSubview(webView)
//            let url = URL(string: "https://webchat.enol.ai/")
//        webView_.load(URLRequest(url: url!))
        
        
        let url = URL(string: "https://webchat.enol.ai/")
        let requestObj = URLRequest(url: url! as URL)
        webView_.load(requestObj)
    }
    
    //MARK: button
    @IBAction func backBtn_Tapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }


}
