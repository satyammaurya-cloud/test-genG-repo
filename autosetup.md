### To check Detailed OS Info
```bash
cat /etc/os-release
```
### To setup the environment 

```bash
# 1. To download the az cli

curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash

# 2. To download the terraform

gwget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# 3. To download the aws-cli

curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash
```
### Additional login command with placeholders for credentials:
```bash
az login --service-principal -u "Client_ID" -p "Secret_Value" --tenant "Tenant_ID"
```
