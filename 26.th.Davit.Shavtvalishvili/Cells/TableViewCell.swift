//
//  TableViewCell.swift
//  26.th.Davit.Shavtvalishvili
//
//  Created by a on 26.08.22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var previewText: UILabel!
    @IBOutlet var favor: UIButton!
    weak var delegate: saveAndReload? = nil
    weak var note: TakenNote? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func edit(_ sender: Any) {
        if delegate != nil && note != nil {
            delegate!.presentEditVC(note: self.note!)
        }
    }
    
    @IBAction func deelete(_ sender: Any) {
        if delegate != nil {
            delegate!.deleteNote(note: self.note!)
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        if note!.isFavorite { favor.tintColor = .darkGray
        } else { favor.tintColor = .yellow }
        note!.isFavorite = !note!.isFavorite
        if delegate != nil {
            delegate!.getNotesData()
            delegate!.saveData()
        }
    }
    
    func config() {
        if note != nil {
            let n = note!
            title.text = n.title
            if n.text != "" { previewText.text = n.text; previewText.textColor = .black
            } else {
                previewText.text = "Once you take a note, it's preview will appear here"
                previewText.textColor = .darkGray
            }
            var color: UIColor = .darkGray
            if n.isFavorite { color = .yellow }
            favor.tintColor = color
        }
    }
}
