//
//  PayViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import Foundation
import UIKit

class PayViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        presentCircleView()
    }
    
    private func configure() {

    }
    
    private func layout() {
        
    }
    
    private func presentCircleView() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        pieChartView.center = self.view.center
        
        pieChartView.slices = [Slice(percent: 0.4, color: UIColor.systemOrange, text: "가"),
                               Slice(percent: 0.3, color: UIColor.systemTeal, text: "나"),
                               Slice(percent: 0.1, color: UIColor.systemRed, text: "다"),
                               Slice(percent: 0.1, color: UIColor.systemIndigo, text: "라"),
                               Slice(percent: 0.05, color: UIColor.systemBlue, text: "다"),
                               Slice(percent: 0.04, color: UIColor.systemCyan, text: "다"),
                               Slice(percent: 0.01, color: UIColor.systemPink, text: "다")
                               ]
        
        self.view.addSubview(pieChartView)
        pieChartView.animateChart()
    }
}
