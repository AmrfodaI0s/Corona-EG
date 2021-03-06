//
//  PreventionTipsViewControllerPresenter.swift
//  Corona-EG
//
//  Created by Abdelrhman Eliwa on 5/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

// MARK: - Prevention Tips View Protocol
protocol PreventionTipsView: class {
    var presenter: PreventionTipsViewControllerPresenter? { get set }
    func showError(_ error: String)
}

// MARK: - Prevention Tips Cell View Protocol
protocol PreventionTipsCellView {
    func displayLabel(_ tip: String)
}


class PreventionTipsViewControllerPresenter {
    
    // MARK: - Properties
    private weak var view: PreventionTipsView?
    private let interactor: PreventionTipsInteractor
    private var preventionTipsModel: [PreventionTipsModel] = []
    private var preventionTips: [PreventionTip] = []
    private let currentLanguage = "currentAppLanguage".localizedString()
    
    // MARK: - init
    init(view: PreventionTipsView?, interactor: PreventionTipsInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        getData()
    }
    
    private func getData() {
        interactor.getData { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error {
                self.view?.showError(error.localizedDescription)
            } else {
                guard let data = data else { return }
                self.preventionTipsModel = data
                self.checkDataLanguage()
            }
        }
    }
    
    private func checkDataLanguage() {
        for data in preventionTipsModel {
            if data.language == currentLanguage {
                preventionTips = data.data
            }
        }
    }
    
    func getMethodsCount() -> Int {
        preventionTips.count
    }
    
    func cellConfiguartion(cell: PreventionTipsCellView, for index: Int) {
        let preventionTip = preventionTips[index].tip
        cell.displayLabel(preventionTip)
    }
}
