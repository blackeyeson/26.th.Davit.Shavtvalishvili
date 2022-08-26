//
//  FavNotes.swift
//  26.th.Davit.Shavtvalishvili
//
//  Created by a on 26.08.22.
//

import UIKit

class FavNotes: UIViewController, saveAndReload {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputedTitle: UITextField!
    var notesArr: [TakenNote] = []
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotesData()
        mainTableViewConfiguration()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("com.test.reload"), object: nil)
    }
    
    @IBAction func create(_ sender: Any) {
        if inputedTitle.text != nil && inputedTitle.text != "" {
            createNote(title: inputedTitle.text!, text: "", isFavorite: true); inputedTitle.text = ""
        }
    }
    
    func createNote(title: String, text: String, isFavorite: Bool) {
        let newNote = TakenNote(context: managedContext)
        newNote.title = title
        newNote.text = text
        newNote.isFavorite = isFavorite
        
        saveData()
        getNotesData()
    }
    
    func getNotesData() {
        do {
            self.notesArr = try managedContext.fetch(TakenNote.fetchRequest())
        } catch { print(error) }
        notesArr = notesArr.filter { $0.isFavorite }
        self.tableView.reloadData()
    }
    
    func deleteNote(note: TakenNote) {
        managedContext.delete(note)
        saveData()
        getNotesData()
    }
    
    func saveData() {
        do { try managedContext.save() } catch { print(error) }
        NotificationCenter.default.post(name: Notification.Name("com.test.reload"), object: 1)
    }
    
    func presentEditVC(note: TakenNote) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditVC") as! EditVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.delegate = self
        vc.note = note
        present(vc, animated: true, completion: nil)
    }
    
    @objc func reload(notification: Notification) {
        getNotesData()
    }
}

extension FavNotes: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { notesArr.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let i = indexPath[1]
        cell.index = i
        cell.delegate = self
        cell.note = notesArr[i]
        cell.config()
        return cell
    }
    
    func mainTableViewConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.reloadData()
    }
}