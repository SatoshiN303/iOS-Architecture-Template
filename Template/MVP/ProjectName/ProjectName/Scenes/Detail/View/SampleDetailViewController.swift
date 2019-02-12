//
//  SampleDetailViewController.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2019/02/12.
//  Copyright © 2019年 'XLOrganizationName'. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class SampleDetailViewController: UIViewController {

    var presenter: SampleDetailPresenterInput!
    private var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(presenter)
        print(user)
    }
    
    static func makeInstance(user: User) -> SampleDetailViewController {
        let sb = SwinjectStoryboard.create(name: "SampleDetail", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() as? SampleDetailViewController else {
            fatalError()
        }
        vc.user = user
        return vc
    }
}

extension SampleDetailViewController: SampleDetailPresenterOutput {
    
}
