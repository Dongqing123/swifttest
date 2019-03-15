//
//  VKYUserManagerTool.swift
//  Vankeyi-Swift
//
//  Created by chenzhw on 2018/1/5.
//  Copyright © 2018年 yhb. All rights reserved.
//

import UIKit
import Foundation
let ToLoginVC = "tologinVC"
let ChangeUserInfoNotification = "ChangeUserInfoNotification"
let UpdateUnreadNotification = "UpdateUnreadNotification"
let HomeAxylNotification = "HomeAxylNotification"

// 加载用户信息完毕通知
let UserInfoDidGetNotification = "UserInfoDidGetNotification"

let ModifyPasswordSuccess = "ModifyPasswordSuccess" // 修改密码成功
let UserInfoMaintenanceSuccess = "UserInfoMaintenanceSuccess" // 用户信息维护成功
let CertificationSuccess = "CertificationSuccess" // 实名认证成功
let UserLogoffSuccess = "UserLogoffSuccess" // 用户注销成功
let UserUbtSuccess = "hdndata" // 用户行为信息采集

class PHUserManagerTool: NSObject {
    let kAppToken = "appToken"
    // 单例
    static let shared : PHUserManagerTool = {
        let tool = PHUserManagerTool()
        if let appToken = UserDefaults.standard.object(forKey: tool.kAppToken){
            if appToken is Data{
                tool.loginAppToken = String.init(data: appToken as! Data, encoding: String.Encoding.utf8)
            }else{
                tool.loginAppToken = appToken as? String
            }
        }
        return tool
    }()
    
    var displayName:String {
        get {
            if usrNickName != nil && (usrNickName?.count)! > 0{
                return usrNickName!
            }
            else if usrfullName != nil && (usrfullName?.count)! > 0{
                return usrfullName!
            }
            return usrId ?? ""
        }
    }

    fileprivate var isFaceAuthSuccess : Bool = false
    
    // 开通状态
    var usrAuthStauts : Bool = false
    // 是否已登录
    var isLogined : Bool = false{
        didSet {
            if isLogined == false{
//                hasCrad = false
                usrfullName = nil
                usrCardId = nil
                usrCardType = nil
                usrNickName = nil
                usrId = nil
                usrLoginFlow = nil
//                userInfo = nil
//                usrAuthStauts = false
                isFaceAuthSuccess = false
            }
        }
    }
    
    // 用户信息
//    var userInfo : VKYCustomerModel?
    // 三要素信息是否齐全
    var hasCrad : Bool = false
    
    // 用户Id
    var usrId : String?
    // 用户昵称
    var usrNickName : String?
    // 姓名
    var usrfullName : String?
    
    var RealName : String?
    
    // 证件类型
    var usrCardType : String?
    // 证件号码
    var usrCardId : String?
    
    // 用户登录流水号
    var usrLoginFlow : String?
    //开通状态
    var UserStatus : String?
    //性别代码
    var Gender : String?
    //户籍所在地
    var BaseAddress : String?
    //用户头像
    var UserProfPht : String?
    //从测额传过来的手机号码
    var phoneNumFromLoan: String?
    
    // 用户手机号
    var loginPhone : String?
    // 用户Token
    var loginAppToken : String?{
        didSet {
            if let value = loginAppToken{
                if let valueData = value.data(using: String.Encoding.utf8){
                    UserDefaults.standard.set(valueData, forKey: kAppToken)
                }
            }
            else{
                UserDefaults.standard.removeObject(forKey: kAppToken)
            }
            UserDefaults.standard.synchronize()
        }
    }
    //是否点击了消息按钮去查看消息
    var isNeedGetMessageNum = false
    
    //未读消息数量
    var unReadedMessageNum = "0"

    //是否检测越狱
    var isCheckRoot = true
   // viewdidload加载了几次
    var loadNum = 0
    //是否存在活动
    var isHasActivity = false
    
    //是否从注销页面进来
    var isFromLogoff = false
}

