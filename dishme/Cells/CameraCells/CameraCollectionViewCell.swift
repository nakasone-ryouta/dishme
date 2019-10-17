import Foundation
import UIKit

// CollectionViewのセル設定
class CameraCollectionViewCell: UICollectionViewCell {
    
    //商品イメージ
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowRadius = 4
        return imageView
    }()
    
    //商品イメージ
    let deleteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 87, y: -13, width: 25, height: 25)
        button.setImage(UIImage(named: "deleteimage"), for: .normal)
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImageView.image = nil
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(deleteButton)
    }
    
    func setUpContents(image: UIImage) {
        cellImageView.image = image
    }
}
