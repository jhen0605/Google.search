//
//  InfoView.swift
//  Google search
//
//  Created by 簡吟真 on 2021/4/27.
//

import UIKit

class InfoView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!

    func show(text: String) {
        textLabel.text = text
        superview?.bringSubviewToFront(self)
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.center = self.superview!.center
        }
        animator.startAnimation()
    }
    
    func close() {
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.frame.origin.y = self.superview!.frame.maxY
        }
        animator.addCompletion { (_) in
            self.frame.origin.y = -self.frame.height
        }
        animator.startAnimation()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 5
        layer.borderColor = UIColor.white.cgColor
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
