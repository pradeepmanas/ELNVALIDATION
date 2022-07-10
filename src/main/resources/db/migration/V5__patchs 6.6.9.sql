update lsfile set filenameuser = 'Default Template' where filecode = 1;

update lsusergrouprights set sallow='1',screate='1',sdelete='1',sedit='1' where modulename='Protocol Templates' and displaytopic ='Protocol Templates';

update lsusergrouprights set sallow='1',screate='1' where modulename='Protocol Templates' and displaytopic ='New Step' and screate='NA';

update lsusergrouprightsmaster set sallow='0',screate='0',sdelete='0',sedit='0' where modulename = 'Protocol Templates' and displaytopic ='Protocol Templates';

ALTER TABLE IF Exists LSpreferences ADD COLUMN IF NOT EXISTS valueencrypted varchar(250);
delete from LSpreferences where tasksettings ='WebParser';
insert into LSpreferences (serialno,tasksettings,valuesettings) values(1,'WebParser','InActive');
delete from LSpreferences where tasksettings ='ConCurrentUser';
insert into LSpreferences (serialno,tasksettings,valuesettings) values(2,'ConCurrentUser','InActive');
delete from LSpreferences where tasksettings ='MainFormUser';
insert into LSpreferences (serialno,tasksettings,valuesettings) values(3,'MainFormUser','InActive');

ALTER TABLE IF Exists lslogilabprotocoldetail ADD COLUMN IF NOT EXISTS lsrepositoriesdata_repositorydatacode integer;

DO
$do$
declare
  multiusergroupcount integer :=0;
begin

SELECT count(*) into multiusergroupcount FROM
information_schema.table_constraints WHERE constraint_name='fkgpc2701111y358e3flbb287pf'
AND table_name='lslogilabprotocoldetail';
 IF multiusergroupcount =0 THEN
 	ALTER TABLE ONLY lslogilabprotocoldetail ADD CONSTRAINT fkgpc2701111y358e3flbb287pf FOREIGN KEY (lsrepositoriesdata_repositorydatacode) REFERENCES lsrepositoriesdata(repositorydatacode);
   END IF;
END
$do$;  

ALTER TABLE IF Exists lslogilabprotocoldetail ADD COLUMN IF NOT EXISTS lsrepositories_repositorycode integer;

DO
$do$
declare
  multiusergroupcount integer :=0;
begin

SELECT count(*) into multiusergroupcount FROM
information_schema.table_constraints WHERE constraint_name='fkcisd747ka6hp4c2makfdui7xs'
AND table_name='lslogilabprotocoldetail';
 IF multiusergroupcount =0 THEN
 	ALTER TABLE ONLY lslogilabprotocoldetail ADD CONSTRAINT fkcisd747ka6hp4c2makfdui7xs FOREIGN KEY (lsrepositories_repositorycode) REFERENCES lsrepositories(repositorycode);
   END IF;
END
$do$;

ALTER TABLE IF Exists lslogilablimsorderdetail ADD COLUMN IF NOT EXISTS lockedusername varchar(50);

ALTER TABLE IF Exists LSreviewdetails ADD COLUMN IF NOT EXISTS auditserialno integer;
ALTER TABLE IF Exists LSreviewdetails ADD COLUMN IF NOT EXISTS modulename varchar(250);
ALTER TABLE IF Exists LSreviewdetails ADD COLUMN IF NOT EXISTS reviewvercomments varchar(250);
ALTER TABLE IF Exists LSreviewdetails ADD COLUMN IF NOT EXISTS auditusername varchar(250);
ALTER TABLE IF Exists LSreviewdetails ADD COLUMN IF NOT EXISTS action varchar(250);

