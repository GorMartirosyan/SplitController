//
//  VideoCollectionViewCell.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    private var imageLoadedObserver: Any?
    private var url: URL?
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLoadedObserver = NotificationCenter.default.addObserver(forName: ImageCache.Notification.name, object: nil, queue: .main, using: imageLoaded(_:))
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        titleLabel.text = ""
    }
    
    func setUp(with data: Video) {
        url = data.thumbnailUrl
        imgView.image = ImageCache.shared.image(for: data.thumbnailUrl)
        titleLabel.text = data.title
    }
    
    private func imageLoaded(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageUrl = userInfo[ImageCache.Notification.url] as? URL, url == imageUrl else { return }
        imgView.image = userInfo[ImageCache.Notification.image] as? UIImage
    }
}
