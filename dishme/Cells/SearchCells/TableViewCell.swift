//
//  TableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import FlexiblePageControl

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
    @IBOutlet var pageControl: FlexiblePageControl!
    let scrollSize: CGFloat = 300
    
    let detailButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 375, width: 70, height: 30)
        button.layer.cornerRadius = 15
        button.titleLabel!.font = UIFont.init(name: "HelveticaNeue-Medium", size: 10)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("お店を見る", for: UIControl.State.normal)

        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(detailButton)
        
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
        pageControl.pageIndicatorTintColor = UIColor.init(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        pageControl.center = CGPoint(x: scrollView.center.x, y: scrollView.frame.maxY + 16)
        photoBackView.addSubview(pageControl)

    }
    
    //スクロールする
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }
    
    //写真を代入する
    func setImage(image: [[String]] ,tablenumber: Int ,photonumber: Int, view: UIView){
        var imageView:[UIImageView] = []
        
        //ページのnumber
        setContent(numberOfPages: photonumber)
        
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
    
    func setContent(numberOfPages: Int) {
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        scrollView.contentSize = CGSize(width: scrollSize * CGFloat(numberOfPages), height: scrollSize)
        pageControl.numberOfPages = numberOfPages
        
        for index in  0..<numberOfPages {
            
            let view = UIImageView(
                frame: .init(
                    x: CGFloat(index) * scrollSize,
                    y: 0,
                    width: scrollSize,
                    height: scrollSize
                )
            )
            let imageNamed = NSString(format: "image%02d.jpg", index % 10) as String
            view.image = UIImage(named: imageNamed)
            scrollView.addSubview(view)
        }
        
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
