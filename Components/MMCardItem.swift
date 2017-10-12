//
//  MMCardItem.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/12.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

let itemWidth:CGFloat = 60.0 * mmscreenWidth / 375   /* item的宽高 */

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
        
        let button = MMButton.init(type: .custom)
        button.frame = CGRect.init(x: (self.bounds.size.width - itemWidth) / 2, y: 8.0, width: itemWidth, height: itemWidth)

        button.handler = self.handler
        
        var imageNormal:UIImage? = nil
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
        
        button.setBackgroundImage(imageNormal, for: .normal)
        button.addTarget(self, action: #selector(self.itemClick), for: .touchUpInside)
        
        self.addSubview(button)
        
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: 5.0 + itemWidth + 5, width: self.bounds.size.width, height: 20))
            titlelabel.text = self.title
            titlelabel.textAlignment = .center
            titlelabel.textColor = UIColor(red: 0.365, green: 0.361, blue: 0.357, alpha: 1.00)
            titlelabel.font = UIFont.systemFont(ofSize: 12)
            titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.00)
            titlelabel.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin]
            self.addSubview(titlelabel)
        }
    }
    
    @objc func itemClick(button:MMButton) {
        if (self.callBack != nil) {
            self.callBack!(button.handler!)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.0)
    }
    
    func imageWithColor(color:UIColor,size:CGSize) ->UIImage{
        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
