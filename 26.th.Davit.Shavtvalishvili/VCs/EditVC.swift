//
//  EditVC.swift
//  26.th.Davit.Shavtvalishvili
//
//  Created by a on 26.08.22.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet var titleText: UILabel!
    @IBOutlet var notedText: UITextView!
    @IBOutlet var favoriteButton: UIButton!
    weak var delegate: saveAndReload? = nil
    var note: TakenNote? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    @IBAction func goBack(_ sender: Any) { self.dismiss(animated: true, completion: nil) }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if note!.isFavorite { favoriteButton.tintColor = .darkGray
        } else { favoriteButton.tintColor = .yellow }
        note!.isFavorite = !note!.isFavorite
        saveAndUpdade()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if delegate != nil && note != nil {
            note?.text = notedText.text
        }
        saveAndUpdade()
    }
    
    func config() {
        if note != nil {
            titleText.text = note!.title
            notedText.text = note!.text
            var color: UIColor = .darkGray
            if note!.isFavorite == true { color = .yellow }
            favoriteButton.tintColor = color
        }
    }
    
    func saveAndUpdade() {
        if delegate != nil {
            delegate!.getNotesData()
            delegate!.saveData()
        }
    }
}
