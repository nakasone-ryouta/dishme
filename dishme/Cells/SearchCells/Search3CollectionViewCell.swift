import UIKit
// CollectionViewのセル設定
class Search3CollectionViewCell: UICollectionViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(cellImageView)
    }
    
    func setUpContents(image: UIImage , size: Int) {
        cellImageView.image = image
        cellImageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
    }
}
