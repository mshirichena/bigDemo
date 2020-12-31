

import UIKit
import CoreData

// Creating Object
struct Note {
    var id: UUID? // to enable app to save same data
    var title: String?
    var content: String?
    var createdDate: Date?
    
    
    init(id: UUID) {
        self.id = id
        self.createdDate = Date()
    }
    
    init(id: UUID,title:String, content:String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdDate = Date()
    }
    
}
// Enables creation of new notes
protocol NoteCreationDelegate {
    func noteReturned(note: Note?, sender: UIViewController)
    
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NoteCreationDelegate {
    
    
    
    @IBOutlet weak var addNewNoteButton: UIButton!
    @IBOutlet weak var notesTV: UITableView!
    
    var notes: [Note] = [Note]()
    var selectedNote: Note?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readCoreData()
    }
    // Disselecting in order to transition back to homeviewcontroller from selected note viewcontroller
    override func viewWillAppear(_ animated: Bool) {
        selectedNote = nil
        notesTV.reloadData() // disselects by reloading data
    }
    
    private func readCoreData() {
        let request: NSFetchRequest<Note> = Note.NSFetchRequest()
        
        do {
            notes = try AppDelegate.viewContext.fetch(request)
        } catch {
            print("Error getting notes")
        }
    }
    
    //MARK: - Target Actions
    @IBAction func addNewButtonPressed(_ sender: Any) {
        //transition to next story board after add button pressed
        performSegue(withIdentifier: "show note", sender: self)
    }
    
    //MARK: - TableViews:- Providing numbers of Rows and Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieving cell objects
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        // Configuring custom cell views
        cell.cellTopLabel.text = notes[indexPath.row].title
        cell.cellContentLabel.text = notes[indexPath.row].content
        //Returning cell to tableview.
        return cell
    }
    // method that enables selecting the two notes
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        //Both notes transition to second storyborad when slected or clicked
        performSegue(withIdentifier: "show note", sender: self)
    }
    //MARK: - Delegate Calls
    // When new notes are created
    func noteReturned(note: Note?, sender: UIViewController) {
        notes.removeAll()
        readCoreData()
        notesTV.reloadData()
        //        //Unwrap note optional
        //        guard let myNote = note else { return }
        //        notes.append(myNote)
//        if let note = note {
//            print("Note: \(note)")
//            if let index = notes.firstIndex(where: { one in
//                one.id == note.id
//            }) {
//                print("First index: \(index)")
//                self.notes[index] = note
//                notesTV.insertRows(at: [IndexPath(row: notes.count-1, section: 0)], with: .left)
//            } else {
//                //        // create an indexpath to insert new row
//                //        IndexPath(row: notes.count-1, section: 0)
//                notes.append(note)
//                //Insert below
//                notesTV.insertRows(at: [IndexPath(row: notes.count-1, section: 0)], with: .automatic)
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check to see if accessing correct segue
        if segue.identifier == "show note", let destination = segue.destination as? SelectedNoteViewController {
            destination.note = selectedNote
            // Inform second view controller of set delegate
            destination.delegate = self
        }
    }
}


