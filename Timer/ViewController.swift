//
//  ViewController.swift
//  Timer
//
//  Created by Sergey Koriukin on 01/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func steperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
      
   
    @IBOutlet var gameFieldView: GameFieldView!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerButonOutlet: UIButton!
    
    
    
    @IBAction func timerButonAction(_ sender: UIButton) {
        if isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    func objectTapped() {
        guard isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var displayDuration: TimeInterval = 2
    private var timer: Timer?
    private var score = 0
    
    private func startGame() {
        score = 0
        repositionImageWithTimer()
        gameTimer?.invalidate()//остановка предыдущего таймера
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerTick), userInfo: nil, repeats: true)
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
    }
    private func stopGame() {
        isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        timer?.fire()
    }
    private func updateUI() {
        gameFieldView.isShapeHidden = !isGameActive
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timerLabel.text = "Осталось: \(Int(gameTimeLeft)) сек"
            timerButonOutlet.setTitle("Stop", for: .normal)
        } else {
            timerLabel.text = "Время: \(Int(stepper.value)) сек"
            timerButonOutlet.setTitle("Start", for: .normal)
        }
    }
    @objc private func gameTimerTick() {
        gameTimeLeft -= 1
        if gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
        
    }
    @objc private func moveImage() {
        gameFieldView.randomizeShapes()
       // print(arc4random_uniform(3))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        updateUI()
        gameFieldView.shapeHitHandler = { [ weak self ] in
            self?.objectTapped()
        }
    }


}

