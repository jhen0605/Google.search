//
//  coin.swift
//  Google search
//
//  Created by 簡吟真 on 2021/4/27.
//

import UIKit

class coin: UIViewController {

    @IBOutlet var diceImages: [UIImageView]!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var dicesumText: UILabel!
    
    let imageNames = ["o1","o2","o3","o4","o5","o6","o7","o8","o9","o10","o11","o12","o13","o14","o15","o16","o17","o18","o19","o20"]
    
        override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonCheck(_ sender: Any) {
        var diceSum = 0
        let diceTime:TimeInterval = 0.5
    DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + diceTime)
        {
        //跑隨機骰子及計算總和
        for i in 0...7 {
        let diceNum = Int.random(in: 1...20)
        diceSum += diceNum
        self.diceImages[i].image = UIImage(named: self.imageNames[diceNum-1])
        }
        //將總和顯示在畫面上
        self.dicesumText.text = String(diceSum) + "點"
    }
    
}















}
