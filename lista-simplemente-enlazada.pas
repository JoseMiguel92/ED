{*******************************************************************
* *
* Tipo: Programa() InterfazImplementacion TAD () Otros() *
* Autor/es: Jose Miguel Garcia Benayas *
* Descripcion: Unidad para Listas Dinamicas con Enlace Simple *
* *
*******************************************************************}

UNIT Lista;
INTERFACE
	USES Elem;
TYPE
	TInfo=TElem;
	TLista= ^TNodo;
	TNodo = RECORD
		info: TInfo;
		sgte: TLista;
END;
{Constructuras generadoras}
PROCEDURE CrearListaVacia(VAR l: TLista);{O(?)}
	{Pre = TRUE}
	{Post = devuelve la lista vacia}
PROCEDURE Construir(VAR l: TLista; e: TInfo);{O(?)}
	{Pre = recibe una lista que puede ser vacia o no}
	{Post = devuelve la lista con el elemento e en la primera
	posicion}

{Observadoras selectoras}
PROCEDURE Primero(l: TLista; VAR e: TInfo);{O(?)}
	{Pre = Recibe la lista no vac�a}
	{Post = devuelve el primer elemento de la lista}
PROCEDURE Resto(l: TLista; VAR l2: TLista);{O(?)}
	{Pre = recibe una lista no vac�a}
	{Post = devuelve una lista sin el primer elemento de la original}

{Observadoras no selectoras}
FUNCTION EsListaVacia(l: TLista): BOOLEAN;{O(?)}
	{Pre = recibe una lista que puede ser vac�a o no}
	{Post = devuelve TRUE si la lista es vac�a, FALSE en caso
	contrario}
FUNCTION Longitud(l: TLista): integer;{O(?)}
	{Pre = recibe una lista que puede ser vac�a o no}
	{Post = devuelve el n�mero de elementos de la lista}
PROCEDURE Ultimo(l: TLista; VAR e: TInfo);{O(?)}
	{Pre = recibe una lista no vac�a}
	{Post = en e devuelve la informaci�n del �ltimo elemento de la
	lista}
FUNCTION Pertenece(l: TLista; e: TInfo): BOOLEAN;{O(?)}
	{Pre = recibe una lista que puede ser vac�a o no, y un elemento}
	{Post = si el elemento est� en la lista devuelve TRUE, en caso
	contrario FALSE}

{Constructoras no generadoras}
PROCEDURE Concatenar(l1,l2: TLista; VAR l3: TLista);{O(?)}
	{Pre = recibimos dos listas, l1 y l2, que pueden ser vac�as o no}
	{Post = devolvemos una nueva lista que primero tiene los elementos
	de l1 y luego los de l2}
PROCEDURE BorrarElemento(VAR l: TLista; e: TInfo);{O(?)}
	{Pre = recibe una lista que puede ser o no vac�a, y un elemento}
	{Post = si el elemento pertenece a la lista, devolvemos la lista
	sin la primera aparici�n del elemento. En caso contrario,
	devolvemos la lista original}
PROCEDURE InsertarFinal(VAR l: TLista; e: TInfo);{O(?)}
	{Pre = recibe una lista que puede ser vac�a o no}
	{Post = devuelve la lista con el elemento en la �ltima posici�n}

PROCEDURE Copiar (VAR l1: TLista; l2: TLista);
	{Pre = recibe una lista que puede ser o no vac�a}
	{Post = en l1 devolvemos una copia de l2}
FUNCTION Iguales(l1, l2: TLista): Boolean;
	{Pre = recibe dos listas que pueden ser o no vac�as}
	{Post = si son iguales, es decir, contienen los mismos
	elementos en el mismo orden, devuelve cierto}
PROCEDURE Destruir(VAR l: TLista);{O(?)}
	{Pre = TRUE}
	{Post = devuelve la lista vac�a despu�s de liberar toda la
	memoria que utilizaba}

IMPLEMENTATION

PROCEDURE CrearListaVacia(VAR l: TLista);{O(?)}
BEGIN
	l:=NIL;
END;{CrearListaVacia}

PROCEDURE Construir(VAR l: TLista; e: TInfo);{O(?)}
VAR
	nuevo:TLista;
BEGIN
	new(nuevo);
	CopiarElem(e,nuevo^.info);
	nuevo^.sgte:=l;
	l:=nuevo;
END;{Construir}

PROCEDURE Primero(l: TLista; VAR e: TInfo);{O(?)}
BEGIN
	IF NOT EsListaVacia(l)THEN
		CopiarElem(l^.info,e);
END;{Primero}

PROCEDURE Resto(l: TLista; VAR l2: TLista);{O(?)}
VAR
  	paux:TLista;
BEGIN
	IF NOT EsListaVacia(l) THEN
	BEGIN
		paux:=l^.sgte;
		CrearListaVacia(l2);
		WHILE paux<>NIL DO
		BEGIN
			InsertarFinal(l2,paux^.info);
			paux:=paux^.sgte;
		END;{WHILE}
	END;{IF}
