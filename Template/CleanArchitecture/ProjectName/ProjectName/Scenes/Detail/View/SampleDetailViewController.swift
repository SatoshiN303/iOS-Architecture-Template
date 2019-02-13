//
//  SampleDetailViewController.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
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
