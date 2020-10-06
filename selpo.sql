DROP DATABASE IF EXISTS selpo;
CREATE DATABASE selpo;
USE selpo;

DROP TABLE IF EXISTS clients;
CREATE TABLE clients (
	id bigint not null unique primary key, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    phone BIGINT unique,
    INDEX users_phone_idx(phone), 
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers (
  id bigint not null unique,
  name VARCHAR(100),
  office_addr varchar(150),
  phone BIGINT not null unique,
  email VARCHAR(120) UNIQUE
) COMMENT = 'Поставщики';

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id bigint not null unique,
  name VARCHAR(100) COMMENT 'Наименование раздела'
) COMMENT = 'Каталоги';


DROP TABLE IF EXISTS goods;
CREATE TABLE goods (
  id Bigint not null unique PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  catalog_id bigint not null,
  supplier_id bigint not null,
  description_prod TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  foreign key(supplier_id) references suppliers(id),
  foreign key(catalog_id) references catalogs(id)
) COMMENT = 'Товары';

DROP TABLE IF EXISTS full_purchase;
CREATE TABLE full_purchase (
  id bigint not null unique,
  user_id bigint not null,
  sum_purch bigint not null,
  purch_date datetime,
  foreign key(user_id) references clients(id)
) COMMENT = 'Покупка общая';

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases (
  id bigint not null unique,
  good_id Bigint not null,
  order_id bigint not null,
  foreign key(order_id) references full_purchase(id),
  foreign key(good_id) references goods(id)
) COMMENT = 'Покупки по товарам';

