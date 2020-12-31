
import Foundation
import CoreData

class CDNote: NSManagedObject {
    class func createOrUpdate(id: UUID, title: String, content: String, createdDate: Date) -> Note {
        print("createOrUpdate note")
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", id.uuidString)
        
        do {
            let notes = try AppDelegate.viewContext.fetch(request)
            if notes.count > 0 {
                assert(notes.count == 1, "Ooops, more than one note with the same title")
                notes[0].content = content
                
                DispatchQueue.main.async {
                    try? AppDelegate.viewContext.save()
                }
                
                return notes[0]
            }
        } catch {
            print("Error getting notes")
        }
        let note = Note(context: AppDelegate.viewContext)
        
        note.id = id
        note.title = title
        note.content = content
        note.createdDate = createdDate
        
        DispatchQueue.main.async {
            try? AppDelegate.viewContext.save()
        }
        
        return note
    }
}
