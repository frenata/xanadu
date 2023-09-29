create table if not exists counter (key varchar(10) primary key, value integer);
insert into counter values ('hits', 1) on conflict do nothing;
