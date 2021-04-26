//
//  dice.swift
//  Google search
//
//  Created by 簡吟真 on 2021/4/27.
//

import UIKit

class diceViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let button = sender as! UIButton
        let controller = segue.destination as!
            dicesViewController
        controller.name = button.currentTitle //把按鈕上的名字傳過去
    }





}
