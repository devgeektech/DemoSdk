//
//  DemoClass.swift
//  SdkDemo
//
//  Created by Geek Tech on 15/05/24.
//

import Foundation
import UIKit
import WebKit

public class CustomWebViewController: UIViewController {
    private var webView: WKWebView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    public func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    public func showCustomWebView(from viewController: UIViewController, withURL url: URL) {
        let customWebVC = CustomWebViewController()
        customWebVC.load(url: url)
        viewController.present(customWebVC, animated: true, completion: nil)
    }
}



