create or replace function emp_stamp() returns trigger
as $$
	BEGIN
		if new.empname is null then
			raise exception 'empname cannot be null';
		end if;
	
		if new.salary is null then
			raise exception '% cannot have null salary', new.empname;
		end if;
	
		if new.salary <= 0 then
			raise exception '% cannot have a negative or null salary', new.empname;
		end if;
	
		new.last_date := current_timestamp;
		new.last_user := current_user;
		return new;
	END;
$$ language plpgsql;

create trigger emp_stamp before insert or update on emp
for each row execute function emp_stamp();

insert into emp(empname, salary) values(null, null);
insert into emp(empname, salary) values('Fulano', null);
insert into emp(empname, salary) values('Fulano', 0);
insert into emp(empname, salary) values('Fulano', 11000);

select * from emp;