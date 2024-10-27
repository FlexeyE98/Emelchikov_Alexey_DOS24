# Настройка скрипта в crontab && Создание демона для приложения node.js
## Часть 1. Создание скрипта в crontab
1. `crontab -e  --> открытие конфига планировщика для написания скрипта`

2. `sudo apt-get clean --> очищаем кэш apt`

3. `0 16 1 */1 * --> в каждые 16 часов первого числа каждого месяца будет исполняться наш скрипт`<br>

4. `crontab -l --> просмотр текущих задач планировщика`
![image](https://github.com/user-attachments/assets/52ee0a1b-43f5-4dad-978a-28c034dddd32)

## Часть 2. Создание демона для приложения node.js
1. `apt install nodejs -y && nodejs -v --> ставим nodejs и чекаем версию`

2. `apt install npm -y && npm -v --> ставим пакетный менеджер для node.js (доп.пакеты не ставил, но рекомендуют ставить nodejs совместно с npm менеджером)`

3. `MYAPP_PORT=3000 node index.js --> запускаем приложуньку без демона`

4. `curl localhost:3000 && curl -X POST localhost:3000` --> смотрим доступные методы и что отдает приложение<br>
![image](https://github.com/user-attachments/assets/8bbdc032-b454-4c15-8028-bd23a768884b)

5. Создаем демона для запуска приложуньки<br>
   `vim /etc/systemd/system/myapp.service && Ctrl+C Ctrl+V`

6. `systemctl daemon-reload && systemctl enable myapp && systemctl start myapp --> перечитываем конфиги демонов, включаем в автозапуск демона, стартуем демона`<br>
   ![image](https://github.com/user-attachments/assets/c4b09d7f-9b1b-4a55-ba03-12ba50d17ef7)

7. С логгером вышли непонятки, демон видит команды на исполнение и логирует запросы к приложению в journalctl и syslog, но при это по пути указанном в задании --> /var/log/myapp/debug.log ничего нет, даже папки, четко по инструкции делал :(<br>
   В общем, тут логи пишутся в журнал, посчитал это не сильно критичным<br>
![image](https://github.com/user-attachments/assets/17b41f55-3c12-4b0a-bed4-b41451b3bb36)


   
