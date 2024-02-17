//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by kernelpanixc on 13.07.2023.
//
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        //Images
        
    
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

       
        kenny1.addGestureRecognizer(recognizer1)
        kenny1.isUserInteractionEnabled = true

        
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveTarget), userInfo: nil, repeats: true)
        
        

        
    }
    
    
    
    @objc  func moveTarget() {
        
        let screenWidth = self.view.frame.width
        let screenHeight = view.frame.height
        let maxX = screenWidth - kenny1.frame.width
        let maxY = screenHeight - kenny1.frame.height

        let randomX = CGFloat.random(in: 20...maxX)
        let randomY = CGFloat.random(in: 145...700)

        //UIView.animate(withDuration: 5) {
            self.kenny1.center = CGPoint(x: randomX, y: randomY)
        //}
    }
    
    

    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
         // Resmi yakaladiginizda puani artirir
         //score += 1

         // Puani günceller
         

         // Resmi yeni bir konuma tasir
        self.increaseScore()
        self.moveTarget()
     }
    
  
    
    
    
    

    @objc func increaseScore() {
       
        
        score += 1
        
        
        scoreLabel.text = "Score: \(score)"
    }
    
   @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            kenny1.isUserInteractionEnabled = false
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.moveTarget), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }


}

