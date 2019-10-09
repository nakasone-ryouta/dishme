


import UIKit
import Photos

class CameraRollCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var checkbox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoImageView.image = nil
        
        self.checkbox.image = nil
    }
    
    // 画像を表示する
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        manager.requestImage(for: assets,
                             targetSize: frame.size,
                             contentMode: .aspectFit,
                             options: nil,
                             resultHandler: { [weak self] (image, info) in
                                guard let wself = self, let _ = image else {
                                    return
                                }
                                wself.photoImageView.image = image
        })
    }
}
