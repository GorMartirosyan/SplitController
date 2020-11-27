//
//  GalleryViewController.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit
import Foundation

class GalleryViewController: UIViewController {
    
    var array = [Gallery]()
    var newImageView = UIImageView()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newImageView.frame = view.bounds
        newImageView.contentMode = .scaleAspectFit
        
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

extension GalleryViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
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
        let data = try? Data(contentsOf: array[int].contentUrl)
        newImageView = UIImageView(image: UIImage(data: data!))
        newImageView.frame = self.view.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.frame.width, height: 20)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.numberOfLines = 0
        label.text = array[int].title
        label.sizeToFit()
        newImageView.addSubview(label)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        view.setNeedsLayout()
    }
}
