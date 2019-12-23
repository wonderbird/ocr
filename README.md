# OCR Tracing for PDF Files

This script converts an image based multipage PDF file
into a PDF file with images and text.

## Prerequisites

1. Install the recommended [ImageMagick Q16 64bit release](https://imagemagick.org/script/download.php#windows) and add the "magick" command to the PATH
2. Install [GhostScript 64bit (AGPLv3)](https://www.ghostscript.com/download/gsdnld.html) and ensure that the "gswin64c" command is on the PATH
3. Install [PDFtk Server](https://www.pdflabs.com/tools/pdftk-server/) and add the "pdftk" command to the PATH
4. Install [Tesseract 64bit (>= 5.0.0 Alpha)](https://github.com/UB-Mannheim/tesseract/wiki) including the German language files, add the "tesseract" command to the PATH and set the "TESSDATA_PREFIX" variable to the "tessdata" directory of your installation

## Running the Script

On a Windows Command Prompt execute the following batch file

```
ocr.bat "Your File.pdf"
```

`Your File.pdf` will then be converted page by page. The result will be stored in `Your File eBook.pdf`.

## Notes

During conversion a folder `temp` will be created to hold temporary files. The folder will be deleted after converting.
