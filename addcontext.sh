PROJETO="$1"
CONTEXTO="$2"

echo "Criando diretórios"
cd "$PROJETO"
cd src

echo "Criando os projetos"
mkdir "$CONTEXTO"
cd "$CONTEXTO"
dotnet new classlib -n "$PROJETO.$CONTEXTO.Application"
dotnet new classlib -n "$PROJETO.$CONTEXTO.Domain"
dotnet new classlib -n "$PROJETO.$CONTEXTO.Infra.Data"
dotnet new classlib -n "$PROJETO.$CONTEXTO.Infra.Ioc"
dotnet new webapi -n "$PROJETO.$CONTEXTO.Api"
cd ..

echo "Adicionando os projetos à solução"
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

cd "$PROJETO.$CONTEXTO.Api"
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
dotnet add package Microsoft.EntityFramework
cd ..

cd "$PROJETO.$CONTEXTO.Api"
dotnet add package Swashbuckle.AspNetCore.SwaggerGen
dotnet add package Swashbuckle.AspNetCore.SwaggerUI
cd ..

