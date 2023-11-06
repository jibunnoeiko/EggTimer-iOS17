//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Словарь для хранения времени приготовления для разных степеней готовности яиц
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    // Outlets для связи с элементами Interface Builder
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Таймер для отслеживания времени приготовления
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer?
    
    // Действие, вызываемое при выборе уровня готовности
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Отменить предыдущий таймер, если он существует
        timer.invalidate()
        
        // Получить уровень готовности из заголовка кнопки
        let hardness = sender.currentTitle!
        
        // Получить общее время приготовления из словаря eggTimes
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // Создать новый таймер и запланировать вызов updateTimer() каждую секунду
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Функция, проигрывает мелодию по готовности приготовления
    func playSound() {
        if let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") {
            let url = URL(fileURLWithPath: path)
            player = try! AVAudioPlayer(contentsOf: url)
            player?.play()
        }
    }
    
    // Функция, вызываемая таймером для обновления прогресса приготовления
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            
            // Вычислить процент завершения
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            // TODO: Пофиксить прогресс бар ✅
            progressBar.progress = percentageProgress

            // Увеличить прошедшее время
            secondsPassed += 1
            
        } else {
            // Время приготовления завершено, отменить таймер, обновить надпись и вкл мелодию
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
}
