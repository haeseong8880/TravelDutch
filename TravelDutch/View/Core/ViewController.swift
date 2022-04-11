//
//  ViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewConfigure()
    }
    
    func rootViewConfigure() {
        
        let travelViewController = UINavigationController(rootViewController: TravelMapViewController())
        travelViewController.tabBarItem = UITabBarItem(title: "여행 목적지", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        
        let personViewController = UINavigationController(rootViewController: PersonViewController())
        personViewController.tabBarItem = UITabBarItem(title: "여행 멤버", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let moneyManageViewController = UINavigationController(rootViewController: MoneyManageViewcontroller())
        moneyManageViewController.tabBarItem = UITabBarItem(title: "돈 관리", image: UIImage(systemName: "wonsign.square"), selectedImage: UIImage(systemName: "wonsign.square.fill"))
        
        let payViewController = UINavigationController(rootViewController: PayViewController())
        payViewController.tabBarItem = UITabBarItem(title: "사용내역", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        
//        let mettingViewController = UINavigationController(rootViewController: MettingViewController())
//        mettingViewController.tabBarItem = UITabBarItem(title: "모임", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        
        viewControllers = [ travelViewController, personViewController, moneyManageViewController, payViewController ]
    }
}

