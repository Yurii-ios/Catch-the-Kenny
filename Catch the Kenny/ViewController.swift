//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Yurii Sameliuk on 03/02/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var timer = Timer()
    var count = 0
    var score = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        kennyImage()
        countTimer()
        hideKenny()
        
        let stosedHighscore = UserDefaults.standard.object(forKey: "highScore")
        
        if stosedHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = stosedHighscore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
    }
    
    func kennyImage() {
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(tapKenny))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
    }
    
    @objc func tapKenny() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    func countTimer() {
        count = 10
        timeLabel.text = "\(count)"
        scoreLabel.text = "Score: \(score)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFromCathKenny), userInfo: nil, repeats: true)//    }
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func timeFromCathKenny() {
        
        timeLabel.text = "\(count)"
        count -= 1
        
        if count == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            if score > highScore {
                        highScore = score
                  highscoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
            // delaem wse newidimumi kartinki , ispolzyja cukl for
            
            let alert = UIAlertController(title: "Time is Up", message: "Do you want play again?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                self.kenny1.isUserInteractionEnabled = false
                self.kenny2.isUserInteractionEnabled = false
                self.kenny3.isUserInteractionEnabled = false
                self.kenny4.isUserInteractionEnabled = false
                self.kenny5.isUserInteractionEnabled = false
                self.kenny6.isUserInteractionEnabled = false
                self.kenny7.isUserInteractionEnabled = false
                self.kenny8.isUserInteractionEnabled = false
                self.kenny9.isUserInteractionEnabled = false
            }
            let actionReplay = UIAlertAction(title: "Replay", style: .default) { actionReplay in
                self.countTimer()
                self.score = 0
            }
            alert.addAction(action)
            alert.addAction(actionReplay)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideKenny() {
        // wozwras4aet randomno promežytok ot maksimalnogo ykazanogo 4isla
        let random = Int (arc4random_uniform(UInt32(kennyArray.count - 1)))
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        kennyArray[random].isHidden = false
    }
}

