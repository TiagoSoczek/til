# Powershell Intellisense

É possivel utilizar uma lista de possiveis comandos no Powershell, assim como funciona o Intellisense do Visual Studio.
  
#Aperte Ctrl + Space.

Ex.: Crie uma nova variavel: 

```
$obj = New-Object PSObject -Property @{Member1="member1";Member2="member2"}
```
Digite:
```
$obj.
```
Aperte Ctrl + Espaço. As possíveis opções vão ser apresentadas para auto-complete.

Esse script só será executado se o powershell for v5 ou superior. (Não foi testado em versões anteriores)