//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

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
    
    // Действие, вызываемое при выборе уровня готовности
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // Отменить предыдущий таймер, если он существует
        timer.invalidate()
        
        // Получить уровень готовности из заголовка кнопки
        let hardness = sender.currentTitle!
        
        // Получить общее время приготовления из словаря eggTimes
        totalTime = eggTimes[hardness]!
        
        // Создать новый таймер и запланировать вызов updateTimer() каждую секунду
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Функция, вызываемая таймером для обновления прогресса приготовления
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            // Вычислить процент завершения
            let percentageProgress = secondsPassed / totalTime
            
            // // TODO: Пофиксить прогресс бар
            progressBar.progress = Float(percentageProgress)
            
            // Увеличить прошедшее время
            secondsPassed += 1
        } else {
            // Время приготовления завершено, отменить таймер и обновить надпись
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
}
