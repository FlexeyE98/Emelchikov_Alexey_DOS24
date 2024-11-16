# Синхронизация локального окружения с GCP Storage gcloud. (RSYNC). Разбить диски fdisk + LVM

## Часть 1. Синхронизация локального окружения с GCP Storage gcloud. (RSYNC)

Перед началом работ, необходимо произвести установку gsutil  
`apt install gsutil`  
  
1. Создаем свою папку и файлики  
   `mkdir ALEXEY_EMELCHIKOV`  
   `echo hello > hello.txt`  
2. Производим синхронизацию в object storage  
   `gsutil rsync -r . gs://tms_123121419djscj_test`  
![newfile_after](https://github.com/user-attachments/assets/c33e78b6-4b82-43c8-9495-3a4f8f100d5b)

  Создадим еще один файлик и синхронимся с нашей папкой  
  `touch newfile.txt`  
  `gsutil rsync -r . gs://tms_123121419djscj_test/ALEXEY_EMELCHIKOV/`  
  ![newfile_before](https://github.com/user-attachments/assets/9fe1ca33-7915-414f-8e3a-8af3643f4ba0)

## Часть 2. Разбить диск с использованием fdisk + LVM

Перед началом работ добавим диск на 10GB в vmbox  
![add_hard](https://github.com/user-attachments/assets/dfe266fe-7db3-4a52-b151-f15dc02ececc)  

Произведем установку LVM  
`apt install lvm2 -y`  

Погнали играться :)  

1. Проверим видит ли система наш новый диск  
   `lsblk -l`  
   ![list_disks](https://github.com/user-attachments/assets/27176fd9-37b9-412a-af74-811205f4e0b4)
2. Разобьем диск на 2 диска по ~5GB  
   `fdisk /dev/sdb`  
   `n --> разбить на партиции, указываем первую по счету`  
   `p --> выбираем primary`  
   `сектор оставим на автоматику системы`  
   `Указываем размер диска --> +5G`  
   `w --> обязательно сохраняем изменения`  
   ![sdb1](https://github.com/user-attachments/assets/f84be029-6a49-491c-975c-678572014c28)

   Аналогично делаем и для второго диска  
   ![sdb2](https://github.com/user-attachments/assets/d06da1ca-8954-4fbc-8455-583a72e0df46)

   Итогом мы имеем 2 новых диска: sdb1 и sdb2
   ![lsblk_before_parted](https://github.com/user-attachments/assets/981a172d-0f38-45a5-9063-17920ea8b473)  


4. Добавим данные диски в LVM  
   `pvcreate /dev/sdb1`  
   `pvcreate /dev/sdb2`  

    Проверим результат:
    `pvdisplay`  
   ![pvcreate](https://github.com/user-attachments/assets/dbe3733b-ff25-4391-aa08-eb2cc0607c03)
  
   Физические диски созданы, работаем дальше

5. Создадим нашу volume group и добавим в нее наши диски  
   `vgcreate test_vg /dev/sdb1 /dev/sdb2`
  
   Проверим результат  
   `vgdisplay`   
   ![vg_create](https://github.com/user-attachments/assets/d38cf857-4005-4302-a73e-505eca1204e2)

   Наша vg создана, теперь мы можем создать логические тома и каждому дать нужный размер  
    
6. Создадим логические диски  
   `lvcreate -n logic1 -L 5GB test_vg`  
   `lvcreate -n logic2 -L 4G test_vg`  
   ![lv_create](https://github.com/user-attachments/assets/b7f0ce88-398a-4aab-ac08-d422f1154932)

   Проверим результат  
   ![lv_display](https://github.com/user-attachments/assets/a1f378c7-3ad7-4220-bf39-a78bd410f437)

7. Создадим файловую систему на наших логических томах  
   `mkfs.ext4 /dev/test_vg/logic1`
   `mkfs.ext4 /dev/test_vg/logic2`
   ![mkfs_ext4](https://github.com/user-attachments/assets/7028d61f-6c6f-4755-8298-5a4380c69c32)

8. Логические диски готовы к работе. Примаунтим их!  
   `cd /mnt`  
   `mkdir logic1 && mkdir logic2`  
   `mount /dev/test_vg/logic1 /mnt/logic1`  
   `mount /dev/test_vg/logic2 /mnt/logic2`

   Проверим маунты
   ![lsblk_before_mount](https://github.com/user-attachments/assets/1590c63c-74a4-4d0d-abbc-1f6952c05ad3)  
  
   Все красиво!



   

    

   

   


  


   
   



   
   

   
