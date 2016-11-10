CREATE TABLE IF NOT EXISTS bureaux (
geom geometry(Polygon,4326),
bureau integer,
id integer);

DROP TABLE IF EXISTS st_pol CASCADE;
CREATE TABLE st_pol
as
select ST_SetSRID((ST_Dump(st_polygonize(geom))).geom,4326) geom
from troncons  ;
ALTER TABLE st_pol ADD COLUMN id serial;

DROP TABLE IF EXISTS poly_bureau_1 CASCADE;
CREATE TABLE poly_bureau_1
AS
SELECT DISTINCT p.geom,p.id,l.bureau
FROM st_pol  p
JOIN liste_elec l
ON ST_Contains(p.geom,l.geom);

TRUNCATE bureaux;

-- parcelles dans aucun bureau
WITH
c
AS
(SELECT id FROM st_pol
EXCEPT
SELECT id FROM poly_bureau_1)
INSERT INTO bureaux
SELECT p.geom,0::integer,p.id
FROM st_pol p
JOIN c USING (id);

-- parcelles dans 1 seul bureau
WITH
c
AS
(SELECT id FROM poly_bureau_1
GROUP BY 1
HAVING count(*) = 1)
INSERT INTO bureaux
SELECT p.geom,p.bureau,p.id
FROM poly_bureau_1 p
JOIN c USING (id);

-- troncons mono bureaux
CREATE TABLE IF NOT EXISTS troncons_mono_bureau(
  troncon_id integer,
  bureau integer);

TRUNCATE TABLE troncons_mono_bureau;
WITH
l
AS
(select ST_Buffer(l.geom,0.0001,2)geom,l.gid,l.bureau
from liste_elec l
left outer join bureaux b
on ST_Contains(b.geom,l.geom)
WHERE b.id is null),
d
AS
(SELECT t.gid troncon_id,l.gid ad_id,l.bureau,ST_Distance(l.geom,t.geom) dist
FROM l
JOIN troncons t
ON l.geom && t.geom),
r
AS
(SELECT d.*,rank() OVER(PARTITION BY ad_id ORDER BY dist) rang FROM d)
INSERT INTO troncons_mono_bureau  
SELECT DISTINCT troncon_id,bureau FROM r WHERE rang = 1;

DROP TABLE IF EXISTS troncons_mono_bureau_geom CASCADE;
CREATE TABLE troncons_mono_bureau_geom
AS
SELECT t.*,tm.bureau
FROM troncons t
JOIN troncons_mono_bureau tm
ON t.gid = tm.troncon_id
JOIN (SELECT troncon_id FROM troncons_mono_bureau GROUP BY 1 HAVING count(*) = 1)a
USING (troncon_id);

-- Tronçons à splitter entre plusieurs bureaux
DROP TABLE IF EXISTS troncons_multi_bureau_geom CASCADE;
CREATE TABLE troncons_multi_bureau_geom
AS
SELECT t.*,tm.bureau
FROM troncons t
JOIN troncons_mono_bureau tm
ON t.gid = tm.troncon_id
JOIN (SELECT troncon_id FROM troncons_mono_bureau GROUP BY 1 HAVING count(*) > 1)a
USING (troncon_id);

