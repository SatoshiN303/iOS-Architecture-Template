//
//  SampleViewControllers.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import UIKit
//import Compass

///**
// Compassを利用した画面遷移のサンプル実装
// */
//class SampleTopViewController: UIViewController {
//    var articleID: String?
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        Log.debug(articleID ?? "")
//    }
//    
//    @IBAction func pushDetailWithID(_ sender: UIButton) {
//        let articleID = "12345"
//        try? Navigator.navigate(urn: Routes.sampleDetail(articleID).rawValue)
//    }
//    
//    @IBAction func presentLogin(_ sender: UIButton) {
//        try? Navigator.navigate(urn: Routes.sampleLogin.rawValue)
//    }
//    
//}
//
///**
// Compassを利用した画面遷移のサンプル実装
// */
//class SampleDetailViewController: UIViewController {
//    var articleID: String!
//    
//    @IBAction func backToTopVC(_ sender: UIButton) {
//        try? Navigator.navigate(urn: Routes.sampleTop(nil).rawValue)
//    }
//}
//
///**
// Compassを利用した画面遷移のサンプル実装
// */
//class SampleLoginViewController: UIViewController {}
//
///**
// Compassを利用した画面遷移のサンプル実装
// */
//class SampleSignupFinishViewController: UIViewController {
//    @IBAction func finishSignup(_ sender: UIButton) {
//        let userID = "jfpjqwjf[oqwf3456"
//        try? Navigator.navigate(urn: Routes.sampleTop(userID).rawValue)
//    }
//}
//
///**
// Compassを利用した画面遷移のサンプル実装
// */
//class SampleUserViewController: UIViewController {
//    var userID: String!
//    
//    @IBAction func backToTop(_ sender: UIButton) {
//        try? Navigator.navigate(urn: Routes.sampleTop(nil).rawValue)
//    }
//}
