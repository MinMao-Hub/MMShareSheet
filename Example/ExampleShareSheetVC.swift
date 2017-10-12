//
//  ExampleActionSheetVC.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
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
        let buttons = [
            [
                "title": "拍照",
                "handler": "camera",
            ],[
                "title": "相册",
                "handler": "photos",
                "type": "default"
            ]
        ]
        
        let cancelBtn = [
            "title": "取消",
        ]
        let mmShareSheet = MMShareSheet.init(title: "请选择照片", buttons: buttons, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet.present()
    }
    
    @IBAction func showWechatActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "发送给朋友",
                "handler": "sendToFriend",
            ],[
                "title": "收藏",
                "handler": "collection",
                "type": "default"
            ],[
                "title": "保存图片",
                "handler": "save",
            ],[
                "title": "打开",
                "handler": "open",
            ],[
                "title": "编辑",
                "handler": "edit",
            ],[
                "title": "定位到聊天位置",
                "handler": "location",
            ]
        ]
        let cancelBtn = [
            "title": "取消",
        ]
        
        let mmShareSheet1 = MMShareSheet.init(title: nil, buttons: buttons, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet1.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet1.present()
    }
    
    @IBAction func showNoTitleActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "微信",
                "handler": "1",
            ],[
                "title": "QQ",
                "handler": "2",
            ],[
                "title": "支付宝",
                "handler": "3",
            ],[
                "title": "新浪微博",
                "handler": "4",
            ]
        ]
        
        let mmShareSheet2 = MMShareSheet.init(title: nil, buttons: buttons, duration: nil, cancelBtn: nil)
        mmShareSheet2.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet2.present()
    }
    
    @IBAction func showNoCancelActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "男",
                "handler": "男",
                "type": "blue"
            ],[
                "title": "女",
                "handler": "女",
                "type": "danger"
            ]
        ]
        
        let mmShareSheet3 = MMShareSheet.init(title: "请选择性别", buttons: buttons, duration: nil, cancelBtn: nil)
        mmShareSheet3.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet3.present()
    }
    
    @IBAction func showColorTitleActionSheet(_ sender: Any) {
        let buttons = [
            [
                "title": "查看",
                "handler": "check",
                "type": "default"
            ],[
                "title": "编辑",
                "handler": "edit",
                "type": "blue"
            ],[
                "title": "删除",
                "handler": "delete",
                "type": "danger"
            ]
        ]
        let cancelBtn = [
            "title": "返回",
            "handler": "back",
            "type": "blue"
        ]
        
        let mmShareSheet4 = MMShareSheet.init(title: "文件管理", buttons: buttons, duration: nil, cancelBtn: cancelBtn)
        mmShareSheet4.callBack = { (handler) ->() in
            self.noticeOnlyText(handler)
        }
        mmShareSheet4.present()
    }
    
}
