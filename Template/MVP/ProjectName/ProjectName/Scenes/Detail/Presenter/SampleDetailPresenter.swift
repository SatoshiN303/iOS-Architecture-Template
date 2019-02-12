//
//  SampleDetailPresenter.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import UIKit

protocol SampleDetailPresenterInput {
}

protocol SampleDetailPresenterOutput: AnyObject {
}

public class SampleDetailPresenter: SampleDetailPresenterInput {
    
    private weak var view: SampleDetailPresenterOutput!
    
    init(view: SampleDetailPresenterOutput) {
        self.view = view
    }
}
