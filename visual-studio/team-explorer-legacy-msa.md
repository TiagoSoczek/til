# Team Explorer - Legacy MSA

Para ser possível acessar o VSTS https://tenant.visualstudio.com/ pelo Visual Studio, é necessário alterar a seguinte chave do registro:

## VS 2013:
`reg add HKCU\Software\Microsoft\VisualStudio\12.0\TeamFoundation /v LegacyMSA /d True /f`

## VS 2015:
`reg add HKCU\Software\Microsoft\VisualStudio\14.0\TeamFoundation /v LegacyMSA /d True /f`