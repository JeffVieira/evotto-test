# Evotto - Ruby Test

### Objetivo

Crie um mini aplicativo (CLI) capaz de ler um arquivo CSV (data/users.csv), e classificar os dados. O aplicativo precisa:
- Listar os usuários
- Classificar os usuários pelos parâmetros
- Mostrar o total de um parâmetro por comando
- Exibir dados de um usuário especifico

Modo de uso esperado:

(com ordem)

```
ruby app.rb --source data/users.csv --order_by age desc

# Results (console output)
Name | Age | ProjectCount | TotalValue
John | 32 anos | 3 | 25
Maria | 27 anos | 4 | 49
...
```

Também pode exibir sem ordem:

```
ruby app.rb --source data/users.csv

# Results (console output)
Name | Age | ProjectCount | TotalValue
Maria | 27 anos | 4 | 49
John | 32 anos | 3 | 25
...
```

Exibir os resultados:

```
ruby app.rb --source data/users.csv --total TotalValue

# Results (console output)
TotalValue: 74
```

Encontrar usuário especifico:

```
ruby app.rb --source data/users.csv --find John

# Results (console output)
Name | Age | ProjectCount | TotalValue
John | 32 anos | 3 | 25
```

Encontrar um ou mais usuários:

```
ruby app.rb --source data/users.csv --find John Salvador

# Results (console output)
Name | Age | ProjectCount | TotalValue
John | 32 anos | 3 | 25
Slavador | 25 anos | 3 | 20
```

### Requerimentos

- Ruby 2.3.1
- Deve ser possível utilizar a biblioteca diretamente (Não apenas a CLI) para efetuar os testes
