//
//  TableViewCell.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private var imageLoadedObserver: Any?
    private var url: URL?
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.sizeToFit()
        imageLoadedObserver = NotificationCenter.default.addObserver(forName: ImageCache.Notification.name, object: nil, queue: .main, using: imageLoaded(_:))
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        categoryLabel.text = ""
        dateLabel.text = ""
        imgView.image = nil
    }
    
    func setUp(with data: Metadata) {
        titleLabel.text = data.title
        categoryLabel.text = data.category
        dateLabel.text = timeStampToString(int: data.date)
        url = data.coverPhotoUrl
        imgView.image = ImageCache.shared.image(for: data.coverPhotoUrl)
    }
    
    private func imageLoaded(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageUrl = userInfo[ImageCache.Notification.url] as? URL, url == imageUrl else { return }
        imgView.image = userInfo[ImageCache.Notification.image] as? UIImage
    }
}
