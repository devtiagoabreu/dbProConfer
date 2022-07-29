CREATE DATABASE dbProConfer CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pessoaNatureza (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL DEFAULT 'Pessoa Jurídica'  COMMENT 'Pessoa Jurídica - Pessoa Física'   ,
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
  contato2 VARCHAR(20)  NULL    ,
PRIMARY KEY(id));



CREATE TABLE pessoaTipo (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL DEFAULT FORNECEDOR  COMMENT 'FORNECEDOR - CLIENTE - TRANSPORTADORA - TERCEIRO'   ,
PRIMARY KEY(id));




CREATE TABLE conferenciaTipo (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  descricao VARCHAR(60)  NOT NULL   COMMENT 'ENTRADA - SA�DA - INVENT�RIO -'   ,
PRIMARY KEY(id));




CREATE TABLE empresaProduto (
  codigo VARCHAR(60)  NOT NULL  ,
  empresa_id INTEGER UNSIGNED  NOT NULL  ,
  codigoOld VARCHAR(60)  NULL  ,
  codigoNew VARCHAR(60)  NULL  ,
  descricao VARCHAR(255)  NULL  ,
  descricaoOld VARCHAR(255)  NULL  ,
  descricaoNew VARCHAR(255)  NULL  ,
  unidadeMedida VARCHAR(10)  NULL  ,
  conferenciaVolume VARCHAR(20)  NULL DEFAULT CAIXA  COMMENT 'CAIXA - FARDO - CONTAINER - GAL�O' ,
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



CREATE TABLE nfe (
  cnpj VARCHAR(50)  NOT NULL  ,
  numero INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  empresa_id INTEGER UNSIGNED  NOT NULL  ,
  chave VARCHAR(60)  NOT NULL  ,
  pessoa_documento VARCHAR(50)  NOT NULL  ,
  serie INTEGER UNSIGNED  NOT NULL  ,
  dataEmissao DATE  NOT NULL  ,
  cfop VARCHAR(10)  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  json TEXT  NULL    ,
PRIMARY KEY(cnpj, numero)  ,
INDEX nfe_FKIndex1(pessoa_documento)  ,
INDEX nfe_FKIndex2(empresa_id),
  FOREIGN KEY(pessoa_documento)
    REFERENCES pessoa(documento)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresa_id)
    REFERENCES empresa(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE pessoaProduto (
  codigo VARCHAR(60)  NOT NULL  ,
  pessoa_documento VARCHAR(50)  NOT NULL  ,
  descricao VARCHAR(255)  NOT NULL  ,
  unidadeMedida VARCHAR(10)  NULL  ,
  conferenciaVolume VARCHAR(20)  NULL DEFAULT CAIXA  COMMENT 'CAIXA - FARDO - CONTAINER - GAL�O' ,
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
  id INTEGER UNSIGNED  NOT NULL  ,
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
  nfe_numero INTEGER UNSIGNED  NOT NULL  ,
  nfe_cnpj VARCHAR(50)  NOT NULL    ,
PRIMARY KEY(lote_id, nfe_numero, nfe_cnpj)  ,
INDEX lote_has_nfe_FKIndex1(lote_id)  ,
INDEX lote_has_nfe_FKIndex2(nfe_cnpj, nfe_numero),
  FOREIGN KEY(lote_id)
    REFERENCES lote(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfe_cnpj, nfe_numero)
    REFERENCES nfe(cnpj, numero)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE nfeLoteRomaneio (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  empresaProduto_codigo VARCHAR(60)  NOT NULL  ,
  nfeLote_nfe_cnpj VARCHAR(50)  NOT NULL  ,
  nfeLote_nfe_numero INTEGER UNSIGNED  NOT NULL  ,
  nfeLote_lote_id INTEGER UNSIGNED  NOT NULL  ,
  numero VARCHAR(20)  NULL  ,
  obs VARCHAR(255)  NULL  ,
  json TEXT  NULL  ,
  dataCadastro TIMESTAMP  NULL DEFAULT now() ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id)  ,
INDEX nfeRomaneio_FKIndex1(nfeLote_lote_id, nfeLote_nfe_numero, nfeLote_nfe_cnpj)  ,
INDEX nfeLoteRomaneio_FKIndex2(empresaProduto_codigo),
  FOREIGN KEY(nfeLote_lote_id, nfeLote_nfe_numero, nfeLote_nfe_cnpj)
    REFERENCES nfeLote(lote_id, nfe_numero, nfe_cnpj)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresaProduto_codigo)
    REFERENCES empresaProduto(codigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



CREATE TABLE conferencia (
  id INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  empresaProduto_codigo VARCHAR(60)  NOT NULL  ,
  nfeLote_nfe_cnpj VARCHAR(50)  NOT NULL  ,
  nfeLote_nfe_numero INTEGER UNSIGNED  NOT NULL  ,
  nfeLote_lote_id INTEGER UNSIGNED  NOT NULL  ,
  conferenciaTipo_id INTEGER UNSIGNED  NOT NULL  ,
  obs VARCHAR(255)  NULL  ,
  dataCadastro TIMESTAMP  NOT NULL DEFAULT now() ,
  json TEXT  NULL  ,
  ativo TINYINT UNSIGNED  NULL DEFAULT 1   ,
PRIMARY KEY(id)  ,
INDEX conferencia_FKIndex1(conferenciaTipo_id)  ,
INDEX conferencia_FKIndex2(nfeLote_lote_id, nfeLote_nfe_numero, nfeLote_nfe_cnpj)  ,
INDEX conferencia_FKIndex3(empresaProduto_codigo),
  FOREIGN KEY(conferenciaTipo_id)
    REFERENCES conferenciaTipo(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(nfeLote_lote_id, nfeLote_nfe_numero, nfeLote_nfe_cnpj)
    REFERENCES nfeLote(lote_id, nfe_numero, nfe_cnpj)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(empresaProduto_codigo)
    REFERENCES empresaProduto(codigo)
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
  metros DECIMAL(18,4)  NULL    ,
PRIMARY KEY(id)  ,
INDEX volume_FKIndex1(conferencia_id),
  FOREIGN KEY(conferencia_id)
    REFERENCES conferencia(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);



