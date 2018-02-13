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
    
    var playerHP = 100
    var playerMP = 0
    var enemyHP = 100
    var enemyMP = 0
    
    var gameTimer: Timer!
    var isPlayerAttackAvalable: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プレイヤーのステータスを反映
        playerNameLabel.text  = "勇者"
        playerImageView.image = UIImage(named: "yusha.png")
        playerHPLabel.text = "\(playerHP)/ 100"
        playerMPLabel.text = "\(playerMP)/ 20"
        
        //敵のステータスを反映
        enemyNameLabel.text  = "勇者"
        enemyImageView.image = UIImage(named: "monster.png")
        enemyHPLabel.text = "\(enemyHP)/ 200"
        enemyMPLabel.text = "\(enemyMP)/ 35"
        
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
        TechMonManager.stopBGM()
    }
    
    //0.1秒ごとにゲームの状態を更新する
    func updateaGame(){
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
            finishBattle(vanishImageView: playerMPLabel, isPlayerwin: false)
            
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
    
    
       let alert = UIAlertController(title:"バトル終了", message: finishMessage, prefferedstyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
    
          self.dismiss(animated: true, completion: nil
        })))
       present(alert, animated: true, completion: nil)
   
    }
    
    
    @IBAction func atttackAction(){
        if isPlayerAttackAvalable {
            
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playerSE(fileName: "SE_attack")
            
            enemyHP -= 30
            playerMP = 0
            
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
