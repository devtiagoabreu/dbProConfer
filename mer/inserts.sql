
INSERT INTO dbproconfer.permissoes (descricao)
	VALUES ('administrator');

INSERT INTO dbproconfer.permissoes (descricao)
	VALUES ('conferente');

INSERT INTO dbproconfer.apps (descricao,codigo)
	VALUES ('conferencia','c_001');

INSERT INTO dbproconfer.apps (descricao,codigo)
	VALUES ('nfe','n_001');

INSERT INTO dbproconfer.permissoesapps (permissoes_id,apps_id)
	VALUES (1,1);

INSERT INTO dbproconfer.permissoesapps (permissoes_id,apps_id)
	VALUES (1,2);

INSERT INTO dbproconfer.permissoesapps (permissoes_id,apps_id)
	VALUES (2,1);

INSERT INTO dbproconfer.conferenciatipo (descricao)
	VALUES ('ENTRADA');

INSERT INTO dbproconfer.conferenciatipo (descricao)
	VALUES ('SAÍDA');

INSERT INTO dbproconfer.conferenciatipo (descricao)
	VALUES ('INVENTÁRIO');

INSERT INTO dbproconfer.pessoanatureza (descricao)
	VALUES ('PESSOA JURÍDICA');

INSERT INTO dbproconfer.pessoanatureza (descricao)
	VALUES ('PESSOA FÍSICA');

INSERT INTO dbproconfer.pessoatipo (descricao)
	VALUES ('FORNECEDOR');

INSERT INTO dbproconfer.pessoatipo (descricao)
	VALUES ('CLIENTE');

INSERT INTO dbproconfer.pessoatipo (descricao)
	VALUES ('TRANSPORTADORA');

INSERT INTO dbproconfer.usuario (permissoes_id,nome,login,senha,token,email)
	VALUES (1,'ADMINISTRADOR DO SISTEMA','adm','852456','852456','adm@email.com');

INSERT INTO dbproconfer.empresa (documento,razaoSocialNome,fantasia,email1,site,contato1)
	VALUES ('07695188000189','PRO MODA TEXTIL LTDA','PRO MODA TEXTIL','contato@promodatextil.com.br','promodatextil.com.br','1934553686','1934553888');

INSERT INTO dbproconfer.empresa (documento,razaoSocialNome,fantasia,email1,site,contato1)
	VALUES ('44634131000104','P M TEXTIL LTDA','P M TEXTIL','monica@promodatextil.com.br','pmtextil.com.br','1981815930');
