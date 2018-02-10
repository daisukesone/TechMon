//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 曽根大輔 on 2018/02/10.
//  Copyright © 2018年 曽根大輔. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    
    let techMonManager = TechMonManager.shared
    
    var stamina: Int = 100
    @objc var staminaTimer: Timer!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIの設定
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina)/100"
        
        //タイマーの設定
        staminaTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.staminaTimer), userInfo: nil, repeats: true)
        
        staminaTimer.fire()
    }
    
    //ロビー画面が見えるようになるときに呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.stopBGM()
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




