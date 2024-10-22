# Создание 2-х ВМ && Настройка подключение по ssh

### (Этап развертывания виртуалок пропускаю, т.к по заданию уже предполагается их наличие)
### 1. На хосте 1 проверяем/устанавливаем клиент-сервер ssh
`sudo service ssh status`
![host1_ssh_service_status](https://github.com/user-attachments/assets/6eb0eefd-19ee-42d9-a36c-88fee5d09166)
### 2. Аналогично п.1 проверяем тоже самое для хоста 2
![host2_ssh_service_status](https://github.com/user-attachments/assets/8692b3b1-cf28-40d6-b281-435a023278d1)
### 3. Создание пары ключей для авторизации по ssh (без пароля)
`ssh-keygen -t ed25519`<br>
`ls ~/.ssh/`
![host1_create_key_pair](https://github.com/user-attachments/assets/ac830dd8-7208-4428-9c6c-02ca0e06dfb8)
### 4. Аналогично п.3 делаем с хостом 2
### 5. Создаем пользователя на хосте 2 аналогично хосту 1
`adduser flexey`
### 6. Прокидываем публичный ключик на хост 2 с хост 1
`ssh-copy-id flexey@<host_2>`
### 7. Аналогично п.6 прокидываем ключик на хост 1 с хост 2
`ssh-copy-id flexey@<host_1>`
![host1_ssh_copy_key_to_host2](https://github.com/user-attachments/assets/b90358c9-125e-4999-b98d-eb05bdc24a2f)
### 8. Отключаем авторизацию на обох хостах в конфиге ssh
`sudo vim /etc/ssh/sshd_config`<br>
`Ищем строку PasswordAuthentication --> расскоментируем и ставим значение no`
![host1_disabled_pass_auth](https://github.com/user-attachments/assets/64aa2b3c-c34f-4ce9-8476-cf3d77302c0e)
### 9. Рестартуем сервисы ssh на обох хостах для применения изменений в силу
`sudo systemctl daemon-reload`<br>
`sudo systemctl restart ssh`
### 10. Вуаля! Коннектимся с хоста 1 на хост 2 и обратно
![ssh_from_host1_to_host2](https://github.com/user-attachments/assets/4a75677c-162d-4d18-b087-f6f26b17ddc5)
![host1_ssh_to_host2](https://github.com/user-attachments/assets/5372c481-e138-4a7d-9c11-1a3bff9f3197)
### 11. Закроем доступ по ssh хосту 2
1. Проверим текущие правила<br>
`sudo iptables -L`<br>

2. Закрываем 22 порт<br>
`sudo iptables -A INPUT -p tcp --dport 22 -j DROP`<br>

3. В моем случае сразу отвалилось подключениче через WSL, а значит правило вступило в силу :)
   Убедимся в этом
![closed_22port](https://github.com/user-attachments/assets/0694c839-799e-4339-adf7-919340b4660e)<br>
(действительно, все запросы на 22 порт на хосте 2 были закрыты)<br>

4. Удаляем правило<br>
`sudo iptables -F`<br>
![delete_all_rules_iptables(default)](https://github.com/user-attachments/assets/5876a09d-7a88-42cc-8e63-0344cad5b1e0)<br>
(Правило было удалено и я снова могу подключаться к хосту по ssh)






