class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException implements CloudStorageException {}

class CouldNoteGetAllNotesException implements CloudStorageException {}

class CouldNotUpdateNoteException implements CloudStorageException {}

class CouldNotDeleteNoteException implements CloudStorageException {}
