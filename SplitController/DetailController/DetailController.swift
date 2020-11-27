//
//  DetailController.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class DetailController: UIViewController {
    
    var data : Metadata?
    
    private var imageLoadedObserver: Any?
    private var url: URL?
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var txtView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var galleryButton: UIButton!
    @IBOutlet var videosButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryButton.isHidden = true
        videosButton.isHidden = true
        dateLabel.text = ""
        
        navigationItem.title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpDetail()
        imageLoadedObserver = NotificationCenter.default.addObserver(forName: ImageCache.Notification.name, object: nil, queue: .main, using: imageLoaded(_:))
    }
    
    func setUpDetail() {
        titleLabel.text = data?.title
        titleLabel.sizeToFit()
        txtView.text = data?.body.html2String
        txtView.sizeToFit()
        txtView.isScrollEnabled = false
        txtView.isEditable = false
        categoryLabel.text = data?.category
        galleryButton.titleLabel?.numberOfLines = 1
        galleryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        galleryButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        videosButton.titleLabel?.numberOfLines = 1
        videosButton.titleLabel?.adjustsFontSizeToFitWidth = true
        videosButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        url = data?.coverPhotoUrl
        guard let imageUrl = data?.coverPhotoUrl else {return}
        imgView.image = ImageCache.shared.image(for: imageUrl)
        guard let dateInt = data?.date else {return}
        dateLabel.text = timeStampToString(int: dateInt)
        if (data?.gallery) != nil {
            galleryButton.isHidden = false
        }else {
            galleryButton.isHidden = true
        }
        if (data?.video) != nil {
            videosButton.isHidden = false
        } else {
            videosButton.isHidden = true
        }
    }
    
    @IBAction func galleryButtonPressed(_ sender: Any) {
        let Storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let gallerVC = Storyboard.instantiateViewController(identifier: "GalleryViewController") as! GalleryViewController
        gallerVC.array = (data?.gallery)!
        
        self.navigationController?.pushViewController(gallerVC, animated: true)
    }
    
    @IBAction func videosButtonPressed(_ sender: Any) {
        let Storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let videoVC = Storyboard.instantiateViewController(identifier: "VideoViewController") as! VideoViewController
        videoVC.array = (data?.video)!
        
        self.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    private func imageLoaded(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageUrl = userInfo[ImageCache.Notification.url] as? URL, url == imageUrl else { return }
        imgView.image = userInfo[ImageCache.Notification.image] as? UIImage
    }
    
}
