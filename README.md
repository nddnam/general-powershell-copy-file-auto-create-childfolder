# general-powershell-copy-file-auto-create-childfolder

The script used to copy the list of file which is imported via csv.
  - CSV structure:
    [column-1] Directory
    [column-2] Name
  - Script will check if the destination path is existing or not
    _existing: starting copy
    _not existing: create new directory recursively then copy


