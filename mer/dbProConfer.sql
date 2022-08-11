CREATE DATABASE dbProConfer CHARACTER SET utf8 COLLATE utf8_general_ci;



CREATE TABLE pessoaTipo (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL DEFAULT 'FORNECEDOR'  COMMENT 'FORNECEDOR - CLIENTE - TRANSPORTADORA - TERCEIRO'   ,
PRIMARY KEY(id));




CREATE TABLE empresa (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  documento VARCHAR(50)  NOT NULL  ,
  razaoSocialNome VARCHAR(255)  NOT NULL  ,
  fantasia VARCHAR(255)  NULL  ,
  email1 VARCHAR(255)  NULL  ,
  email2 VARCHAR(255)  NULL  ,
  site VARCHAR(255)  NULL  ,
  contato1 VARCHAR(20)  NULL  ,
  contato2 VARCHAR(20)  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1 ,
  dataCadastro TIMESTAMP  NULL DEFAULT now()   ,
PRIMARY KEY(id));



CREATE TABLE pessoaNatureza (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL DEFAULT 'PESSOA JURÍDICA'  COMMENT 'PESSOA JURÍDICA - PESSOA FÍSICA'   ,
PRIMARY KEY(id));




CREATE TABLE apps (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(255)  NOT NULL  ,
  codigo VARCHAR(20)  NOT NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id));



CREATE TABLE permissoes (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id));



CREATE TABLE conferenciaTipo (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL   COMMENT 'ENTRADA - SAÍDA - INVENTÁRIO -'   ,
PRIMARY KEY(id));




