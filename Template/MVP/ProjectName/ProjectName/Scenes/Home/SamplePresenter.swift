//
//  SamplePresenter.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//
import Foundation

protocol SamplePresenterInput {
}

protocol SamplePresenterOutPut: AnyObject {
}

public class SamplePresenter: SamplePresenterInput {
    
    private weak var view: SamplePresenterOutPut!
    private var model: SampleModelInput!
    
    init(view: SamplePresenterOutPut, model: SampleModelInput) {
        self.view = view
        self.model = model
    }
}
