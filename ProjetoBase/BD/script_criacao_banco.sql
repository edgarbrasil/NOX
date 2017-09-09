/*
Script de criação da base.
Autor: Edgar Brasil Sovinski
Data: 01/09/2017
*/

use master
go

if not exists(select * from sys.databases where name = 'VENDAS')	
    create database VENDAS
go


if not exists(select * from sys.databases where name = 'VENDAS')	
    return

use VENDAS
go
/*
CLIENTE
*/
if (object_id('cliente') is null)
begin
	CREATE TABLE cliente (
		SEQ_cliente INT NOT NULL,
		DS_nome VARCHAR(100) NOT NULL
	CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
	(
	[SEQ_cliente] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)
end
go

IF OBJECT_ID('cliente_GEN', 'SO') IS NULL 	
begin
	CREATE SEQUENCE [dbo].[cliente_GEN] 
		AS [bigint]
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
end
go

if (object_id('cliente') is not null) and 
   (OBJECT_ID('cliente_GEN', 'SO') IS not NULL) and
   (OBJECT_ID('DEF_SEQ_cliente', 'D') is null)
begin
	ALTER TABLE cliente
		ADD CONSTRAINT DEF_SEQ_cliente DEFAULT (NEXT VALUE FOR cliente_GEN) FOR SEQ_cliente
end	
/*
CLIENTE
*/


/*
mercadoria_grupo
*/
if (object_id('mercadoria_grupo') is null)
begin
	CREATE TABLE mercadoria_grupo (
		SEQ_mercadoria_grupo INT NOT NULL,
		DS_nome VARCHAR(255) NOT NULL,
		fg_Cobra_Taxa_servico char(1)  
	CONSTRAINT [PK_mercadoria_grupo] PRIMARY KEY CLUSTERED 
	(
	[SEQ_mercadoria_grupo] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)
end
go

IF OBJECT_ID('mercadoria_grupo_GEN', 'SO') IS NULL 	
begin
	CREATE SEQUENCE [dbo].[mercadoria_grupo_GEN] 
		AS [bigint]
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
end
go

if (object_id('mercadoria_grupo') is not null) and 
   (OBJECT_ID('mercadoria_grupo_GEN', 'SO') IS not NULL) and
   (OBJECT_ID('DEF_SEQ_mercadoria_grupo', 'D') is null)
begin
	ALTER TABLE mercadoria_grupo
		ADD CONSTRAINT DEF_SEQ_mercadoria_grupo DEFAULT (NEXT VALUE FOR mercadoria_grupo_GEN) FOR SEQ_mercadoria_grupo
end	
/*
mercadoria_grupo
*/

/*
mercadoria
*/
if (object_id('mercadoria') is null)
begin
	CREATE TABLE mercadoria (
		SEQ_mercadoria INT NOT NULL,
		DS_nome VARCHAR(255) NOT NULL,
		VR_PRECO float ,
		qt_Estoque INT NOT NULL, 
		id_mercadoria_grupo INT NOT NULL, 
		fg_Cobra_Taxa_servico char(1) null
	CONSTRAINT [PK_mercadoria] PRIMARY KEY CLUSTERED 
	(
	[SEQ_mercadoria] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)
end
go

IF OBJECT_ID('mercadoria_grupo_GEN', 'SO') IS NULL 	
begin
	CREATE SEQUENCE [dbo].[mercadoria_grupo_GEN] 
		AS [bigint]
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
end
go

if (object_id('mercadoria') is not null) and 
   (OBJECT_ID('mercadoria_GEN', 'SO') IS not NULL) and
   (OBJECT_ID('DEF_SEQ_mercadoria', 'D') is null)
begin
	ALTER TABLE mercadoria
		ADD CONSTRAINT DEF_SEQ_mercadoria DEFAULT (NEXT VALUE FOR mercadoria_GEN) FOR SEQ_mercadoria
end	
/*
mercadoria
*/

/*
venda
*/
if (object_id('venda') is null)
begin
	CREATE TABLE venda (
		SEQ_venda INT NOT NULL,
		dt_venda datetime,
		id_cliente int not null,
		vr_desconto float,
		pc_taxa_servico float,
		vr_total float
	CONSTRAINT [PK_venda] PRIMARY KEY CLUSTERED 
	(
	[SEQ_venda] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)
end
go

IF OBJECT_ID('venda_GEN', 'SO') IS NULL 	
begin
	CREATE SEQUENCE [dbo].[venda_GEN] 
		AS [bigint]
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
end
go

if (object_id('venda') is not null) and 
   (OBJECT_ID('venda_GEN', 'SO') IS not NULL) and
   (OBJECT_ID('DEF_SEQ_venda', 'D') is null)
begin
	ALTER TABLE venda
		ADD CONSTRAINT DEF_SEQ_venda DEFAULT (NEXT VALUE FOR venda_GEN) FOR SEQ_venda
end	
/*
venda
*/

/*
venda_item
*/
if (object_id('venda_item') is null)
begin
	CREATE TABLE venda_item (
		SEQ_venda_item INT NOT NULL,
		id_mercadoria INT NOT NULL,
		qr_vendida INT NOT NULL,
		vd_valor float
	CONSTRAINT [PK_venda_item] PRIMARY KEY CLUSTERED 
	(
	[SEQ_venda_item] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	)
end
go

IF OBJECT_ID('venda_item_GEN', 'SO') IS NULL 	
begin
	CREATE SEQUENCE [dbo].[venda_item_GEN] 
		AS [bigint]
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
end
go

if (object_id('venda_item') is not null) and 
   (OBJECT_ID('venda_item_GEN', 'SO') IS not NULL) and
   (OBJECT_ID('DEF_SEQ_venda_item', 'D') is null)
begin
	ALTER TABLE venda_item
		ADD CONSTRAINT DEF_SEQ_venda_item DEFAULT (NEXT VALUE FOR venda_item_GEN) FOR SEQ_venda_item
end
/*
venda_item
*/




/*
AF = Aggregate function (CLR)

C = CHECK constraint

D = DEFAULT (constraint or stand-alone)

F = FOREIGN KEY constraint

FN = SQL scalar function

FS = Assembly (CLR) scalar-function

FT = Assembly (CLR) table-valued function

IF = SQL inline table-valued function

IT = Internal table

P = SQL Stored Procedure

PC = Assembly (CLR) stored-procedure

PG = Plan guide

PK = PRIMARY KEY constraint

R = Rule (old-style, stand-alone)

RF = Replication-filter-procedure

S = System base table

SN = Synonym

SO = Sequence object
*/

