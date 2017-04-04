
$targetFiles=
    @("$PSScriptRoot'\..\IXOS File Name Extensions\Product.wxs")


function IncreaseMajor(){
    [CmdletBinding()]
    Param(

        [Parameter(Position=0, Mandatory=$true)]
        [string] $file
    )

    UpdateVersion $file { param($oldVersion) New-Object System.Version -ArgumentList ($oldVersion.Major+1), 0, 0 }
}

function IncreaseMinor(){
    [CmdletBinding()]
    Param(

        [Parameter(Position=0, Mandatory=$true)]
        [string] $file
    )

    UpdateVersion $file { param($oldVersion) New-Object System.Version -ArgumentList $oldVersion.Major, ($oldVersion.Minor+1), 0 }
}

function IncreaseBuild(){
    [CmdletBinding()]
    Param(

        [Parameter(Position=0, Mandatory=$true)]
        [string] $file
    )

    UpdateVersion $file { param($oldVersion) New-Object System.Version -ArgumentList $oldVersion.Major, $oldVersion.Minor, ($oldVersion.Build+1) }

}


function UpdateVersion(){
    [CmdletBinding(DefaultParametersetName='InvokeBuild')]
    Param(

        [Parameter(Position=0, Mandatory=$true)]
        [string] $file,
        [Parameter(Position=1, Mandatory=$true)]
        [ScriptBlock] $updateScript
    )

    $file=Convert-Path $file

    Write-Verbose "Opening file '$file'"
    $doc=[xml]::new()
    $doc.PreserveWhitespace=$true
    $doc.Load($file)
    $xml=$doc#[xml](cat $file)

    $productVersionNode=$xml.Wix.Product.Version
 
    $oldVersion=[Version]::Parse($productVersionNode)
    Write-Verbose "Current version number is '$oldVersion'"
   
    $newVersion= & $updateScript $oldVersion
    Write-Verbose "New version number is '$newVersion'"
    $xml.Wix.Product.Version=$newVersion.ToString()

    $oldProductId=$xml.Wix.Product.Id
    Write-Verbose "Current product id is '$oldProductId'"
   
    $newProductId=[Guid]::NewGuid().ToString()
    Write-Verbose "New product id is '$newProductId'"
    $xml.Wix.Product.Id=$newProductId

    Write-Verbose "Saving file '$file'"
    $xml.Save($file)
}

