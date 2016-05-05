//
//  TabbarViewController.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init () {
        super.init(nibName: nil, bundle: nil);
        tabBar.barTintColor = UIColor(hexString: "05121f")
        tabBar.tintColor = UIColor(hexString: "8bc34a")
        
        tabBar.barStyle = UIBarStyle.Black
        tabBar.translucent = false
        tabBar.clipsToBounds = true
        var viewControllers = [NavigationViewController]()
        
        
        let homeViewController = HomeViewController();
        let homeNavigationCtrl = NavigationViewController(rootViewController: homeViewController)
        
        homeNavigationCtrl.tabBarItem.title = "主页"
        homeNavigationCtrl.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(11)], forState: UIControlState.Normal)
        homeNavigationCtrl.tabBarItem.image = UIImage(named: "images.bundle/common/tabbar/home_normal@2x")
        homeNavigationCtrl.tabBarItem.selectedImage = UIImage(named: "images.bundle/common/tabbar/home_selected@2x")
        viewControllers.append(homeNavigationCtrl)
        
        let hallViewController = HallViewController()
        let hallNavigationCtrl = NavigationViewController(rootViewController: hallViewController)
        hallNavigationCtrl.tabBarItem.title = "赛事大厅"
        hallNavigationCtrl.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(11)], forState: UIControlState.Normal)
        hallNavigationCtrl.tabBarItem.image = UIImage(named: "images.bundle/common/tabbar/room_normal@2x")
        hallNavigationCtrl.tabBarItem.selectedImage = UIImage(named: "images.bundle/common/tabbar/room_selected@2x")
        viewControllers.append(hallNavigationCtrl)
        
        let contestViewController = ContestViewController()
        let contestNavigationCtrl = NavigationViewController(rootViewController: contestViewController)
        contestNavigationCtrl.tabBarItem.title = "我的赛事"
        contestNavigationCtrl.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(11)], forState: UIControlState.Normal)
        contestNavigationCtrl.tabBarItem.image = UIImage(named: "images.bundle/common/tabbar/contest_normal@2x")
        contestNavigationCtrl.tabBarItem.selectedImage = UIImage(named: "images.bundle/common/tabbar/contest_selected@2x")

        viewControllers.append(contestNavigationCtrl)
        
        let userViewController = UserViewController()
        let userNavigationCtrl = NavigationViewController(rootViewController: userViewController)
        userNavigationCtrl.tabBarItem.title = "我的"
        userNavigationCtrl.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(11)], forState: UIControlState.Normal)
        userNavigationCtrl.tabBarItem.image = UIImage(named: "images.bundle/common/tabbar/user_normal")
        userNavigationCtrl.tabBarItem.selectedImage = UIImage(named: "images.bundle/common/tabbar/user_selected")
        viewControllers.append(userNavigationCtrl)
        
        self.viewControllers = viewControllers
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