CREATE TABLE usuario (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  permissoes_id INTEGER UNSIGNED  NOT NULL  ,
  nome VARCHAR(255)  NOT NULL  ,
  login VARCHAR(255)  NOT NULL  ,
  senha VARCHAR(255)  NOT NULL  ,
  token VARCHAR(255)  NOT NULL  ,
  email VARCHAR(255)  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1 ,
  dataCadastro TIMESTAMP  NULL DEFAULT now()   ,
PRIMARY KEY(id)  ,
INDEX usuario_FKIndex1(permissoes_id),
  FOREIGN KEY(permissoes_id)
    REFERENCES permissoes(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE empresaProduto (
  codigo VARCHAR(60)  NOT NULL  ,
  empresa_id INTEGER UNSIGNED  NOT NULL  ,
  codigoOld VARCHAR(60)  NULL  ,
  codigoNew VARCHAR(60)  NULL  ,
  descricao VARCHAR(255)  NULL  ,
  descricaoOld VARCHAR(255)  NULL  ,
  descricaoNew VARCHAR(255)  NULL  ,
  unidadeMedida VARCHAR(10)  NULL  ,
  conferenciaVolume VARCHAR(20)  NULL DEFAULT 'CAIXA'  COMMENT 'CAIXA - FARDO - CONTAINER - GALÃO' ,
  ncm VARCHAR(30)  NULL  ,
  cst VARCHAR(10)  NULL  ,
  json TEXT  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1 ,
  dataCadastro TIMESTAMP  NULL DEFAULT now()   ,
PRIMARY KEY(codigo)  ,
INDEX empresaProduto_FKIndex1(empresa_id),
  FOREIGN KEY(empresa_id)
    REFERENCES empresa(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);




CREATE TABLE pessoa (
  documento VARCHAR(50)  NOT NULL  ,
  pessoaTipos_id INTEGER UNSIGNED  NOT NULL  ,
  pessoaNaturezas_id INTEGER UNSIGNED  NOT NULL  ,
  razaoSocialNome VARCHAR(255)  NOT NULL  ,
  fantasia VARCHAR(255)  NULL  ,
  email1 VARCHAR(255)  NULL  ,
  email2 VARCHAR(255)  NULL  ,
  site VARCHAR(255)  NULL  ,
  contato1 VARCHAR(20)  NULL  ,
  contato2 VARCHAR(20)  NULL  ,
  contato3 VARCHAR(20)  NULL  ,
  logradouro VARCHAR(255)  NULL  ,
  numero VARCHAR(10)  NULL  ,
  bairro VARCHAR(255)  NULL  ,
  complemento VARCHAR(255)  NULL  ,
  cidade VARCHAR(255)  NULL  ,
  uf VARCHAR(10)  NULL  ,
  cep VARCHAR(20)  NULL  ,
  sobre TEXT  NULL  ,
  dataAbertura DATE  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1 ,
  obs VARCHAR(255)  NULL    ,
PRIMARY KEY(documento)  ,
INDEX pessoaJuridica_FKIndex1(pessoaTipos_id)  ,
INDEX pessoa_FKIndex2(pessoaNaturezas_id),
  FOREIGN KEY(pessoaTipos_id)
    REFERENCES pessoaTipo(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(pessoaNaturezas_id)
    REFERENCES pessoaNatureza(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE permissoesApps (
  permissoes_id INTEGER UNSIGNED  NOT NULL  ,
  apps_id INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(permissoes_id, apps_id)  ,
INDEX permissoes_has_apps_FKIndex1(permissoes_id)  ,
INDEX permissoes_has_apps_FKIndex2(apps_id),
  FOREIGN KEY(permissoes_id)
    REFERENCES permissoes(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(apps_id)
    REFERENCES apps(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE nfe (
  chave VARCHAR(60)  NOT NULL  ,
  cnpj VARCHAR(50)  NOT NULL  ,
  serie VARCHAR(20)  NOT NULL  ,
  numero VARCHAR(50)  NOT NULL  ,
  pessoa_documento VARCHAR(50)  NOT NULL  ,
  usuario_id INTEGER UNSIGNED  NOT NULL  ,
  empresa_id INTEGER UNSIGNED  NOT NULL  ,
  dataEmissao DATE  NOT NULL  ,
  cfop VARCHAR(10)  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  json TEXT  NULL    ,
PRIMARY KEY(chave)  ,
INDEX nfe_FKIndex1(pessoa_documento)  ,
INDEX nfe_FKIndex2(empresa_id)  ,
INDEX nfe_FKIndex3(usuario_id),
  FOREIGN KEY(pessoa_documento)
    REFERENCES pessoa(documento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresa_id)
    REFERENCES empresa(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE pessoaProduto (
  codigo VARCHAR(60)  NOT NULL  ,
  pessoa_documento VARCHAR(50)  NOT NULL  ,
  descricao VARCHAR(255)  NOT NULL  ,
  unidadeMedida VARCHAR(10)  NULL  ,
  conferenciaVolume VARCHAR(20)  NULL DEFAULT 'CAIXA'  COMMENT 'CAIXA - FARDO - CONTAINER - GALÃO' ,
  ncm VARCHAR(30)  NULL  ,
  cst VARCHAR(10)  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(codigo)  ,
INDEX fornecedoresProdutos_FKIndex1(pessoa_documento),
  FOREIGN KEY(pessoa_documento)
    REFERENCES pessoa(documento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);




CREATE TABLE lote (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  pessoaProduto_codigo VARCHAR(60)  NOT NULL  ,
  lote VARCHAR(60)  NOT NULL  ,
  obs VARCHAR(255)  NULL  ,
  pesoLiquido DECIMAL(18,4)  NOT NULL  ,
  pesoBruto DECIMAL(18,4)  NULL  ,
  ncm VARCHAR(30)  NULL  ,
  cst VARCHAR(10)  NULL  ,
  cfop VARCHAR(10)  NULL  ,
  unidadeMedida VARCHAR(10)  NOT NULL DEFAULT KG  COMMENT 'KG - M - L' ,
  quantidadeVolumes DECIMAL(18,4)  NOT NULL  ,
  valorUnitario DECIMAL(18,4)  NULL  ,
  valorTotal DECIMAL(18,4)  NULL  ,
  baseCalculoICMS DECIMAL(18,4)  NULL  ,
  valorICMS DECIMAL(18,4)  NULL  ,
  aliquotaICMS DECIMAL(18,4)  NULL    ,
PRIMARY KEY(id)  ,
INDEX lote_FKIndex1(pessoaProduto_codigo),
  FOREIGN KEY(pessoaProduto_codigo)
    REFERENCES pessoaProduto(codigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);




CREATE TABLE nfeLote (
  lote_id INTEGER UNSIGNED  NOT NULL  ,
  nfe_chave VARCHAR(60)  NOT NULL    ,
PRIMARY KEY(lote_id, nfe_chave)  ,
INDEX lote_has_nfe_FKIndex1(lote_id)  ,
INDEX lote_has_nfe_FKIndex2(nfe_chave),
  FOREIGN KEY(lote_id)
    REFERENCES lote(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfe_chave)
    REFERENCES nfe(chave)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);




CREATE TABLE nfeLoteRomaneio (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  nfeLote_nfe_chave VARCHAR(60)  NOT NULL  ,
  nfeLote_lote_id INTEGER UNSIGNED  NOT NULL  ,
  usuario_id INTEGER UNSIGNED  NOT NULL  ,
  empresaProduto_codigo VARCHAR(60)  NOT NULL  ,
  numero VARCHAR(20)  NULL  ,
  obs VARCHAR(255)  NULL  ,
  json TEXT  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id)  ,
INDEX nfeLoteRomaneio_FKIndex2(empresaProduto_codigo)  ,
INDEX nfeLoteRomaneio_FKIndex3(usuario_id)  ,
INDEX nfeLoteRomaneio_FKIndex4(nfeLote_lote_id, nfeLote_nfe_chave),
  FOREIGN KEY(empresaProduto_codigo)
    REFERENCES empresaProduto(codigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfeLote_lote_id, nfeLote_nfe_chave)
    REFERENCES nfeLote(lote_id, nfe_chave)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE conferencia (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  nfeLote_nfe_chave VARCHAR(60)  NOT NULL  ,
  usuario_id INTEGER UNSIGNED  NOT NULL  ,
  nfeLoteRomaneio_id INTEGER UNSIGNED  NULL  ,
  empresaProduto_codigo VARCHAR(60)  NOT NULL  ,
  nfeLote_lote_id INTEGER UNSIGNED  NOT NULL  ,
  conferenciaTipo_id INTEGER UNSIGNED  NOT NULL  ,
  obs VARCHAR(255)  NULL  ,
  dataCadastro TIMESTAMP  NOT NULL DEFAULT now() ,
  json TEXT  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id)  ,
INDEX conferencia_FKIndex1(conferenciaTipo_id)  ,
INDEX conferencia_FKIndex2(nfeLote_lote_id, nfeLote_nfe_chave)  ,
INDEX conferencia_FKIndex3(empresaProduto_codigo)  ,
INDEX conferencia_FKIndex4(nfeLoteRomaneio_id)  ,
INDEX conferencia_FKIndex5(usuario_id),
  FOREIGN KEY(conferenciaTipo_id)
    REFERENCES conferenciaTipo(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfeLote_lote_id, nfeLote_nfe_chave)
    REFERENCES nfeLote(lote_id, nfe_chave)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresaProduto_codigo)
    REFERENCES empresaProduto(codigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfeLoteRomaneio_id)
    REFERENCES nfeLoteRomaneio(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(usuario_id)
    REFERENCES usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE nfeLoteRomaneioVolume (
  codigoVolume VARCHAR(50)  NOT NULL  ,
  nfeLoteRomaneio_id INTEGER UNSIGNED  NOT NULL  ,
  codigoVolumeB VARCHAR(50)  NULL  ,
  pesoBruto DECIMAL(18,4)  NULL DEFAULT 0 ,
  pesoLiquido DECIMAL(18,4)  NULL DEFAULT 0 ,
  tara DECIMAL(18,4)  NULL DEFAULT 0 ,
  metros DECIMAL(18,4)  NULL DEFAULT 0 ,
  quantidade DECIMAL(18,4)  NULL DEFAULT 0 ,
  lote VARCHAR(60)  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now()   ,
PRIMARY KEY(codigoVolume)  ,
INDEX nfeRomaneioVolume_FKIndex1(nfeLoteRomaneio_id),
  FOREIGN KEY(nfeLoteRomaneio_id)
    REFERENCES nfeLoteRomaneio(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE conferenciaVolume (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  conferencia_id INTEGER UNSIGNED  NOT NULL  ,
  empresaCodigoVolume VARCHAR(50)  NULL  ,
  fornecedorCodigoVolume VARCHAR(50)  NULL  ,
  pesoBruto DECIMAL(18,4)  NULL  ,
  pesoLiquido DECIMAL(18,4)  NULL  ,
  tara DECIMAL(18,4)  NULL  ,
  metros DECIMAL(18,4)  NULL  ,
  quantidade DECIMAL(18,4)  NULL   COMMENT 'DEVE SER USADO COM UNIDADE DE MEDIDA ESPECÍFICA' ,
  dataCadastro TIMESTAMP  NULL DEFAULT now()   ,
PRIMARY KEY(id)  ,
INDEX volume_FKIndex1(conferencia_id),
  FOREIGN KEY(conferencia_id)
    REFERENCES conferencia(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);
