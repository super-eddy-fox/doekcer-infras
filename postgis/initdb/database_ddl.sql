--  DROP DATABASE if exists mydb;
--  CREATE DATABASE mydb

-- CHARACTER SET utf8mb4
-- COLLATE utf8mb4_unicode_ci;
--
-- SET NAMES 'utf8mb4';

-- USE mydb;

create table role
(
    id serial primary key,
    name varchar(50) not null
);

create table users
(
    id serial primary key,
    enabled bit not null,
    password varchar(100) not null,
    user_name varchar(50) not null,
    constraint unique_user_userName unique (user_name)
);

create table board
(
    id serial  primary key,
    content varchar(255) null,
    title varchar(30) not null,
    user_id bigint ,
    constraint fk_board_user_id foreign key (user_id) references users (id)  ON DELETE CASCADE
);

create table user_role
(
    user_id bigint not null,
    role_id bigint not null,
    constraint fk_userRole_user_id foreign key (user_id) references users (id),
    constraint fk_userRole_role_id foreign key (role_id) references role (id)
);


insert into role(name) values ('ROLE_USER')