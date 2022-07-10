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

INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (65, 'Inventory', 'Base Master', '0', '0', '0', '0', '1,1,1',70) ON CONFLICT(orderno)DO NOTHING;
INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (66, 'Add repository', 'Inventory', '0', '0', 'NA', 'NA', '1,0,0',71) ON CONFLICT(orderno)DO NOTHING;
INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (67, 'Edit repository', 'Inventory', '0', '0', 'NA', 'NA', '1,0,0',71) ON CONFLICT(orderno)DO NOTHING;
INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (68, 'Instrument Category', 'Parser', '0', '0', '0', '0', '1,1,1',72) ON CONFLICT(orderno)DO NOTHING;

update lsusergrouprightsmaster set sedit = '0' where modulename = 'Parser' and displaytopic != 'Parser';
update lsusergrouprights set sedit = '0' where modulename = 'Parser' and displaytopic != 'Parser' and sedit='NA';

update lsusergrouprightsmaster set modulename = 'Templates' where modulename ='Protocol Templates';
update lsusergrouprightsmaster set modulename = 'Templates' where modulename ='Sheet Templates';
update lsusergrouprights set modulename = 'Templates' where modulename ='Protocol Templates';
update lsusergrouprights set modulename = 'Templates' where modulename ='Sheet Templates';

update lsusergrouprights set sallow = '0' where modulename= 'Sheet Settings' and displaytopic = 'LIMS Test  Order';
update lsusergrouprightsmaster set sallow = '0' where modulename= 'Sheet Settings' and displaytopic = 'LIMS Test  Order';

update lsusergrouprightsmaster set displaytopic = 'Sheet Templates' where displaytopic = 'Sheet Creation';
update lsusergrouprights set displaytopic = 'Sheet Templates' where displaytopic = 'Sheet Creation';

ALTER TABLE lsnotification ALTER COLUMN CreatedTimeStamp TYPE timestamp without time zone;

INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (69, 'Templates Shared By Me', 'Templates', '0', 'NA', 'NA', 'NA', '0,0,0',73) ON CONFLICT(orderno)DO NOTHING;
INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder) VALUES (70, 'Templates Shared To Me', 'Templates', '0', 'NA', 'NA', 'NA', '0,0,0',74) ON CONFLICT(orderno)DO NOTHING;

INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder)VALUES (71, 'Sheet', 'Sheet Settings', '0', 'NA', 'NA', 'NA', '0,0,0',75) ON CONFLICT(orderno)DO NOTHING;
INSERT into LSusergrouprightsmaster(orderno, displaytopic, modulename, sallow, screate,sdelete, sedit, status,sequenceorder)VALUES (72, 'Protocol', 'Sheet Settings', '0', 'NA', 'NA', 'NA', '0,0,0',76) ON CONFLICT(orderno)DO NOTHING;

Insert into LSaudittrailconfigmaster values(62,0,'Parser',59,'Delimiter','Save') ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(63,0,'Parser',60,'Delimiter','Edit')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(64,0,'Parser',61,'Delimiter','Delete')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(65,0,'Parser',62,'MethodDelimiter','Save')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(66,0,'Parser',63,'MethodDelimiter','Edit')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(67,0,'Parser',64,'MethodDelimiter','Delete')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(68,0,'Parser',65,'MethodMaster','Save')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(69,0,'Parser',66,'MethodMaster','Edit')ON CONFLICT(serialno)DO NOTHING;
Insert into LSaudittrailconfigmaster values(70,0,'Parser',67,'MethodMaster','Delete')ON CONFLICT(serialno)DO NOTHING;

insert into lsaudittrailconfigmaster values(71,0,'Base Master',68,'Repository','Save')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(72,0,'Base Master',69,'Repository','Edit')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(73,0,'Base Master',70,'Inventory','Save')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(74,0,'Base Master',71,'Inventory','Edit')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(75,0,'Base Master',72,'Inventory','Delete')ON CONFLICT(serialno)DO NOTHING;

insert into lsaudittrailconfigmaster values(76,0,'Register Orders & Execute',8,'Register Orders & Execute','Parse Data')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(77,0,'Protocol Order And Register',73,'Protocol Order And Register','Register Protocol')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(78,0,'Protocol Order And Register',74,'Protocol Order And Register','Process Protocol')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(79,0,'Protocol Order And Register',75,'Protocol Order And Register','Save')ON CONFLICT(serialno)DO NOTHING;
insert into lsaudittrailconfigmaster values(80,0,'Protocol Order And Register',77,'Protocol Order And Register','Complete task')ON CONFLICT(serialno)DO NOTHING;

update LSusergrouprightsmaster set sallow = '0' where displaytopic = 'Add repository' and sallow= 'NA';
update LSusergrouprightsmaster set sallow = '0' where displaytopic = 'Edit repository' and sallow= 'NA';

update LSusergrouprights set sallow = '0' where displaytopic = 'Add repository' and sallow= 'NA';
update LSusergrouprights set sallow = '0' where displaytopic = 'Edit repository' and sallow= 'NA';

update lsusergrouprightsmaster set displaytopic = 'Audit trail configuration' where displaytopic = 'Audit Trail Configuration';
update lsusergrouprightsmaster set displaytopic = 'Audit trail history' where displaytopic = 'Audit Trail History';

update lsusergrouprights set displaytopic = 'Audit trail configuration' where displaytopic = 'Audit Trail Configuration';
update lsusergrouprights set displaytopic = 'Audit trail history' where displaytopic = 'Audit Trail History';

delete from lsusergrouprightsmaster where modulename = 'Register Task Orders & Execute' and displaytopic in ('Assigned Orders','My Orders');
delete from lsusergrouprights where modulename = 'Register Task Orders & Execute' and displaytopic in ('Assigned Orders','My Orders');

ALTER TABLE IF Exists lsprotocolstep ADD COLUMN IF NOT EXISTS   timer jsonb;

ALTER TABLE IF Exists lslogilabprotocolsteps ADD COLUMN IF NOT EXISTS   timer jsonb;


DO
$do$
DECLARE
   _kind "char";
BEGIN
   SELECT relkind
   FROM   pg_class
   WHERE  relname = 'lssheetorderstructure_directorycode_seq' 
   INTO  _kind;

   IF NOT FOUND THEN       
      CREATE SEQUENCE lssheetorderstructure_directorycode_seq;
   ELSIF _kind = 'S' THEN  
      -- do nothing?
   ELSE                    -- object name exists for different kind
      -- do something!
   END IF;
END
$do$;

CREATE TABLE IF NOT EXISTS public.lssheetorderstructure
(
    directorycode bigint NOT NULL DEFAULT nextval('lssheetorderstructure_directorycode_seq'::regclass),
    datecreated timestamp without time zone,
    datemodified timestamp without time zone,
    icon character varying(255) COLLATE pg_catalog."default",
    length integer,
    parentdircode bigint,
    path character varying(255) COLLATE pg_catalog."default",
    size integer,
    CONSTRAINT lssheetorderstructure_pkey PRIMARY KEY (directorycode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.lssheetorderstructure
    OWNER to postgres;

ALTER TABLE IF Exists lslogilablimsorderdetail ADD COLUMN IF NOT EXISTS directorycode bigint;
ALTER TABLE IF Exists lssheetorderstructure ADD COLUMN IF NOT EXISTS directoryname character varying(255);

insert into lssheetorderstructure(datecreated, datemodified, parentdircode, path, size, directoryname ) 
values (NOW(),NOW(),-1,'Sheet/my order', 124, 'my order');

update lslogilablimsorderdetail set directorycode = 1;