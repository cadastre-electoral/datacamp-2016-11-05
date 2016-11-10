# BD UNI
shp2pgsql -d -s 2154:4326 -t 2D shp/troncon_de_route.shp public.troncons|psql -d cadelec

# CSV listes anonymisées (via un shapefile issu de QGis à partie des CSV)
shp2pgsql -d -s 4326 shp/liste_elec_anon_villecresnes.shp public.liste_elec|psql -d cadelec

