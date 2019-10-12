import UIKit
extension UIImage {
    /// 画像を正方形にクリッピングする
    ///
    /// - Returns: クリッピングされた正方形の画像
    func cropping2square()-> UIImage!{
        let cgImage    = self.cgImage
        let width = (cgImage?.width)!
        let height = (cgImage?.height)!
        let resizeSize = min(height,width)
        
        let cropCGImage = self.cgImage?.cropping(to: CGRect(x: (width - resizeSize) / 2, y: (height - resizeSize) / 2, width: resizeSize, height: resizeSize))
        
        let cropImage = UIImage(cgImage: cropCGImage!)
        
        return cropImage.rotate(angle: 90)
    }
    /// 画像をを回転させる
    ///
    /// - Parameter angle: 回転角度(deg)
    /// - Returns: 回転された画像
    func rotate(angle: CGFloat) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: self.size.width/2, y: self.size.height/2)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let radian: CGFloat = (-angle) * CGFloat.pi / 180.0
        context.rotate(by: radian)
        context.draw(self.cgImage!, in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let rotatedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
    
    private func min(_ a : Int, _ b : Int ) -> Int {
        if a < b { return a}
        else { return b}
    }
}

//アカウントの形リサイズ
extension UIImageView {
    
    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
    }
}


extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
}


extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

extension Array where Element: Equatable {
    mutating func remove(value: Element) {
        if let i = self.index(of: value) {
            self.remove(at: i)
        }
    }
    
    func safeRange(startIndex: Int, range: Int) -> ArraySlice<Element> {
        return self.dropFirst(startIndex).prefix(range)
    }
}

//
//extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        var size = super.sizeThatFits(size)
//        
//        size.height = 79
//        return size
//    }
//}
