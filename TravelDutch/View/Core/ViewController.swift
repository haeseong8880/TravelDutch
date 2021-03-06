//
//  ViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit
import RealmSwift

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewConfigure()
        
        // Core 위치
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        print("PATH => \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
    }
    
    func rootViewConfigure() {
        
        let travelViewController = UINavigationController(rootViewController: TravelMapViewController())
        travelViewController.tabBarItem = UITabBarItem(title: "여행 목적지", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        
        let personViewController = UINavigationController(rootViewController: PersonViewController())
        personViewController.tabBarItem = UITabBarItem(title: "여행 멤버", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let moneyManageViewController = UINavigationController(rootViewController: MoneyManageViewcontroller())
        moneyManageViewController.tabBarItem = UITabBarItem(title: "돈 관리", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        
//        let reportViewController = UINavigationController(rootViewController: ReportViewController())
//        reportViewController.tabBarItem = UITabBarItem(title: "레포트", image: UIImage(systemName: "doc"), selectedImage: UIImage(systemName: "doc.fill"))
//
//        let settingViewController = UINavigationController(rootViewController: SettingViewController())
//        settingViewController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), selectedImage : UIImage(systemName: "gearshape.fill"))
        
        viewControllers = [ travelViewController, personViewController, moneyManageViewController, ]
    }
}

