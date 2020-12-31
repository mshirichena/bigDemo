

import UIKit

class SelectedNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Note?
    // set delegate variable
    var delegate: NoteCreationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hides ok button
        OkButton.alpha = 0
        titleTF.text = note?.title
        contentTextView.text = note?.content
    }
    //MARK:- Delegate calls
    // Manipulate textfields
   
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
       
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 1) {// shows ok button
            self.OkButton.alpha = 1
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        OkButton.alpha = 0
    }
    
    //MARK:- Target Actions
    @IBAction func textFieldDone(_ sender: UITextField) {
    }
    @IBAction func okButtonPressed(_ sender: UIButton) {
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let title = titleTF.text, let content =  contentTextView.text {
            note = Note(id: UUID(), title: title, content: content)
            delegate?.noteReturned(note: note, sender: self)
        }
//        //Title - from struct - NoteObject
//        note?.title = titleTF.text
//        // content - from struct - NoteObject
//        note?.content = contentTextView.text
//        // checking for nil condition
//        if note?.title != nil, note?.content != nil {
//        //Every time save button is pressed-(from HomeVC func: noteReturned )
//        delegate?.noteReturned(note: note, sender: self)
        dismiss(animated: true, completion: nil)
    }
}
