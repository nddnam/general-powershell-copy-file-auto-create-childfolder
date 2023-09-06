############################
#GENERATE DEMO INPUT FILE
########################
#$SOURCE_ROOT_PATH = 'C:\Users\Roger\Desktop\Azure'
#$INPUT_FILE = 'C:\Users\Roger\Desktop\input.csv'
#Get-ChildItem -Recurse -Path $SOURCE_ROOT_PATH `
#    | where { ! $_.PSIsContainer } `
#    | select Directory, Name `
#    | Export-Csv $INPUT_FILE `
#        -Delimiter "," `
#        -NoTypeInformation `
#        -Force
###############################



$file = Import-Csv $INPUT_FILE -Delimiter "," #header in CSV file| Column-1: Directory | Column-2: Name
$DEST_ROOT_PATH = 'C:\DEST' #USB storage destination

foreach ($obj in $file) {

    $SOURCE_PATH = $obj.Directory
    $SOURCE_PATH_FILE = [Management.Automation.WildcardPattern]::Escape($SOURCE_PATH + '\' + $obj.Name)
    #To add the Escape symbol before any special charecter in source path

    $DEST_PATH_FILE = Join-Path -Path $DEST_ROOT_PATH `
                                -ChildPath $(Split-Path $SOURCE_PATH_FILE -NoQualifier)

    $DEST_PATH_FILE_PARENT = $(Split-Path -Path $DEST_PATH_FILE -Parent)
    #destination path without filename

    IF (Test-Path -LiteralPath $DEST_PATH_FILE_PARENT ) {

        Copy-Item $SOURCE_PATH_FILE $DEST_PATH_FILE_PARENT
        
        #Write-Host -ForegroundColor Yellow $SOURCE_PATH_FILE
        #Write-Host -ForegroundColor Red $DEST_PATH_FILE_PARENT
        #Write-Host -ForegroundColor Yellow ("EXISTING FOLDER")
        #for debugging

    }

    ELSE {

        $newfolder = New-Item -ItemType Directory $DEST_PATH_FILE_PARENT
        #create new sub-folder

        Copy-Item $SOURCE_PATH_FILE $DEST_PATH_FILE_PARENT
        
        #Write-Host -ForegroundColor Yellow $SOURCE_PATH_FILE
        #Write-Host -ForegroundColor Red $DEST_PATH_FILE_PARENT
        #Write-Host -ForegroundColor Green ("NEW FOLDER")
        #for debugging
    }
}