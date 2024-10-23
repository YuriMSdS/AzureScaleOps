# AzureScaleOps
## Configuração de uma VM na Azure
Este projeto serve para te guiar no processo de criar uma VM e realizar seu dimensionamento e gerenciamento de recursos.

Primeiro, crie uma máquina virtual no portal da Azure, CLI ou Terraform.

### **No Portal da Azure:**

1. Acesse o Azure Portal.

2. No painel de navegação à esquerda, selecione **"Máquinas Virtuais"**.

3. Clique em **"Adicionar"** e escolha **"Criar uma nova máquina virtual"**.

4. Preencha as seguintes informações:

    `Grupo de recursos`: Selecione um existente ou crie um novo.
    `Nome da VM`: Escolha um nome para sua VM.
    `Região`: Escolha a localização (por exemplo, Brazil South).
    `Tamanho da VM`: Defina o tamanho da VM com base em CPU, memória e outros recursos.
    `Imagem`: Selecione o sistema operacional (como Ubuntu, Windows Server).
    `Nome de usuário e senha`: Configure as credenciais de acesso.
5. **Configure a rede, discos e outros parâmetros (opcional).**

6. Revise e crie.

### Com Terraform
É possível realizar este processo de forma automatizada, script se encontra em `infra/main.tf`

#### Requisitos necessários:

Para criar devidamente sua VM, certifique-se de:
1. Instalar o **Terraform** na sua máquina local.
2. Configurar a **Azure CLI** para autenticação.

#### Instalação da Azure CLI

Caso não tenha instalado a Azure CLI, utilize o seguinte comando:

**Para rodar no Windows:**
```bash
winget install Microsoft.AzureCLI
```

**Para rodar no Linux:**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Para rodar no MacOS:**
```bash
brew update && brew install azure-cli
```

Em seguida faça o login na Azure utilizando:

```bash
az login
```

Após executar `az login`, uma janela será aberta na Azure onde você deverá inserir suas credenciais. Caso você esteja usando o terminal, será solicitado que você insira um código para autenticação.

#### ATENÇÃO:
Insira suas credenciais de acesso à VM no arquivo `secrets.tfvars`, e referencie os valores no arquivo `variables.tf` desta forma será possível utilizar as credenciais sem expô-las no código, ou seja, suas credenciais de acesso permanecerão seguras. Lembre-se **NÃO INCLUA O ARQUIVO SECRETS.TFVARS NO CONTROLE DE VERSÃO**

Após realizar os scripts, seguir os passos abaixo:
1. Iniciar o Terraform
2. Planejar a infra (gera um plano de execução, a fim de verificar o que será criado)
3. Aplicar a configuração (neste passo, criará o banco de dados utilizando as variáveis de credenciais, visando a segurança)

#### Inicializar o Terraform
```bash
terraform init
```

#### Planejar a infra
```bash
terraform plan
```

#### Aplicar a configuração
```bash
terraform apply -var-file="secrets.tfvars"
```
## Dimensionamento da VM (Vertical Scaling)
Depois que sua VM estiver configurada, você pode redimensioná-la para atender a novas necessidades de CPU, memória ou armazenamento.

### Como alterar o tamanho da VM:

1. No portal do Azure, acesse `Máquinas Virtuais` e clique na VM que deseja redimensionar.

2. No painel esquerdo, selecione **Tamanho**.

3. Escolha um novo tamanho baseado nas suas necessidades.
Cada tamanho oferece diferentes capacidades de *CPU*, *memória* e **preço**.

4. Clique em **Redimensionar** para aplicar as alterações. Isso pode causar um reinício na VM.

## Gerenciando Recursos e Autoscaling (Horizontal Scaling)
A Azure oferece a opção de escalonamento automático (horizontal scaling) adicionando ou removendo VMs com base na carga.

### Como configurar o escalonamento automático:

1. No portal, vá até `Grupos de Escala de Máquinas Virtuais`.

2. Crie um novo grupo de escala:
    - Defina o tamanho do grupo inicial (número de VMs).
    - Configure a política de dimensionamento (com base em CPU, memória ou tráfego).

3. Configure a política de escalonamento automático:
    - Aumente o número de VMs quando a CPU ou memória atingir um determinado limite.
    - Reduza o número de VMs quando a carga estiver baixa.

4. Gerenciamento de Custo e Monitoramento
Acompanhe o uso dos recursos para otimizar os custos:
 - Use o Azure Monitor para rastrear o desempenho da sua VM e ajustar recursos conforme necessário.
 - O Azure Cost Management ajuda a acompanhar os custos com relatórios detalhados.