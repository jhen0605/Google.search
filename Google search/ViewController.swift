//
//  ViewController.swift
//  Google search
//
//  Created by 簡吟真 on 2021/4/26.
//

//擲硬幣
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    @IBAction func startButtonChange(_ sender: Any) {
        let coin : [UIImage?] = [UIImage(named: "1"),UIImage(named: "2")]
        let number = Int.random(in: 0...1)
        coinImage.image = coin[number]
    }

}
