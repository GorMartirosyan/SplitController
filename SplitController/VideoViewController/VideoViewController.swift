//
//  VideoViewController.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    var array = [Video]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
        } else {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
        }
    }
    
}

extension VideoViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else { return VideoCollectionViewCell() }
        cell.setUp(with: array[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, delay: 0.1, options: UIView.AnimationOptions.curveEaseInOut) {
                self.imageTapped(int: indexPath.row)
            }
        }
        
    }
    
    func imageTapped(int: Int){
        
        let youtubeIdString = array[int].youtubeId
        let youtubeUrl = "https://www.youtube.com/watch?v="
        var webView: WKWebView?
        let webViewConfig = WKWebViewConfiguration()
        
        webViewConfig.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: self.view.frame, configuration: webViewConfig)
        
        self.view.addSubview(webView!)
        
        let myURL = URL(string: youtubeUrl + youtubeIdString)
        let youtubeRequest = URLRequest(url: myURL!)
        
        webView!.load(youtubeRequest)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}
