//
//  Tic-tac-toe.swift
//  Google search
//
//  Created by 簡吟真 on 2021/4/27.
//

import UIKit
class Tic_tac_toe : UIViewController {

    let grid: Grid = Grid()
    
    @IBOutlet var squares: [UIView]!
    @IBOutlet weak var oLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var infoView: UIButton!
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    var occupyPieces = [UILabel]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        
        }
    
       func newGame() {
           grid.clear()
           UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 1, options: [], animations: {
               self.occupyPieces.forEach { (piece) in
                   piece.alpha = 0
               }
           }) { (_) in
               self.occupyPieces.forEach { (piece) in
                   piece.removeFromSuperview()
               }
               self.occupyPieces.removeAll()
               self.takeTurn(label: self.oLabel)
           }
           
       }
       
       @IBAction func closeInfoView(_ sender: Any) {
           
           if grid.winner != nil || grid.isTie {
               newGame()
           }
       }
       
       @IBAction func infoButtonTapped(_ sender: Any) {
           
       }
       
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           takeTurn(label: oLabel)
       }
       
       func takeTurn(label: UILabel) {
           let rotateAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
               label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
               label.alpha = 0.75
           }
           let backAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
               label.transform = CGAffineTransform.identity
               label.alpha = 1
           }
           backAnimator.addCompletion { (_) in
               label.isUserInteractionEnabled = true
               label.addGestureRecognizer(self.gestureRecognizer)
               self.view.bringSubviewToFront(label)
           }
           rotateAnimator.addCompletion { (_) in
               backAnimator.startAnimation()
           }
           rotateAnimator.startAnimation()
       }
       
       func pieceBackToStartLocation(label: UILabel) {
           UIView.animate(withDuration: 0.5) {
               label.transform = .identity
           }
       }
       
       func placePiece(_ label: UILabel, on square: UIView, index: Int) {
           
           var originalPieceCenter = CGPoint.zero
          
           UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: {
               label.transform = .identity
               originalPieceCenter = label.center
               label.center = square.center
               
           }) { (_) in
               
               self.finishCurrentTurn(label: label, index: index, originalPieceCenter: originalPieceCenter)
           }
       }
       
       func createPieceLabel(label: UILabel) -> UILabel {
           let newLabel = UILabel(frame: label.frame)
           newLabel.text = label.text
           newLabel.font = label.font
           newLabel.backgroundColor = label.backgroundColor
           newLabel.textColor = label.textColor
           newLabel.textAlignment = label.textAlignment
           newLabel.alpha = 0.5
           newLabel.isUserInteractionEnabled = false
           return newLabel
       }
       
       func showWinLineAnimation(startPoint: CGPoint, endPoint: CGPoint) {
           let path = UIBezierPath()
           path.move(to: startPoint)
           path.addLine(to: endPoint)
           
           let shapeLayer = CAShapeLayer()
           shapeLayer.path = path.cgPath
           shapeLayer.strokeColor = UIColor.red.cgColor
           shapeLayer.lineWidth = 10
           shapeLayer.lineCap = .butt
           
           CATransaction.begin()
           CATransaction.setAnimationDuration(3)
           
           let strokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
           strokeAnimation.fromValue = 0
           strokeAnimation.toValue = 1
           CATransaction.setCompletionBlock {
               shapeLayer.removeFromSuperlayer()
               if let winner = self.grid.winner {
                   if winner == Grid.Piece.o {
                   
                   } else {
                 
                   }
               }
           }
           shapeLayer.add(strokeAnimation, forKey: nil)
           view.layer.addSublayer(shapeLayer)
           CATransaction.commit()
       }
       
       func finishCurrentTurn(label: UILabel, index: Int, originalPieceCenter: CGPoint) {
           
           occupyPieces.append(label)
           let newLabel = createPieceLabel(label: label)
           newLabel.center = originalPieceCenter
           view.addSubview(newLabel)
           
           let nextLabel: UILabel
           if label == xLabel {
               self.grid.occupy(piece: .x, on: index)
               xLabel = newLabel
               nextLabel = oLabel
           } else {
               self.grid.occupy(piece: .o, on: index)
               oLabel = newLabel
               nextLabel = xLabel
           }
           
           if grid.winnerLines.isEmpty == false {
               grid.winnerLines.forEach { (indexes) in
                   showWinLineAnimation(startPoint: squares[indexes.first!].center, endPoint: squares[indexes.last!].center)
               }
           } else if grid.isTie {
               
           } else {
               takeTurn(label: nextLabel)
           }
       }
       
       @IBAction func movePiece(_ sender: UIPanGestureRecognizer) {
           guard let label = sender.view as? UILabel else {
               return
           }
           if sender.state == .ended {
               var maxIntersectionArea: CGFloat = 0
               var targetSquare: UIView?
               var targetIndex: Int?
               for (i, square) in squares.enumerated() {
                   let intersectionFrame = square.frame.intersection(label.frame)
                   let area = intersectionFrame.width * intersectionFrame.height
                   if area > maxIntersectionArea {
                       maxIntersectionArea = area
                       targetSquare = square
                       targetIndex = i
                   }
               }
               if let targetSquare = targetSquare, let targetIndex = targetIndex, grid.isSquareEmpty(index: targetIndex) {
                   placePiece(label, on: targetSquare, index: targetIndex)
               } else {
                   pieceBackToStartLocation(label: label)
               }
           } else {
               let translation = sender.translation(in: view)
               label.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
           }
       }
       
       

   }
