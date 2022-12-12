```shell
bundle init
rvm ruby-2.7.6 do rvm gemset create auth_microservice
rvm --ruby-version use 2.7.6@auth_microservice
```

Создание БД (postgresql)
```shell
createdb -U qotofey -h localhost auth_microservice_development
createdb -U qotofey -h localhost auth_microservice_test
```

Вывести схему БД в формате Sequel
```shell
sequel -D postgresql://qotofey@localhost/ads_development
```

Запустить мирграцию БД с Sequel
```shell

```