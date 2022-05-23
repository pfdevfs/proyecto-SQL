--el script ha sido modificado desde la entrega de la actividad voluntaria de la unidad 5. fecha de modificacion: 16/05/2022--

create table induccion (
	induc_cod	VARCHAR2(10),
	atmosferico	varchar2(20),
	turbo		varchar2(20),
	biturbo		varchar2(20),
	supercarg	varchar2(10),
	otros_forz	varchar2(25)
);

create table motor (
	motor_cod	varchar2(10),
	en_serie	number(1),
	en_v		number(2),
	rotativo	number(1),
	inyeccion_cod	varchar2(10),
	expulsion_cod	number(2),
	impulsa_peso	number(4)
);

create table chasis (
	chas_cod	varchar2(10),
	peso	number(4),
	material	varchar2(10),
	resis	decimal(2,3),
	cx		number(3),
	reposa_sobre varchar2(11)
);

create table neumatico (
	neum_cod	number(3),
	rodadura	varchar2(10),
	tipo		varchar2(10),
	dureza		VARCHAR2(11),
	marca		VARCHAR2(15)
);

create table escapes (
	exhaust_cod	number(2),
	colec_escape	varchar2(15),
	catalizador	varchar2(15),
	num_tubos	number(1)
);

create table centralita (
	ecu_cod	number(5),
	poten_homolog	number(3),
	tipo_ecu	varchar2(20),
	limite_pot	number(3),
	motor_cod	varchar2(10)
);

--establecimiento de claves primarias
alter table induccion add constraint induc_pk primary key (induc_cod);
alter table motor add constraint motor_pk primary key (motor_cod);
alter table chasis add constraint chas_pk primary key (chas_cod);
alter table neumatico add constraint neum_pk primary key (neum_cod);
alter table escapes add constraint exhaust_pk primary key (exhaust_cod);
alter table centralita add constraint centralita_pk primary key (ecu_cod);

--establecimiento de claves foráneas y a qué referencian
alter table motor add constraint motor_fk foreign key (inyeccion_cod) references induccion;
alter table motor add constraint motor_fk_esc foreign key (expulsion_cod) references escapes;
alter table motor add constraint motor_fk_chas foreign key (impulsa_peso) references chasis;
alter table chasis add constraint chasis_fk foreign key (reposa_sobre) references neumatico;
alter table centralita add constraint centralita_fk foreign key (motor_cod) references motor;

--establecimiento de columnas únicas
alter table motor add constraint rot_uniq unique(rotativo);
alter table induccion add constraint btrb_uniq unique(biturbo);
alter table chasis add constraint repsob_uniq unique(reposa_sobre);

--revisado de condiciones
alter table motor add constraint cilindros_ck check(en_serie between 3 and 6);
alter table neumatico add constraint marca_ck check(marca like 'michelin' or marca like 'continental' or marca like 'dunlop');

--modificaciones en las tablas
alter table motor modify cilindros not null;
alter table escapes modify num_tubos not null;
alter table escapes modify catalizador boolean;

--insertar datos en la tabla induccion--
insert into induccion values ('235ssl', 'atmos', '1jz', 'nodist', 'nodist', 'ext'); 
insert into induccion values ('936ssl', 'atmos', '2jz', 'distro', 'nodist', 'inet'); 
insert into induccion values ('312ssl', 'central', '1jz', 'walper', 'distap', 'full'); 
insert into induccion values ('834ssl', 'dobles', '1jz', 'nodist+', 'nodist', 'ext');
insert into induccion values ('204ssl', 'atmos', 'tbali', 'egnia', 'distap', 'ext');
insert into induccion values ('101ssl', 'central', 'hellcat', 'egnia+', 'distap', 'ext');

--insertar datos en la tabla motor--
insert into motor values ('jpk900', 3, 8, 3, 'turboali', '235ssl', 83, 1090);
insert into motor values ('jpk100', 4, 12, 4, 'charger', '936ssl', 77, 2090);
insert into motor values ('jpk400', 4, 12, 6, 'turboali', '312ssl', 74, 1490);
insert into motor values ('jpk200', 6, 16, 2, 'atmosfer', '204ssl', 91, 1890);
insert into motor values ('jpk500', 3, 6, 1, 'atmosfer', '101ssl', 41, 1390);
insert into motor values ('jpk700', 3, 10, 8, 'turboali', '834ssl', 32, 1200);

