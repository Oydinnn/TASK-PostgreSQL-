-- BEGIN;
--   INSERT INTO users(name, balance) values ("vali", 120000);
--   SAVEPOINT sp1;
--   DELETE FROM users where id = 1
--   ROLLBACK to sp1;
-- END;

BEGIN;
  select * from user WHERE id = 2 for share;
  UPDATE users set name = "fdkjfdkjfd" where 9d = 2;

-- create 
create or replace function create_user()
returns trigger as $$
begin
raise notice 'yangi user qushildi: %', NEW.name;
return NEW;
end;
$$ LANGUAGE plpgsql;

create trigger create_trg
after insert on users
for each row
execute function create_user();



-- update
CREATE OR REPLACE FUNCTION update_user_func()
RETURNS TRIGGER AS $$
BEGIN
RAISE NOTICE 'User tahrirlandi: Eski ism: %, yangi ism: %', OLD.name, NEW.name;
RETURN NEW;
END;
$$LANGUAGE plpgsql;

create Trigger update_user_trg
after update on users
for each row
EXECUTE FUNCTION update_user_func();

-- delete
create or replace function delete_user_func()
returns trigger as $$
BEGIN
raise notice 'user uchirildi: %', OLD.name;
return OLD;
end;
$$LANGUAGE plpgsql;

create trigger delete_user
after delete on users
for each row
EXECUTE function delete_user_func();