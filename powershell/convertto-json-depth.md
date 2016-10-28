# ConvertTo-Json -Depth X

Ao converter um objeto para json através do comando `ConvertTo-Json` é necessário informar o parâmetro Depth, pois senão os níveis abaixo serão ignorados e tratados como texto.

## Exemplo
```

$companies = @(
    @{
        name = 'Contoso';
        address = @{
            addressLine1 = 'Contoso Avenue';
            city = 'Seatle';
            country = @{
                code = 1033;
                name = 'USA';
            };
        };
    }
);

ConvertTo-Json $companies;
ConvertTo-Json $companies -Depth 3;

```

## Resultado

```
[
    {
        "name":  "Contoso",
        "address":  {
                        "addressLine1":  "Contoso Avenue",
                        "country":  "System.Collections.Hashtable", // OOOOPS!
                        "city":  "Seatle"
                    }
    }
]
[
    {
        "name":  "Contoso",
        "address":  {
                        "addressLine1":  "Contoso Avenue",
                        "country":  {
                                        "code":  1033,
                                        "name":  "USA"
                                    },
                        "city":  "Seatle"
                    }
    }
]
```