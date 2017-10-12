//
//  DDShareSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/12.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

//常量
let ss_mmdivideLineHeight:CGFloat = 1                          /* 按钮与按钮之间的分割线高度 */
let ss_mmscreenBounds = UIScreen.main.bounds                   /* 屏幕Bounds */
let ss_mmscreenSize   = ss_mmscreenBounds.size                 /* 屏幕大小 */
let ss_mmscreenWidth  = ss_mmscreenSize.width                  /* 屏幕宽度 */
let ss_mmscreenHeight = ss_mmscreenSize.height                 /* 屏幕高度 */
let ss_mmbuttonHeight:CGFloat = 48.0 * ss_mmscreenWidth / 375  /* button高度 */
let ss_mmtitleHeight:CGFloat = 35.0 * ss_mmscreenWidth / 375   /* 标题的高度 */
let ss_mmbtnPadding:CGFloat = 5 * ss_mmscreenWidth / 375       /* 取消按钮与其他按钮之间的间距 */
let ss_mmdefaultDuration = 0.3
let ss_mmcardHeight:CGFloat = 120.0 * ss_mmscreenWidth / 375   /* 单行card的高度 */
let ss_mmitemHeight:CGFloat = 100.0 * ss_mmscreenWidth / 375   /* 单个item的高度 */
let ss_mmitemwidth:CGFloat = 93.75 * ss_mmscreenWidth / 375    /* 单个item的宽度 */


public typealias ItemClickBlock = (String) ->()

public class MMShareSheet: UIView {
    var title:String?     //标题
    var cards:Array<Array<Dictionary<String, String>>>?    //按钮组
    var duration: Double?  //动画时长
    var cancelButton: Dictionary<String, String>?     //取消按钮
    
    var shareSheetHeight:CGFloat = 0
    public var shareSheetView:UIView = UIView()
    
