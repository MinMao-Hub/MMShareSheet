//
//  ExampleShareSheetVC.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/12.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class ExampleShareSheetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func presentActionSheet(_ sender: Any) {
        let cards = [
            [
                [
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ],[
                    "title": "QQ好友",
                    "icon": "qq",
                    "handler": "qqfriend",
                ],[
                    "title": "支付宝",
                    "icon": "airpay",
                    "handler": "airpay",
                ],[
                    "title": "新浪微博",
                    "icon": "sina",
                    "handler": "sinawb",
                ],[
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ]
            ],[
                [
                    "title": "拷贝",
                    "icon": "copy_link",
                    "handler": "copy"
                ],[
                    "title": "在Safari中打开",
                    "icon": "safari",
                    "handler": "safari"
                ],[
                    "title": "收藏",
                    "icon": "collection",
                    "handler": "collect",
                ],[
                    "title": "刷新",
                    "icon": "refresh_icon",
                    "handler": "refresh",
                ],[
                    "title": "举报",
                    "icon": "jubao",
                    "handler": "report",
                ]
            ]
        ]
        
        let cancelBtn = [
            "title": "取消",
        ]
        let mmShareSheet = MMShareSheet.init(title: "此网页由wx.keeponrunning.com提供", cards: cards, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet.present()
    }
    

    @IBAction func singleLineShareSheet(_ sender: Any) {
        let cards = [
            [
                [
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ],[
                    "title": "QQ好友",
                    "icon": "qq",
                    "handler": "qqfriend",
                ],[
                    "title": "支付宝",
                    "icon": "airpay",
                    "handler": "airpay",
                ]
            ]
        ]
        
        let cancelBtn = [
            "title": "取消",
            "type": "danger"
            ]
        let mmShareSheet = MMShareSheet.init(title: "分  享", cards: cards, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet.present()
        
    }
    
    
    @IBAction func mutableLineShareSheet(_ sender: Any) {
        
        let cards = [
            [
                [
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ],[
                    "title": "QQ好友",
                    "icon": "qq",
                    "handler": "qqfriend",
                ],[
                    "title": "支付宝",
                    "icon": "airpay",
                    "handler": "airpay",
                ],[
                    "title": "新浪微博",
                    "icon": "sina",
                    "handler": "sinawb",
                ],[
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ]
            ],[
                [
                    "title": "拷贝",
                    "icon": "copy_link",
                    "handler": "copy"
                ],[
                    "title": "在Safari中打开",
                    "icon": "safari",
                    "handler": "safari"
                ],[
                    "title": "收藏",
                    "icon": "collection",
                    "handler": "collect",
                ],[
                    "title": "刷新",
                    "icon": "refresh_icon",
                    "handler": "refresh",
                ],[
                    "title": "举报",
                    "icon": "jubao",
                    "handler": "report",
                ]
            ],
              [
                [
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ],[
                    "title": "QQ好友",
                    "icon": "qq",
                    "handler": "qqfriend",
                ],[
                    "title": "支付宝",
                    "icon": "airpay",
                    "handler": "airpay",
                ],[
                    "title": "新浪微博",
                    "icon": "sina",
                    "handler": "sinawb",
                ],[
                    "title": "微信好友",
                    "icon": "wechat",
                    "handler": "wxfriend"
                ],[
                    "title": "微信朋友圈",
                    "icon": "moment",
                    "handler": "wxmoment"
                ]
            ]
        ]
        
        let cancelBtn = [
            "title": "取消",
            "type": "blue"
            ]
        let mmShareSheet = MMShareSheet.init(title: "分  享", cards: cards, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet.present()
    }
    
    
    @IBAction func remoteIconShareSheet(_ sender: Any) {
        let cards = [
            [
                [
                    "title": "银行卡管理",
                    "icon": "http://dsposweb.oss-cn-hangzhou.aliyuncs.com/Image/wd_1.png",
                    "handler": "bankCard"
                ],[
                    "title": "信用卡管理",
                    "icon": "http://dsposweb.oss-cn-hangzhou.aliyuncs.com/Image/wd_5.png",
                    "handler": "creditCard"
                ],[
                    "title": "微信",
                    "icon": "http://dsposweb.oss-cn-hangzhou.aliyuncs.com/Image/wd_2.png",
                    "handler": "weChat",
                ],[
                    "title": "安全中心",
                    "icon": "http://dsposweb.oss-cn-hangzhou.aliyuncs.com/Image/wd_6.png",
                    "handler": "securityCenter",
                ]
            ]
        ]
        
        let cancelBtn = [
            "title": "取消",
            "type": "danger"
        ]
        let mmShareSheet = MMShareSheet.init(title: "远程icon测试", cards: cards, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet.present()
        
    }
}
