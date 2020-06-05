PROJETO="$1"
CONTEXTO="$2"
CONSOLE="$3"

echo "Criando diretórios"
mkdir "$PROJETO"
cd "$PROJETO"
mkdir src
cd src

echo "Criando a solução"
dotnet new sln -n "$PROJETO"

echo "Criando os projetos"
mkdir "$CONTEXTO"
cd "$CONTEXTO"
dotnet new classlib -n "$PROJETO.$CONTEXTO.Application" -f netcoreapp3.1
dotnet new classlib -n "$PROJETO.$CONTEXTO.Domain" -f netcoreapp3.1
dotnet new classlib -n "$PROJETO.$CONTEXTO.Infra.Data" -f netcoreapp3.1
dotnet new classlib -n "$PROJETO.$CONTEXTO.Infra.Ioc" -f netcoreapp3.1

if [ "$CONSOLE" = "console" ];
then
    dotnet new console -n "$PROJETO.$CONTEXTO.Console" -f netcoreapp3.1
else
    dotnet new webapi -n "$PROJETO.$CONTEXTO.Api" -f netcoreapp3.1
fi
cd ..

echo "Adicionando os projetos à solução"
if [ "$CONSOLE" = "console" ];
then
    dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Console/$PROJETO.$CONTEXTO.Console.csproj"
else
    dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Api/$PROJETO.$CONTEXTO.Api.csproj"
fi

dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Application/$PROJETO.$CONTEXTO.Application.csproj"
dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Domain/$PROJETO.$CONTEXTO.Domain.csproj"
dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Infra.Data/$PROJETO.$CONTEXTO.Infra.Data.csproj"
dotnet sln add "$CONTEXTO/$PROJETO.$CONTEXTO.Infra.Ioc/$PROJETO.$CONTEXTO.Infra.Ioc.csproj"

cd "$CONTEXTO"

echo "Adicionando as referências"
cd "$PROJETO.$CONTEXTO.Application"
dotnet add reference "../$PROJETO.$CONTEXTO.Domain/$PROJETO.$CONTEXTO.Domain.csproj"
cd ..

cd "$PROJETO.$CONTEXTO.Infra.Data"
dotnet add reference "../$PROJETO.$CONTEXTO.Domain/$PROJETO.$CONTEXTO.Domain.csproj"
cd ..

cd "$PROJETO.$CONTEXTO.Infra.Ioc"
dotnet add reference "../$PROJETO.$CONTEXTO.Application/$PROJETO.$CONTEXTO.Application.csproj"
dotnet add reference "../$PROJETO.$CONTEXTO.Domain/$PROJETO.$CONTEXTO.Domain.csproj"
dotnet add reference "../$PROJETO.$CONTEXTO.Infra.Data/$PROJETO.$CONTEXTO.Infra.Data.csproj"
cd ..

if [ "$CONSOLE" = "console" ];
then
    cd "$PROJETO.$CONTEXTO.Console"
else
    cd "$PROJETO.$CONTEXTO.Api"
fi
dotnet add reference "../$PROJETO.$CONTEXTO.Application/$PROJETO.$CONTEXTO.Application.csproj"
dotnet add reference "../$PROJETO.$CONTEXTO.Infra.Ioc/$PROJETO.$CONTEXTO.Infra.Ioc.csproj"
cd ..


echo "Adicionando os pacotes nuget"
cd "$PROJETO.$CONTEXTO.Infra.Ioc"
dotnet add package Microsoft.Extensions.Configuration
dotnet add package Microsoft.Extensions.Configuration.Abstractions
dotnet add package Microsoft.Extensions.DependencyInjection
dotnet add package Microsoft.Extensions.Hosting
dotnet add package Microsoft.Extensions.Hosting.Abstractions
cd ..

cd "$PROJETO.$CONTEXTO.Infra.Data"
dotnet add package Microsoft.EntityFrameworkCore
cd ..

if [ "$CONSOLE" != "console" ];
then
    cd "$PROJETO.$CONTEXTO.Api"
    dotnet add package Swashbuckle.AspNetCore.SwaggerGen
    dotnet add package Swashbuckle.AspNetCore.SwaggerUI
    cd ..
fi


