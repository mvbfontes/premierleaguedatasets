  
  --Criando banco de dados de exemplo

  CREATE DATABASE Sports

  GO

  USE Sports
  GO

  --Criando tabela com coluna DOC no formato JSON
  
  CREATE TABLE Player
  (id INT IDENTITY CONSTRAINT PK_JSON PRIMARY KEY,
  DOC VARCHAR(MAX) constraint [Properly formatted JSON] CHECK (ISJSON(DOC)>0));

  --Gerando loop para carregar todos os arquivos para o SQL Server

declare @i int = 1
declare @file nvarchar(max)
declare @json nvarchar(MAX)
declare @sql nvarchar(max)
 

 WHILE(@i<724)

 BEGIN

 SET @file = '''c:\json\' + cast(@i as varchar(5)) + '.json''';

 SET @sql = 'INSERT INTO Player
SELECT BulkColumn
 FROM OPENROWSET (BULK '+@file+', SINGLE_CLOB) as j'

SET @i = @i +1;

EXEC sp_executesql @sql

END


--Consulta para retornar os 10 jogadores do Leicester City que mais marcaram gols

 SELECT 
 TOP 10 
 JSON_VALUE(doc,'$.web_name') AS player_name,
 JSON_VALUE(doc,'$.goals_scored') AS goals_scored	
 FROM Player p
 WHERE  JSON_VALUE(doc,'$.team_name') = 'Leicester'
 ORDER BY  cast(JSON_VALUE(doc,'$.goals_scored')as int) DESC

