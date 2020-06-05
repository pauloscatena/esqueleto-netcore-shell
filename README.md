# esqueleto-netcore-shell
A ideia deste projeto eh criar um contexto inteiro em clean architecture sem frescura

# Uso (testado no Linux, ate agora...): 
./newproject.sh "NomeDaSolucao" "NomeDoContexto" ["console"]

Exemplo: 
./newproject.sh "SolucaoTeste" "Usuarios" --> Vai criar uma API
./newproject.sh "SolucaoTeste" "Usuarios" "console" --> Vai criar um console App


# Para adicionar um novo contexto na solução
./addcontext.sh "NomeDaSolucao" "NomeDoContexto"

Exemplo: 
./addcontext.sh "SolucaoTeste" "Estoque" --> Vai adicionar uma API
./addcontext.sh "SolucaoTeste" "Estoque" console --> Vai adicionar um Console App
