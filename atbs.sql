REM TABLESPACE DETAILS
col TABLESPACE_NAME for a30
REM Tablespace & freespace
set linesize 150
set pages 10000
set head on
TTitle CENTER  " ALL TABLESPACE's SIZING DETAILS " SKIP 1 CENTER ========================== SKIP 2 
SELECT tablespace_name,ROUND(SUM(total_mb)-SUM(free_mb)) CUR_USE_MB,
ROUND(SUM(max_mb) - (SUM(total_mb)-SUM(free_mb))) FREE_SPACE_MB,
ROUND(SUM(max_mb)) MAX_SZ_MB,
ROUND((SUM(total_mb)-SUM(free_mb))/SUM(max_mb)*100) PCT_FULL FROM ( SELECT tablespace_name, SUM(bytes)/1024/1024 FREE_MB, 0 TOTAL_MB, 0 MAX_MB FROM dba_free_space GROUP BY tablespace_name UNION SELECT tablespace_name, 0 CURRENT_MB,
SUM(bytes)/1024/1024 TOTAL_MB,
SUM(DECODE(maxbytes,0,bytes, maxbytes))/1024/1024 MAX_MB FROM dba_data_files GROUP BY tablespace_name) GROUP BY tablespace_name order by 5 desc
/ 
