//
//  BattleViewController.swift
//  TechMon
//
//  Created by 曽根大輔 on 2018/02/10.
//  Copyright © 2018年 曽根大輔. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var playerHPLabel: UILabel!
    @IBOutlet var playerMPLabel: UILabel!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var enemyHPLabel: UILabel!
    @IBOutlet var enemyMPLabel: UILabel!
    
    let techMonManager = TechMonManager.shared
    
    var player: Character!
    var enemy: Character!
    
    var gameTimer: Timer!
    var isPlayerAttackAvalable: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //キャラクターの読み込み
        player = techMonManager.player
        enemy = techMonManager.enemy
        
        
    //ステータスの反映
        func updateUI() {
            
        //プレイヤーのステータスを反映
    
        playerHPLabel.text = "\(player.currentHP)/ \(player.maxHP)"
        playerMPLabel.text = "\(player.currentMP)/ \(player.maxMP)"
            
        
        
        //敵のステータスを反映
        enemyNameLabel.text  = "勇者"
        enemyImageView.image = UIImage(named: "monster.png")
        enemyHPLabel.text = "\(enemy.currentHP)/ \(enemy.maxHP)"
        enemyMPLabel.text = "\(enemy.currentMP)/ \(enemy.maxMP)"
            
        
        //ゲームスタート
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        
        gameTimer.fire()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "BGM_battle001")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }
    
    //0.1秒ごとにゲームの状態を更新する
    func updateGame(){
        //プレイヤーのステータスを更新
        playerMP += 1
        if playerMP >= 20 {
            
            isPlayerAttackAvalable = true
            playerMP = 20
        } else {
            
            isPlayerAttackAvalable = false
        }
        
        //敵のステータスを更新
        enemyMP += 1
        if enemyMP >= 35 {
            
            enemyAttack()
            enemyMP = 0
        }
        
        playerMPLabel.text = "\(playerMP)/ 20"
        enemyMPLabel.text = "\(enemyMP)/ 35"
    }
    
    //敵の攻撃
    func enemyAttack(){
        
        techMonManager.damageAnimation(imageView: playerImageView)
        techMonManager.playSE(fileName: "SE_attack")
        
        playerHP -= 20
        playerHPLabel.text = "\(playerHP)/100"
        if playerHP <= 0 {
            finishBattle(vanishImageView: playerImageView, isPlayerwin: false)
            
        }
    }
    
    //勝敗判定をする
        func judgeBattle(){
            if player.currentHP <= 0 {
                
            }
        }
        
    //勝敗が決定した時の処理
    func finishBattle(vanishImageView: UIImageView, isPlayerwin: Bool){
        
        techMonManager.vanishAnimation(imageView: vanishImageView)
        techMonManager.stopBGM()
        gameTimer.invalidate()
        isPlayerAttackAvalable = false
        
        var finishMessage: String = ""
        if  isPlayerWin {
            
            techMonManager.playSE(fileName: "SE_fanfare")
            finishMessage = "勇者の勝利！！"
        } else {
            
            techMonManager.playSE(fileName: "SE_gameover")
            finishMessage = "勇者の敗北..."
            
        }
       let alert = UIAlertController(title:"バトル終了", message: finishMessage, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
    
          self.dismiss(animated: true, completion: nil)
       }))
       present(alert, animated: true, completion: nil)
   
    }
        
    //勝敗判定をする
    func judgeBattle(){
            if player.currentHP <= 0 {
                
    }
    
    
    @IBAction func atttackAction(){
        
        if isPlayerAttackAvalable {
            
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playSE(fileName: "SE_attack")
            
            enemycurrentHP -= 30
            playercurrentMP = 0
            
            enemyHPLabel.text = "\(enemyHP)/ 200"
            playerMPLabel.text = "\(playerMP)/20"
            
            if enemyHP <= 0 {
                finishBattle(vanishImageView: enemyImageView, isPlayerWin: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
}
