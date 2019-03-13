//
//  PhotoApp.swift
//  PhotoAppIos
//
//  Created by Даниил Батаев on 07/03/2019.
//  Copyright © 2019 Codemonx. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {
    private let webView = WKWebView(frame: UIScreen.main.bounds)

    override func loadView() {
        view = webView
    }

    func loadRequest(with apiKey: String) {
        guard let url = URL(string: "http://dev-appinapp-photos-app.s3-website-us-east-1.amazonaws.com/?apiKey=\(apiKey)")  else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

public class PhotoApp {

    static public func open(with apiKey: String) {
        guard let viewController = UIApplication.shared.keyWindow!.rootViewController else { return }

        let webViewContainerViewController = WebViewContainerViewController()
        webViewContainerViewController.loadRequest(with: apiKey)
        viewController.present(webViewContainerViewController, animated: true)
    }

    static public func close() {
        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        topViewController.dismiss(animated: true)
    }
}