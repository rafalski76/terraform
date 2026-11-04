# Terraform

[![Lint](https://github.com/rafalski76/terraform/actions/workflows/lint.yml/badge.svg)](https://github.com/rafalski76/terraform/actions/workflows/lint.yml)

Przykłady infrastruktury jako kodu z warsztatów Terraform (AWS i GCP) wraz ze środowiskiem
uruchomieniowym w Vagrancie.

## Wymagania

- [Vagrant](https://www.vagrantup.com/) i [VirtualBox](https://www.virtualbox.org/) (środowisko `runner`)
- konto AWS z kluczami dostępu (przykłady AWS) oraz projekt GCP (przykład `gcp/`)
- Terraform `>= 1.10` (instalowany automatycznie na maszynie `runner`)

## Struktura repozytorium

| Katalog | Opis |
| --- | --- |
| `00-ctrl-c-ctrl-v/` | Zbiór snippetów do kopiowania (VPC, backend S3, `for_each`, key pair). Nie jest to jedna spójna konfiguracja. |
| `01-example/` | Instancje EC2, VPC, security group i wywołanie modułu lokalnego |
| `modules/instance_example/` | Przykładowy moduł tworzący instancję EC2 z security group |
| `gcp/` | Maszyna wirtualna w Google Compute Engine ze stanem w GCS ([opis komend](gcp/README.md)) |
| `projekt/` | Rozwiązanie zadania z [PROJEKT.md](PROJEKT.md) |
| `.vagrant-provision/` | Skrypt przygotowujący maszynę `runner` (Terraform, AWS CLI) |

## Szybki start

1. Utwórz pliki `.vagrant-provision/aws/config` i `.vagrant-provision/aws/credentials` z danymi dostępowymi do AWS.
2. Uruchom środowisko:

```shell
vagrant up           # przygotowanie środowiska
vagrant ssh runner   # połączenie do maszyny wirtualnej

aws sts get-caller-identity

cd /vagrant/01-example
terraform init
terraform plan
terraform apply
terraform destroy    # sprzątanie zasobów
```

## Wersje

Konfiguracje używają providera `hashicorp/aws ~> 6.0`, `hashicorp/google ~> 8.0`
oraz modułu `terraform-aws-modules/vpc/aws ~> 6.0`. Obrazy: Ubuntu 24.04 (AWS AMI i box Vagranta),
Debian 12 (GCP). Pliki `.terraform.lock.hcl` są wersjonowane.

## Lint / CI

Workflow [`lint.yml`](.github/workflows/lint.yml) uruchamia `terraform fmt`, `terraform validate`,
`tflint` oraz `shellcheck`. Lokalnie: `terraform fmt -recursive && tflint --recursive`.

> Uwaga: security group w przykładach otwiera cały ruch z internetu (`0.0.0.0/0`) –
> to wyłącznie środowisko demonstracyjne, nie używaj tego w produkcji.
