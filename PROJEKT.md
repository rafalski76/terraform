# Projekt Terraform

Korzystając z konfiguracji Vagranta używanej podczas warsztatów:

Przygotuj konfigurację Terraforma, która stworzy:

- parę kluczy z Twojego klucza SSH (wygenerowany w Vagrancie podczas provisioningu)
- maszynę EC2 (instancję) w domyślnym VPC, do której będziesz mógł się połączyć po SSH
- Security Group, które pozwala na połączenie SSH do Twojej instancji z internetu
- VPC, z 2 podsieciami prywatnymi i 2 publicznymi
  - [opcjonalnie] można użyć modułu z Terraform Registry
- przenieś (co może się wiązać z usunięciem i stworzeniem ponownie) maszynę ec2 do publicznej podsieci Twojego VPC
- utwórz maszynę w prywatnej podsieci
  - połącz się po SSH do maszyny w prywatnej podsieci
- Usuń utworzone zasoby
