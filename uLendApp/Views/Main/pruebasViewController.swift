//
//  pruebasViewController.swift
//  uLendApp
//
//  Created by Manu on 19/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

class pruebasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var celdas: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = celdas.dequeueReusableCell(withIdentifier: "prueba", for: indexPath) as! pruebaTableViewCell
        
        return celda
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
            celdas.delegate = self
        celdas.dataSource = self
        // Do any additional setup after loading the view.
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
