//
//  TableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell ,UIScrollViewDelegate{
    
    var isOpen = false
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var acountButton: UIButton!
    @IBOutlet weak var resevebButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var goodlabel: UILabel!
    @IBOutlet weak var badlabel: UILabel!
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var badButton: UIButton!
    
    //pagescroll
    @IBOutlet var photoBackView: UIView!
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        acountButton.layer.masksToBounds = true
        acountButton.layer.cornerRadius = 16
        
        //scrollViewの基本設定
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        photoBackView.addSubview(scrollView)
        
        // pageControlの表示位置とサイズの設定
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 380, width: 375, height: 30))
        pageControl.pageIndicatorTintColor = UIColor.init(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor.init(red: 75/355, green: 149/355, blue: 233/255, alpha: 1)
        photoBackView.addSubview(pageControl)
    }
    
    //スクロールする
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
    //写真を代入する
    func setImage(image: [[String]] ,tablenumber: Int ,photonumber: Int, view: UIView){
        var imageView:[UIImageView] = []
        
        //ページのnumber
        pageControl.numberOfPages = photonumber
        
        //格写真を並べる
        scrollView.contentSize = CGSize(width: 375 * photonumber, height: 375)
        
        for photonumber in 0..<photonumber{
            imageView.append(createImageView(x: view.frame.size.width*CGFloat(photonumber), y: 0, width: view.frame.size.width, height: 375, image: image[tablenumber][photonumber]))
            scrollView.addSubview(imageView[photonumber])
        }
    }
    
    // UIImageViewを生成
    func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: String) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        let image = UIImage(named:  image)
        imageView.image = image
        return imageView
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 10, *) {
            UIView.animate(withDuration: 0.3) { self.contentView.layoutIfNeeded() }
        }
    }

}
