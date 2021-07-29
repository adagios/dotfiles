SET @max_signed_int=2147483647;
SET @max_unsigned_int=4294967295;
SET @max_unsigned_bigint=1.84467E19;

SELECT Concat(tab.table_schema, '.', tab.table_name)                   AS tabela
       , cols.column_type                                              AS tipo
       , tab.auto_increment
       , Round(( tab.auto_increment / @max_signed_int ) * 100, 2)      AS `% INT`
       , Round(( tab.auto_increment / @max_unsigned_int ) * 100, 2)    AS `% UINT`
       , Round(( tab.auto_increment / @max_unsigned_bigint ) * 100, 2) AS `% UBINT`
  FROM information_schema.tables tab
       INNER JOIN information_schema.columns cols
               ON cols.table_schema = tab.table_schema
                  AND cols.table_name = tab.table_name
                  AND cols.extra = 'auto_increment'
 WHERE ( cols.column_type LIKE 'int%'
         AND Round(( tab.auto_increment / @max_signed_int ) * 100, 2) > 20 )
    OR ( cols.column_type LIKE 'int%unsigned'
         AND Round(( tab.auto_increment / @max_unsigned_int ) * 100, 2) > 20 )
    OR Round(( tab.auto_increment / @max_unsigned_bigint ) * 100, 2) > 20
 ORDER BY Concat(tab.table_schema, '.', tab.table_name);
