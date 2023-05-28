# Инструкция

1) Скачать данные с репозитория:

```bash
git clone 
```

2) Скачать предобученную модель [по ссылке](https://github.com/ShoufaChen/DiffusionDet/releases/download/v0.1/diffdet_coco_res50_300boxes.pth)  разместить файл в корне репозитория

3) Собрать образ:

```bash)
docker build -t image_name .
```

4) Запустить контейнер:

```bash
docker run image_name
```

## Инструкция по извлечению результатов из контейнера:

1) Узнать имя контейнера при помощи команды:

```bash
docker ps -a
```

2) Извлечь файлы:

```bash
docker cp <имя контейнера>:home/images/result.jpg .
docker cp <имя контейнера>:home/tables/result.csv .
```