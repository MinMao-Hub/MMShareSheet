//
//  MMCardItem.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/12.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

let mm_itemWidth:CGFloat = 60.0 * ss_mmscreenWidth / 375   /* item的宽高 */
let mm_itemPadding:CGFloat = 8.0 * ss_mmscreenWidth / 375 /* item距离顶部的距离 */
let mm_titlePadding:CGFloat = 5.0 * ss_mmscreenWidth / 375 /* item距离顶部的距离 */
public class MMCardItem: UIView {
    
    var icon: String?
    var title: String?
    var handler: String?
    var callBack:ItemClickBlock?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(frame: CGRect,props: Dictionary<String, String>?, callback: @escaping ItemClickBlock) {
        self.init(frame: frame)
        self.title = props?["title"] ?? ""
        self.icon = props?["icon"] ?? ""
        self.handler = props?["handler"] ?? ""
        self.callBack = callback
        initUI()
        
    }
    
    func initUI() {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: (self.bounds.size.width - mm_itemWidth) / 2, y: mm_itemPadding, width: mm_itemWidth, height: mm_itemWidth)
        
        var imageNormal:UIImage? = nil
        
        DispatchQueue.global().async {
            if self.icon != "" {
                if (self.icon?.hasPrefix("http"))! {
                    do {
                        let imgData = try Data.init(contentsOf: URL.init(string: self.icon!)!)
                        imageNormal = UIImage.init(data: imgData, scale: UIScreen.main.scale)
                    } catch {
                        //Handle exception
                    }
                } else {
                    imageNormal = UIImage.init(named: self.icon!)
                }
            }
            
            DispatchQueue.main.async {
                button.setBackgroundImage(imageNormal, for: .normal)
            }
        }
        
        button.addTarget(self, action: #selector(self.itemClick), for: .touchUpInside)
        
        self.addSubview(button)
        
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: mm_itemWidth + mm_itemPadding + mm_titlePadding, width: self.bounds.size.width, height: 20))
            titlelabel.text = self.title
            titlelabel.textAlignment = .center
            titlelabel.textColor = UIColor(red: 0.365, green: 0.361, blue: 0.357, alpha: 1.00)
            titlelabel.font = UIFont.systemFont(ofSize: 12)
            titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.00)
            titlelabel.adjustsFontSizeToFitWidth = true
            self.addSubview(titlelabel)
        }
    }
    
    @objc func itemClick(button:UIButton) {
        if (self.callBack != nil) {
            self.callBack!(self.handler!)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.0)
    }
}
