# Wrong Function Return

* PowerShell functions will always return (as object[], if there’s more than one return value):
    * all uncaptured objects (i.e. objects that haven’t been assigned to variables)
    * as well as all output (from echo/Write-Output)

* Exclude from return value: 
    * Uncaptured objects: prefix with [void]
    * Console output: use Write-Host instead of echo/Write-Output 

```
function Test-WrongReturn
{
    $stb = New-Object System.Text.StringBuilder;
    
    $stb.Append('Opa'); # Será retornado
    
    return $stb; # Também será retornado
}

function Test-IgnoreWithVoid
{
    $stb = New-Object System.Text.StringBuilder;
    
    [void]$stb.Append('Opa'); # Será ignorado
    
    return $stb; # Será retornado
}

function Test-IgnoreWithNull
{
    $stb = New-Object System.Text.StringBuilder;
    
    $stb.Append('Opa') | Out-Null; # Será ignorado
    
    return $stb; # Será retornado
}
```

Mais informações em:

http://manski.net/2013/03/powershell-functions-for-the-uninitiated-c-programmer/

> TODO: Adicionar uma fonte oficial