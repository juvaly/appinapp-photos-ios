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

class WebViewContainerViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    private  var webView: WKWebView?
    private let nameHandleCloseApp = "close"
    
    convenience init( ) {
        self.init(nibName:nil, bundle:nil)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        userContentController.add(self, name: nameHandleCloseApp)
        
        config.userContentController = userContentController
        
        
        self.webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
    }
    
    override func loadView() {
        webView?.navigationDelegate = self
        view = webView
    }
    
    func loadRequest(with apiKey: String, showChat: Bool) {
        guard let url = URL(string: "https://www.stickies.co.il\(showChat ? "/chat" : "")/?apiKey=\(apiKey)&deviceId=\(UIDevice.current.identifierForVendor!.uuidString)")  else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        let alert = UIAlertController(title: "No Internet connection. Please try again later!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == nameHandleCloseApp, let messageBody = message.body as? String {
            if (messageBody == "close") {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

public class PhotoApp {
    static private func _open(with apiKey: String, showChat: Bool = false) {
        guard let viewController = UIApplication.shared.keyWindow!.rootViewController else { return }
        
        let webViewContainerViewController = WebViewContainerViewController()
        webViewContainerViewController.loadRequest(with: apiKey, showChat: showChat)
        viewController.present(webViewContainerViewController, animated: true)
    }
    
    static public func open(with apiKey: String) {
        PhotoApp._open(with: apiKey)
    }
    
    static public func showChat(with apiKey: String) {
        PhotoApp._open(with: apiKey, showChat: true)
    }
    
    static public func close() {
        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        topViewController.dismiss(animated: true)
    }
}
