insert into funcionarios (id, nome_funcionario, data_entrada)  values (nextval('funcionarios_seq'), 'Pelé', '1950-12-31');
insert into funcionarios (id, nome_funcionario, data_entrada)  values (nextval('funcionarios_seq'), 'Maradona', '1990-01-20');
insert into funcionarios (id, nome_funcionario, data_entrada)  values (nextval('funcionarios_seq'), 'Senna', '1960-07-20');

insert into departamentos(id, nome) values(nextval('departamentos_seq'), 'RH');
insert into departamentos(id, nome) values(nextval('departamentos_seq'), 'Tecnologia da Informação');
insert into departamentos(id, nome) values(nextval('departamentos_seq'), 'Financeiro');

insert into cargos(id, nome, id_departamento_fk) values(nextval('cargos_seq'), 'Analista I', 1);
insert into cargos(id, nome, id_departamento_fk) values(nextval('cargos_seq'), 'Analista II', 1);
insert into cargos(id, nome, id_departamento_fk) values(nextval('cargos_seq'), 'Gerente', 51);
insert into cargos(id, nome, id_departamento_fk) values(nextval('cargos_seq'), 'Médico', 51);
insert into cargos(id, nome, id_departamento_fk) values(nextval('cargos_seq'), 'Assistente', 101);




