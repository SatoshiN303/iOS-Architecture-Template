//
//  SampleViewController.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    var presenter: SamplePresenterInput!
    
    func inject(presenter: SamplePresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SampleViewController: SamplePresenterOutPut {
    
}
