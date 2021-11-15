viveen(dracula,castillo).
viveen(godzilla,espacio).
viveen(sullivan,espacio).
viveen(mlegrand,tv).
viveen(frankenstein,castillo).
viveen(barney,tv).
viveen(allien,espacio).
viveen(a,espacio).
viveen(b,espacio).
viveen(c,espacio).
viveen(d,espacio).
viveen(e,espacio).
viveen(cristina,buenosaires).
viveen(nestor,buenosaires).
viveen(masa,buenosaires).

viveen(x,planocartesiano).
viveen(y,planocartesiano).
viveen(z,planocartesiano).

maneja(godzilla,auto(4)).
maneja(godzilla,auto(3)). /*agregado mas de un vehiculo*/
maneja(barney,colectivo(fucsia,10,5)).
maneja(sullivan,nave([2,3,1])).
maneja(allien,nave([3,4])).

maneja(cristina,auto(14)).
maneja(nestor,auto(14)).
maneja(masa,colectivo(celeste,10,10)).

maneja(x,auto(14)).
maneja(y,auto(14)).
maneja(z,colectivo(celeste,10,10)).


/*1 Un mounstro esta de a pie si no lleva veiculo*/
apie(Monstruo):-
	viveen(Monstruo,_),
	not(maneja(Monstruo,_)).

/*2 El primer monstruo puede llevar al segundo si ambos viven en el mismo lugar y el primero maneja vehiculo*/
puedellevar(Monstruo1,Monstruo2):-
	viveen(Monstruo1,Lugar),
	viveen(Monstruo2,Lugar),
	Monstruo1\=Monstruo2,
	maneja(Monstruo1,_).

/*CANTIDAD PASAJEROS cp(X,Y) Devuelve la (C-Pas-1) o (C-1) si hay mas monstruos en el lugar que la capacidad que soporta*/
pasajeros(Monstruo,Cantidad):-
	viveen(Monstruo,_),
	findall(X,puedellevar(Monstruo,X),Listapasajeros),
	Listapasajeros\=[],
	length(Listapasajeros,Cantidad).

capacidad(Monstruo,Capacidad):-
	maneja(Monstruo,auto(Capacidad)).

capacidad(Monstruo,Capacidad):-
	maneja(Monstruo,nave(Listcap)),
	sumlist(Listcap,Capacidad).

capacidad(Monstruo,Capacidad):-
	maneja(Monstruo,colectivo(_,A1,A2)),
	Capacidad is A1+A2*2.

cp(Monstruo,Cantidad):-
	pasajeros(Monstruo,Pas),
	capacidad(Monstruo,Cap),
	Cantidad is Cap-Pas-1,
	Cantidad >0.

cp(Monstruo,Puedellevar):-
	pasajeros(Monstruo,Pas),
	capacidad(Monstruo,Cap),
	Cantidad is Cap-Pas-1,
	Cantidad<0,
	Puedellevar is Cap.

/*4 Lugar vehiculuzado si todos los que viven ahi tienen vehiculos de gran tamanho QUE SEA INVERSIBLE*/
autogrande(Monstruo):-
	maneja(Monstruo,auto(Cap)),
	Cap>10.

autogrande(Monstruo):-
	maneja(Monstruo,nave(Lcap)),
	sumlist(Lcap,Cap),
	Cap>10.

autogrande(Monstruo):-
	maneja(Monstruo,colectivo(_,A1,A2)),
	Cap is A1+A2*2,
	Cap>10.

lv(Lugar):- 
	viveen(_,Lugar),
	forall(viveen(Monstruo,Lugar),autogrande(Monstruo)).

listavehic(Lista):-
	findall(X,lv(X),L),
	list_to_set(L,Lista).

lugarvehiculizado(Lugar):- /*es inversible*/
	listavehic(Lista),
	member(Lugar,Lista).


