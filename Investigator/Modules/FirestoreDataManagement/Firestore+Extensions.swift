//
//  Firestore+Extensions.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

//import Firebase
//
//extension DocumentSnapshot {
//	
//	func decodedSnapshot<Model: Decodable>() -> Model? {
//		do {
//			guard let data = self.data() else {
//				print("Problem getting document data")
//				return nil
//			}
//			let json = try JSONSerialization.data(withJSONObject: data, options: [])
//			do {
//				let model = try JSONDecoder().decode(Model.self, from: json)
//				print(model)
//				return model
//			} catch let err {
//				print("Decoding Error: \(err)")
//			}
//		} catch let err {
//			print("Serialization Error: \(err)")
//		}
//		
//		return nil
//	}
//}
//
//extension Firestore {
//	public func fetch<Model : Decodable>(completion: @escaping (Model?) -> Void) {
//		
//		self.getDocument { (document, error) in
//			if let document = document, document.exists {
//				let dataDescription: String = document.data().map(String.init(describing:)) ?? "nil"
//				print("Document data: \(dataDescription)")
//				completion(document.decodedSnapshot())
//			} else {
//				print("Document does not exist")
//			}
//		}
//		
//		completion(nil)
//	}
//}
//
//extension CollectionReference : Logger {
//	/**
//	Add a document to the collection.
//	*/
//	public func addDocument(model: Encodable) {
//		let dictionary = model.tryAsDictionary()
//		self.addDocument(data: dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//}
//
//extension Firestore {
//	/**
//	Updates some fields of the document in the collection without overwriting the entire document.
//	*/
//	public func updateDocument(docRef: DocumentReference, model: Encodable) {
//		let dictionary = model.tryAsDictionary()
//		docRef.updateData(dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//	
//	/**
//	Create or overwrite a single document in the collection.
//	*/
//	public func setData(docRef: DocumentReference, model: Encodable) {
//		let dictionary = model.tryAsDictionary()
//		docRef.setData(dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//	
//	/**
//	Add a document to the collection.
//	*/
//	public func addDocument(collectionRef: CollectionReference, model: Encodable) {
//		let dictionary = model.tryAsDictionary()
//		collectionRef.addDocument(data: dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//	
//	public func firestoreOp(ref: CollectionReference, _: () -> Void) {
//		
//	}
//}
//
//extension Firestore {
//	// MARK:- Destructive
//	
//	/**
//	Warning: Deleting a document does not delete its subcollections!
//	*/
//	public func deleteDocument(collectionRef: CollectionReference, docID: String) {
//		collectionRef.document(docID).delete() { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//	
//	/**
//	Deletes the specific field 'key' from the document.
//	*/
//	public func deleteValueWithKey(docRef: DocumentReference, key: String) {
//		docRef.updateData([
//			key: FieldValue.delete(),
//		]) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//	
//	// Deleting collections from an iOS client is not recommended.
//}
//
//extension Firestore {
//	private func handleCollectionModificationCompletion(error: Any?) {
//		if let err = error {
//			print("Error writing document: \(err)")
//		} else {
//			print("Document successfully written!")
//		}
//	}
//}
//
//protocol Logger {
//	func handleCollectionModificationCompletion(error: Any?)
//}
//extension Logger {
//	func handleCollectionModificationCompletion(error: Any?) {
//		if let err = error {
//			print("Error writing document: \(err)")
//		} else {
//			print("Document successfully written!")
//		}
//	}
//}

// MARK:- Deprecated
// Don't deal with strings here, deal with them at highest level possible.  They should be declared once.

//extension Firestore {
//	/**
//	Updates some fields of the document in the collection without overwriting the entire document.
//	*/
//	public func updateDocument(collection: String, docID: String, model: Encodable) {
//		let db = Firestore.firestore()
//		let ref = db.collection(collection).document(docID)
//
//		let dictionary = model.tryAsDictionary()
//		ref.updateData(dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//
//	/**
//	Add a document to the collection.
//	*/
//	public func addDocument(collection: String, model: Encodable) {
//		// firestore() returns a singleton
//		let db = Firestore.firestore()
//		let dictionary = model.tryAsDictionary()
//
//		db.collection(collection).addDocument(data: dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//
//	/**
//	Create or overwrite a single document in the collection.
//	*/
//	public func setData(collection: String, docID: String, model: Encodable) {
//		// firestore() returns a singleton
//		let db = Firestore.firestore()
//		let dictionary = model.tryAsDictionary()
//
//		db.collection(collection).document(docID).setData(dictionary) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//
//	public func firestoreOp(ref: CollectionReference, _: () -> Void) {
//
//	}
//}
//
//extension Firestore {
//	// MARK:- Destructive
//
//	/**
//	Warning: Deleting a document does not delete its subcollections!
//	*/
//	public func deleteDocument(collection: String, docID: String) {
//		db.collection(collection).document(docID).delete() { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//
//	/**
//	Deletes the specific field 'key' from the document.
//	*/
//	public func deleteValueWithKey(collection: String, docID: String, key: String) {
//		db.collection(collection).document(docID).updateData([
//			key: FieldValue.delete(),
//		]) { err in
//			self.handleCollectionModificationCompletion(error: err)
//		}
//	}
//
//	// Deleting collections from an iOS client is not recommended.
//	public func getDocument<Model : Decodable>(collection: String, docID: String, completion: @escaping (Model?) -> Void) {
//		let docRef = db.collection(collection).document(docID)
//
//		docRef.getDocument { (document, error) in
//			if let document = document, document.exists {
//				let dataDescription: String = document.data().map(String.init(describing:)) ?? "nil"
//				print("Document data: \(dataDescription)")
//				completion(document.decodedSnapshot())
//			} else {
//				print("Document does not exist")
//			}
//		}
//
//		completion(nil)
//	}
//}
