```markdown
# Script de Atualização do GLPI

Este script automatiza o processo de atualização do GLPI para a versão 10.0.18. Ele realiza backup, substituição dos arquivos, restauração das configurações, permissões e atualização do banco de dados.

## ⚙️ Requisitos

- Distribuição baseada em Debian/Ubuntu
- Apache2 (`apache2` como nome de serviço)
- GLPI já instalado em `/var/www/html/glpi`
- Permissões de root (ou uso com `sudo`)

## 🚀 O que o script faz

1. Atualiza o sistema operacional
2. Cria backup do diretório atual do GLPI
3. Remove a versão antiga do GLPI
4. Baixa e extrai a nova versão
5. Para o serviço Apache
6. Restaura as pastas importantes: `config`, `files`, `plugins`, `marketplace`
7. Aplica permissões corretas
8. Inicia o Apache novamente
9. Atualiza a estrutura do banco de dados

## 🔄 Atualização do Banco de Dados

Durante o processo de upgrade, a estrutura do banco de dados precisa ser atualizada para se adequar à nova versão do GLPI.

O comando:

```bash
./console database:update -y
```

## ⚠️ Avisos

- Faça backup e snapshot em caso de VM.
- Faça backup do banco de dados manualmente antes de qualquer atualização.
- Teste o script em ambiente de homologação antes de aplicar em produção.

## 📂 Exemplo de uso

```bash
chamod +x atualizar-glpi-iac.sh
sudo ./atualizar-glpi-iac.sh
```

---

Feito com 💻 por Ismael – Analista de Suporte