--insertar datos en la tabla chasis--

insert into chasis values ('dek200', 1120, 'fibra-c', 2.3, 153, 'alumin');
insert into chasis values ('dek400', 1500, 'fibra-d', 25.3, 113, 'metal');
insert into chasis values ('dek500', 1280, 'fibra-a', 11.3, 153, 'carbon');
insert into chasis values ('dek100', 1340, 'fibra-a', 45.3, 118, 'aleacion');
insert into chasis values ('dek300', 1120, 'fibra-e', 23.3, 97, 'grafeno');
insert into chasis values ('dek600', 1222, 'fibra-g', 2.3, 111, 'nicegreen');

--insertar datos en la tabla neumatico--
insert into neumatico values (223, 'lisa', 'cau', 'soft', 'michelin');
insert into neumatico values (435, 'rugosa', 'gom', 'hard', 'continental');
insert into neumatico values (123, 'traza', 'pol', 'medi', 'dunlop');
insert into neumatico values (994, 'lisa', 'pol', 'soft', 'dunlop');
insert into neumatico values (251, 'patron', 'gom', 'x-soft', 'continental');

--insertar datos en la tabla escapes--
insert into escapes values (30, 'dobles', 'maximo', 3);
insert into escapes values (20, 'mixtos', 'minimo', 2);
insert into escapes values (10, 'lateral', 'maximo', 2);
insert into escapes values (40, 'lateral', 'balance', 3);
insert into escapes values (60, 'dobles', 'reduc', 1);
insert into escapes values (50, 'mixtos', 'maximo', 3);

--insertar datos en la tabla centralita--
insert into escapes values (89234, 349, 'stage1', 389, 'jpk900');
insert into escapes values (89235, 350, 'stage1', 400, 'jpk100');
insert into escapes values (23489, 760, 'stage5', 750, 'jpk400');
insert into escapes values (23490, 550, 'stage3', 560, 'jpk200');
insert into escapes values (85473, 410, 'stage2', 415, 'jpk500');
insert into escapes values (29523, 640, 'stage4', 640, 'jpk700');

--borrado de las tablas
drop table induccion cascade constraint;
drop table motor cascade constraint;
drop table chasis cascade constraint;
drop table neumatico cascade constraint;
drop table escapes cascade constraint;
drop table centralita cascade constraint;

--momento de las funciones y procedimientos--
create or replace procedure mostrarNeumaticoP(v_codigoneu neumatico.neum_cod%type)
as 
cursor neu_pire is 
select marca
from neumatico
where marca like 'continental';
begin

	for registro in cursor neu_pire loop
		dbms_output.put_line('El neumatico es ' || registro.marca);
	end loop;

end;
/
----------------------
create or replace procedure mostrarStage1(v_codigocen centralita.ecu_cod%type)
as 
cursor centra_stg1 is
select tipo_ecu 
from centralita
where tipo_ecu like 'stage1';
begin

	for registro1 in cursor centra_stg1 is 
		dbms_output.put_line('el nivel de custom es ' || registro1.tipo_ecu);
	end loop:
end;
/
----------------------
create or replace function coche_potencia(pot number)
return VARCHAR2
is
	potencia varchar2(20);
begin
	potencia:='';
	if pot<=500 then
	potencia:='muy fuerte';
	else potencia:='menos fuerte';
	end if;
	return potencia;
end;
/
----------------------
create or replace function coche_cilindros(cyl number)
return varchar2
is
	cilindros VARCHAR2(20);
begin
	cilindros:='';
	if cyl<=4 then
	cilindros:='vehiculo estándar';
	else cilindros:='vehiculo deportivo';
	enf if;
	return cilindros;
end;
/


-- bloque anónimo principal --

declare 
	v_codigoneu neumatico.neum_cod%type := &codigo;
	v_codigocen centralita.ecu_cod%type := &codigo1;
	coche_potencia pot number;
	coche_cilindros cyl number;
begin
	mostrarNeumaticoP(v_codigoneu);
	mostrarStage1(v_codigocen);
	select limite_pot, coche_potencia(limite_pot) from centralita;
	select en_serie, coche_cilindros(en_serie) from motor;
end;
/