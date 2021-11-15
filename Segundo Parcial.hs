equipos = ["uruguay","italia","argentina","brasil","hungria","alemania","coreasur"]

partidos = 
	[
		(1954,"hungria",9,"coreasur",0,"ronda1"),
		(2014,"argentina",2,"alemania",0,"final"),
		(1954,"hungria",8,"alemania",3,"ronda1"),
		(2014,"alemania",7,"brasil",1,"semifinal"),
		(1994,"italia",0,"brasil",0,"final"),
		(1978,"argentina",10,"brasil",0,"final")
	]

--1)

--Devuelve los goles que hizo un equipo en un partido
goles (anho,eq1,gol1,eq2,gol2,instancia) equipo
	|eq1==equipo = gol1
	|eq2==equipo = gol2
	|otherwise = 0

--Devuelve true si un equipo jugo un partido
jugo (anho,eq1,gol1,eq2,gol2,instancia) equipo = eq1==equipo || eq2==equipo

--Devuelve true si un equipo gano un partido
gano (anho,eq1,gol1,eq2,gol2,instancia) equipo 
	|eq1==equipo = gol1>gol2
	|eq2==equipo = gol2>gol1
	|otherwise = False

--Devuelve true si un partido gano, y ademas hizo mas de tres goles
goleada partido equipo = (gano partido equipo) && (goles partido equipo)>3


--2)

--devuelve true si un equipo gano algun partido
ganopartidos equipo
	|elem True (map (flip gano equipo) partidos)  = True
	|otherwise = False

ganopartidos2 equipo = any (==True) (map (flip gano equipo) partidos)

nogano equipo = not(ganopartidos equipo) --devuelve true si un equipo no gano nunca un partido

nuncaganaron = filter (nogano) equipos --devuelve todos los equipos qeu nunca ganaron

--3)

--a)

ganoalguno = filter (ganopartidos) equipos --devuelve una lista con todos los equipos que al menos ganaron una vez

--c)

year (anho,eq1,gol1,eq2,gol2,instancia) = anho --Devuelve el anho de un partido

mundialesjugados equipo = map(year)(filter(flip jugo equipo) partidos) --devuelve true si un equipo jugo un mundial

playeo78 equipo = elem 1978 (mundialesjugados equipo) -- devuelve true si un equipo jugo el mundial 78

equipos78 = filter (playeo78) equipos -- devuelve todos los equipos que jugaron el mundial de 78

--b)

recibio7 (anho,eq1,gol1,eq2,gol2,instancia) equipo  --Devuelve true si un equipo recibio 7 o mas goles en un partido
	|eq1==equipo = gol2>=7
	|eq2==equipo = gol1>=7
	|otherwise = False

rec7 equipo = elem True (map(flip recibio7 equipo) partidos) -- devuelve true si un equipo recibio 7 o mas goles en algun partido

recibieron7 = filter (rec7) equipos --devuelve todos los equipos que recibieron 7 o mas goles en algun partido

--c)

singolesfn (anho,eq1,gol1,eq2,gol2,instancia) equipo  --devuelve true si jugo un partido final y no le hicieron goles
	|eq1==equipo && instancia=="final" && gol2==0 = True 
	|eq2==equipo && instancia=="final" && gol1==0 = True
	|otherwise = False

jugofinalsingoles equipo = (elem True (map(flip singolesfn equipo) partidos)) --devuelve true si de todos los partidos que jugo, alguno es una final sin goles

jugaronfinalsingoles = filter (jugofinalsingoles) equipos --devuelve todos los equipos que jugaron finales y no recibieron goles