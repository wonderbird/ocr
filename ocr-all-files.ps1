Get-ChildItem ".\" -Filter *.pdf | 
Foreach-Object {
    .\ocr.ps1 -FileName $_.FullName
}
