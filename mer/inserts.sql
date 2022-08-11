
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

INSERT INTO dbproconfer.pessoa (documento,pessoaTipos_id,pessoaNaturezas_id,razaoSocialNome,fantasia,email1,site,contato1,logradouro,numero,bairro,cidade,uf,cep,sobre,dataAbertura)
	VALUES ('03403794000122',1,1,'FIACAO ITABAIANA LTDA','FIACAO ITABAIANA','contato@fiacaoitabaiana.com.br','http://www.fiacaoitabaiana.com.br/index.htm','7921067500','Avenida Barao do Rio Branco','817','CENTRO','RIBEIROPOLIS','SE','49530-000','A atividade de estamparia e texturização em fios, tecidos, artefatos têxteis e peças do vestuário, envolve a modalidade realizada sob contrato, inclusive os serviços em material próprio com destinação futura para revenda. Texturização refere-se ao serviço de cobrir e decorar algo com uma nova textura com algum relevo (massa ou tinta), enquanto estamparia corresponde à atividade de colocar estampas nos tecidos (como a customização de um uniforme, inclusão de propaganda ou patrocinador em uma camisa, bem como para fins exclusivamente decorativos).','1999-09-17');

INSERT INTO dbproconfer.pessoaproduto (codigo,pessoa_documento,descricao,unidadeMedida,conferenciaVolume,ncm,cst)
	VALUES ('1120','03403794000122','FIO 100% ALGODAO TIT. 20/1 TORCAO TECELAGEM','KG','CAIXA','52051200','000');