    public var callBack:ItemClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - buttons: 按钮数组
    ///   - duration: 动画时长
    ///   - cancel: 是否需要取消按钮
    convenience public init(title: String?, cards: Array<Array<Dictionary<String, String>>>?, duration: Double?, cancelBtn: Dictionary<String, String>?) {
        
        //半透明背景
        self.init(frame: ss_mmscreenBounds)
        self.title = title ?? ""
        self.cards = cards ?? []
        let btnCount = self.cards?.count ?? 0
        self.duration = duration ?? (ss_mmdefaultDuration + ss_mmdefaultDuration * Double(btnCount/30))
        self.cancelButton = cancelBtn ?? [:]
        //添加单击事件，隐藏sheet
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singleTapDismiss))
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        
        //shareSheet
        initShareSheet()
        //初始化UI
        initUI()
    }
    
    func initShareSheet() {
        let btnCount = self.cards?.count ?? 0
        var tHeight:CGFloat = 0.0
        if (self.title != nil && self.title != "")   {
            tHeight = ss_mmtitleHeight
        }
        
        var cancelHeight:CGFloat = 0.0
        if self.cancelButton! != [:] {
            cancelHeight = ss_mmbuttonHeight + ss_mmbtnPadding
        }
        
        shareSheetHeight = CGFloat(btnCount) * ss_mmcardHeight + tHeight + cancelHeight + CGFloat(btnCount) * ss_mmdivideLineHeight
        let aFrame:CGRect = CGRect.init(x: 0, y: ss_mmscreenHeight, width: ss_mmscreenWidth, height: shareSheetHeight)
        self.shareSheetView.frame = aFrame
        self.addSubview(self.shareSheetView)
    }
    
    func initUI() {
        
        //标题不为空，则添加标题
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ss_mmscreenWidth, height: ss_mmtitleHeight))
            titlelabel.text = self.title
            titlelabel.textAlignment = .center
            titlelabel.textColor = UIColor(red: 0.361, green: 0.361, blue: 0.361, alpha: 1.00)
            titlelabel.font = UIFont.systemFont(ofSize: 12)
            titlelabel.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90)
            titlelabel.adjustsFontSizeToFitWidth = true
            self.shareSheetView.addSubview(titlelabel)
        }
        
        //事件按钮组
        let cardsCount = self.cards?.count ?? 0
        for index in 0..<cardsCount {
            if index > 3 {break}
            let card = self.cards![index]
            
            var tHeight:CGFloat = 0.0
            if (self.title != nil && self.title != "")   {
                tHeight = ss_mmtitleHeight
            }
            
            let origin_y = tHeight + ss_mmcardHeight * CGFloat(index) + ss_mmdivideLineHeight * CGFloat(index)
            
            let scroller = UIScrollView.init(frame: CGRect.init(x: 0.0, y: origin_y, width: ss_mmscreenWidth, height: ss_mmcardHeight))
            scroller.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80)
            scroller.showsHorizontalScrollIndicator = false
            scroller.showsVerticalScrollIndicator = false
            let contentSizeWidth = CGFloat(card.count) * ss_mmitemwidth > ss_mmscreenWidth ? CGFloat(card.count) * ss_mmitemwidth : (ss_mmscreenWidth + 1.0)
            scroller.contentSize = CGSize.init(width: contentSizeWidth, height: ss_mmcardHeight)
            let itemsCount = card.count
            for subIdx in 0..<itemsCount {
                
                let origin_x = ss_mmitemwidth * CGFloat(subIdx)
                let frame = CGRect.init(x: origin_x, y: (ss_mmcardHeight - ss_mmitemHeight)/2 , width: ss_mmitemwidth, height: ss_mmitemHeight)
                let item = MMCardItem.init(frame: frame, props: card[subIdx], callback: { (handler) in
                    self.dismiss()
                    if (self.callBack != nil) {
                        self.callBack!(handler)
                    }
                })
                
                scroller.addSubview(item)
            }
            
            self.shareSheetView.addSubview(scroller)
        }
        
        //如果取消为ture则添加取消按钮
        if self.cancelButton! != [:] {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: Int(self.shareSheetView.bounds.size.height - ss_mmbuttonHeight), width: Int(ss_mmscreenWidth), height: Int(ss_mmbuttonHeight))
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                // Fallback on earlier versions
            }
            button.setTitle(self.cancelButton?["title"] ?? "取消", for: .normal)
            var titleColor:UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            switch(self.cancelButton!["type"]) {
            case "blue"?:
                titleColor = UIColor(red: 0.082, green: 0.494, blue: 0.984, alpha: 1.00)
                break
            case "danger"?:
                titleColor = UIColor.red
                break
            default:
                titleColor = UIColor(red: 0.000, green: 0.000, blue: 0.004, alpha: 1.00)
            }
            button.setTitleColor(titleColor, for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.80), size: button.bounds.size), for: .normal)
            button.setBackgroundImage(self.imageWithColor(color: UIColor(red: 0.780, green: 0.733, blue: 0.745, alpha: 0.80), size: button.bounds.size), for: .highlighted)
            button.addTarget(self, action: #selector(self.itemClick), for: .touchUpInside)
            self.shareSheetView.addSubview(button)
        }
        
        
    }
    
    @objc func itemClick(button:UIButton) {
        self.dismiss()
        let handler = self.cancelButton?["handler"] ?? "cancel"
        if (self.callBack != nil) {
            self.callBack!(handler)
        }
    }
    
    @objc func singleTapDismiss() {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!("cancel")
        }
    }
    
    /// 显示
    public func present() {
        UIView.animate(withDuration: 0.1, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.shareSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
        }) { (finished:Bool) in
            UIView.animate(withDuration: self.duration!) {
                self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                var tempFrame = self.shareSheetView.frame
                tempFrame.origin.y = ss_mmscreenHeight - self.shareSheetHeight
                self.shareSheetView.frame = tempFrame
            }
        }
        
    }
    
    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration: self.duration!, animations: {
            self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            var tempFrame = self.shareSheetView.frame
            tempFrame.origin.y = ss_mmscreenHeight
            self.shareSheetView.frame = tempFrame
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
    
    /// 修改样式
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.shareSheetView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.941, alpha: 0.90).withAlphaComponent(0.9)
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

extension MMShareSheet: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self {
            return true
        }
        return false
    }
}