END;{Resto}

FUNCTION EsListaVacia(l: TLista): BOOLEAN;{O(?)}
BEGIN
	EsListaVacia:=l=NIL;
END;{EsListaVacia}

FUNCTION Longitud(l: TLista): INTEGER;{O(?)}
VAR
	contador:integer;
BEGIN
	contador:=0;
	IF NOT EsListaVacia(l)THEN
		WHILE l<>NIL DO
		BEGIN
			contador:=contador+1;
			l:=l^.sgte;
		END;{WHILE}
	Longitud:=contador;
END;{Longitud}

PROCEDURE Ultimo(l: TLista; VAR e: TInfo);{O(?)}
BEGIN
	IF NOT EsListaVacia(l)THEN
	BEGIN
		WHILE l^.sgte<>NIL DO
			l:=l^.sgte;
		CopiarElem(l^.info,e);
	END;{IF}
END;{Ultimo}

FUNCTION Pertenece(l: TLista; e: TInfo): BOOLEAN;{O(?)}
VAR
	encontrado:BOOLEAN;
BEGIN
	IF NOT EsListaVacia(l)THEN
	BEGIN
		encontrado:=FALSE;
		WHILE (l<>NIL) AND (NOT encontrado) DO
			IF IgualesElem(l^.info,e) THEN
				encontrado:=TRUE
			ELSE
				l:=l^.sgte;
		Pertenece:=encontrado;
	END;{IF}
END;{Pertenece}

PROCEDURE Concatenar(l1,l2: TLista; VAR l3: TLista);{O(?)}
BEGIN
	CrearListaVacia(l3);
	WHILE l1<>NIL DO
	BEGIN
		InsertarFinal(l3,l1^.info);
		l1:=l1^.sgte;
	END;{WHILE l1}
	WHILE l2<>NIL DO
	BEGIN
		InsertarFinal(l3,l2^.info);
		l2:=l2^.sgte;
	END;{WHILE l2}
END;{Concatenar}

PROCEDURE BorrarElemento(VAR l: TLista; e: TInfo);{O(?)}
VAR
	encontrado:boolean;
	pAtras,pDelante:TLista;
BEGIN
	encontrado:=FALSE;
	pAtras:=NIL;
	pDelante:=l;
	IF NOT EsListaVacia(l) THEN
	BEGIN
		WHILE (pDelante<>NIL) AND NOT encontrado DO
		BEGIN
			encontrado:=IgualesElem(e,pDelante^.info);
			IF NOT encontrado THEN
			BEGIN
				pAtras:=pDelante;
				pDelante:=pDelante^.sgte;
			END;{ELSE}
		END;{WHILE}
	END;{IF}
	IF encontrado THEN
	BEGIN
		IF pAtras=NIL THEN
			l:=l^.sgte
		ELSE
			pAtras^.sgte:=pDelante^.sgte;
		dispose(pDelante);
	END;{IF}
END;{BorrarElemento}

PROCEDURE InsertarFinal(VAR l: TLista; e: TInfo);{O(?)}
VAR
	nuevo:TLista;
	paux:TLista;
BEGIN
	new(nuevo);
	CopiarElem(e,nuevo^.info);
	nuevo^.sgte:=NIL;
	IF NOT EsListaVacia(l) THEN
	BEGIN
		paux:=l;
		WHILE (paux^.sgte<>NIL) DO
			paux:=paux^.sgte;
		paux^.sgte:=nuevo;
	END
	ELSE
		l:=nuevo;
END;{InsertarFinal}

PROCEDURE Copiar (VAR l1: TLista; l2: TLista);
BEGIN
	CrearListaVacia(l1);
	WHILE l2<>NIL DO
	BEGIN
		InsertarFinal(l1,l2^.info);
		l2:=l2^.sgte;
	END;{WHILE}
END;{Copiar}

FUNCTION Iguales(l1, l2: TLista): Boolean;
BEGIN
	IF EsListaVacia(l1) AND EsListaVacia(l2) THEN
		Iguales:=TRUE
	ELSE
	BEGIN
		Iguales:=TRUE;
		WHILE (l1<>NIL) AND (l2<>NIL) AND Iguales DO
			IF IgualesElem(l1^.info,l2^.info) THEN
			BEGIN
				l1:=l1^.sgte;
				l2:=l2^.sgte;
			END{IF}
			ELSE
				Iguales:=FALSE;
	END;{ELSE}
END;{Iguales}

PROCEDURE Destruir(VAR l: TLista);{O(?)}
VAR
	paux:TLista;
BEGIN
	IF NOT EsListaVacia(l) THEN
	BEGIN
		WHILE l<>NIL DO
		BEGIN
			paux:=l;
			l:=l^.sgte;
			dispose(paux);
		END;{WHILE}
	END;{IF}
END;{Destruir}
END.
