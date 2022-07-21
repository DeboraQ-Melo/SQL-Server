CREATE TABLE [dbo].[Hitorico_Fragmentacao_Indice](
	[Id_Hitorico_Fragmentacao_Indice] [int] IDENTITY(1,1) NOT NULL,
	[Dt_Referencia] [datetime] NULL,
	[Nm_Servidor] [varchar](50) NULL,
	[Nm_Database] [varchar](50) NULL,
	[Nm_Tabela] [varchar](50) NULL,
	[Nm_Indice] [varchar](70) NULL,
	[Avg_Fragmentation_In_Percent] [numeric](5, 2) NULL,
	[Page_Count] [int] NULL,
	[Fill_Factor] [tinyint] NULL
)

INSERT INTO 
	Hitorico_Fragmentacao_Indice(Dt_Referencia,Nm_Servidor,Nm_Database,Nm_Tabela,Nm_Indice,Avg_Fragmentation_In_Percent,Page_Count,Fill_Factor)
SELECT getdate(), @@servername,  db_name(db_id()), object_name(B.Object_id), B.Name,  avg_fragmentation_in_percent,page_Count,fill_factor
FROM sys.dm_db_index_physical_stats(db_id(),null,null,null,null) A
join sys.indexes B on a.object_id = B.Object_id and A.index_id = B.index_id
ORDER BY object_name(B.Object_id), B.index_id


