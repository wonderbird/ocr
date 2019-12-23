Param(
    [parameter(Mandatory=$true,HelpMessage="Path to the input PDF file")]
    $FileName)

$BaseName=[io.path]::GetFileNameWithoutExtension($FileName)
$TargetName="$BaseName eBook.pdf"

$IntermediateDir="temp"
$IntermediateOcrName=".\$IntermediateDir\$BaseName OCR.pdf"
$IntermediatePngNameWithPlaceholder=".\temp\$BaseName-%03d.png"

Write-Host "OCR tracing the file ""$FileName"" to ""$TargetName""" -ForegroundColor Green

New-Item "$IntermediateDir" -ItemType Directory >$null

Write-Host "Extracting PNG files" -ForegroundColor Green
magick -density 300 "$FileName" "$IntermediatePngNameWithPlaceholder"

Write-Host "Running OCR tracing with tesseract" -ForegroundColor Green
Get-ChildItem ".\$IntermediateDir" -Filter *.png | 
Foreach-Object {
    Write-Host "Processing ""$_"""
    tesseract $_.FullName .\$IntermediateDir\$_.BaseName -l deu --dpi 300 pdf >$null
}

Write-Host "Concatenating results" -ForegroundColor Green
pdftk ".\$IntermediateDir\*-*.pdf" cat output "$IntermediateOcrName"

# Compress the output file
# Follow the instructions found here: https://pandemoniumillusion.wordpress.com/2008/05/07/compress-a-pdf-with-pdftk/
Write-Host "Compressing" -ForegroundColor Green

# Just another method to compress: https://gist.github.com/firstdoit/6390547
# Parameters:
# /printer = output for printer (high quality)
# /ebook   = output for eBook reader (medium quality)
# /screen  = output for screen reading (low quality, for a 72 dpi display)
gswin64c "-sDEVICE=pdfwrite" "-dCompatibilityLevel=1.5" "-dPDFSETTINGS=/ebook" "-dNOPAUSE" "-dQUIET" "-dBATCH" "-sOutputFile=$TargetName" "$IntermediateOcrName"

Write-Host "Cleaning up" -ForegroundColor Green
Remove-Item -Recurse -Force "$IntermediateDir"
