# Convertendo objetos de forma fácil e eficiente

Realizando cast com __PSCustomObject__, além do código ficar mais simples, ele ficará bem mais rápido.

## Comparativo de tempos

```
# Add-Member
TotalMilliseconds : 2841.435

# PSObject -Property
TotalMilliseconds : 124.1155

# PSCustomObject
TotalMilliseconds : 34.8454
```
## Código dos testes

```
function AddMemberTest
{
    param($count=1000)

    for ($i = 0; $i -lt $count; $i++)
    {
        $obj = New-Object PSObject
        $obj | Add-Member NoteProperty Member1 "member1"
        $obj | Add-Member NoteProperty Member2 "member2"
    }
}

function CreateDirectlyTest
{
    param($count=1000)

    for ($i = 0; $i -lt $count; $i++)
    {
        $obj = New-Object PSObject -Property @{Member1="member1";Member2="member2"}
    }
}

function CreateDirectlyTestWithCustom
{
    param($count=1000)

    for ($i = 0; $i -lt $count; $i++)
    {
        $obj = [PSCustomObject] @{Member1="member1";Member2="member2"}
    }
}

Measure-Command {AddMemberTest}
Measure-Command {CreateDirectlyTest} 
Measure-Command {CreateDirectlyTestWithCustom} 
```
