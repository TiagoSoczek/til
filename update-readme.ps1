function Run
{
    $docs = Get-Docs
    
    Update-Template -docs $docs;
    
    Write-Host ('Done!');
}

function Update-Template
{
    param($docs)
    
    $toc = Build-Toc -docs $docs;
    
    Write-Host ('Reading template');
    $template = Get-Content 'README.template.md';
    
    $template = $template.Replace('{DocsToc}', $toc);
    $template = $template.Replace('{DocsCount}', @($docs).Count);
    
    Write-Host ('Updating readme');
    Set-Content -Value $template -Path 'README.md';
}

function Build-Toc
{
    param($docs)
    
    Write-Host ('Building TOC');
    
    $stb = New-Object System.Text.StringBuilder;
    
    $stb.AppendLine('### Categories') | Out-Null;
    $stb.AppendLine('') | Out-Null;
    
    $docsByCategory = $docs | Group-Object Category | Sort-Object Name;
    
    foreach ($group in $docsByCategory)
    {
        $first = $group.Group | Select -First 1;
        
        $category = ('* [{0}](#{1})' -f $first.FriendlyCategory, $first.Category);
        
        $stb.AppendLine($category) | Out-Null;
    }
    
    $stb.AppendLine('') | Out-Null;

    foreach ($group in $docsByCategory)
    {
        $first = $group.Group | Select -First 1;
        
        $category = ('### {0}' -f $first.FriendlyCategory);
        
        $stb.AppendLine($category) | Out-Null;
        $stb.AppendLine('') | Out-Null;

        foreach($item in $group.Group)
        {
            $doc = ('- [{0}]({1}/{2})' -f $item.FriendlyName, $item.Category, $item.Name);
        
            $stb.AppendLine($doc) | Out-Null;    
        }
        
        $stb.AppendLine('') | Out-Null;
    }
    
    return $stb.ToString();
}

function Get-Docs
{
    Write-Host ('Searching for *.md docs');
    
    $root = Resolve-Path .
    $items = Get-ChildItem *.md -Recurse
    $docs = @();

    foreach($item in $items)
    {
        # Ignore root
        if ($item.Directory.FullName -eq $root.Path)
        {
            continue;
        }
        
        # Ignore sandbox
        if ($item.Directory.Name -eq 'sandbox')
        {
            continue;
        }
        
        $doc = New-Object PSObject -Property @{
            Category = $item.Directory.Name;
            Name = $item.Name;
            FriendlyCategory = (Convert-Name $item.Directory.Name);
            FriendlyName = (Convert-Name $item.Name);
            Item = $item;
        };
        
        $docs += $doc;
    }
    
    Write-Host ('{0} docs found' -f @($docs).Count);
    
    return $docs;
}

function Convert-Name
{
    param($name)
    
    $name = $name.Replace('-', ' ').replace('.md', '');
    
    $name = (Get-Culture).TextInfo.ToTitleCase($name); 
    
    return $name;
}

Run;