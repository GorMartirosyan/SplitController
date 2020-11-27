//
//  CollectionViewCell.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private var imageLoadedObserver: Any?
    private var url: URL?
    
    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLoadedObserver = NotificationCenter.default.addObserver(forName: ImageCache.Notification.name, object: nil, queue: .main, using: imageLoaded(_:))
    }
    
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    func setUp(with data: Gallery) {
        url = data.thumbnailUrl
        imgView.image = ImageCache.shared.image(for: data.thumbnailUrl)
    }
    
    private func imageLoaded(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageUrl = userInfo[ImageCache.Notification.url] as? URL, url == imageUrl else { return }
        imgView.image = userInfo[ImageCache.Notification.image] as? UIImage
    }
}
