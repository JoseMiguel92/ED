{*******************************************************************
* *
* Tipo: Programa() InterfazImplementacion TAD () Otros() *
* Autor/es: Jose Miguel Garcia Benayas *
* Descripcion: Unidad para Colas *
* *
*******************************************************************}

UNIT Cola;
INTERFACE
USES Elem;
TYPE
	TInfo=TElem;
	TCola= ^TNodo;
	TNodo = RECORD
		info: TInfo;
		sgte: TCola;
	END;
PROCEDURE CrearColaVacia(VAR c: TCola);{O(?)}
{Pre = TRUE}
{Post = devuelve la cola vac�a}
PROCEDURE Insertar(VAR c: TCola; e: TInfo);{O(?)}
{Pre = recibe una cola que puede ser vac�a o no}
{Post = devuelve la cola con el elemento e en la �ltima posici�n}
PROCEDURE Primero(c: TCola; VAR e: TInfo);{O(?)}
{Pre = Recibe la cola no vac�a}
{Post = devuelve el primer elemento de la cola}
PROCEDURE Eliminar(VAR c: TCola);{O(?)}
{Pre = recibe una cola no vac�a}
{Post = devuelve la cola sin el primer elemento}
FUNCTION EsColaVacia(c: TCola): BOOLEAN;{O(?)}
{Pre = recibe una cola que puede ser vac�a o no}
{Post = devuelve TRUE si la cola es vac�a, FALSE en caso contrario}
FUNCTION Iguales(c1,c2: TCola): BOOLEAN;{O(?)}
{Pre = recibe una cola que puede ser vac�a o no}
{Post = devuelve TRUE si las dos colas son iguales}
PROCEDURE Copiar(VAR c2: TCola; c1: TCola);{O(?)}
{Pre = recibimos una cola que puede ser vac�a o no}
{Post = devolvemos una nueva cola que es una copia exacta de la primera}
PROCEDURE Destruir(VAR c: TCola);
{Pre = TRUE}
{Post = devuelve la cola vac�a}

IMPLEMENTATION

PROCEDURE CrearColaVacia(VAR c: TCola);{O(?)}
BEGIN
	c:=NIL;
END;

PROCEDURE Insertar(VAR c: TCola; e: TInfo);{O(?)}
VAR
	nuevo:TCola;
BEGIN
	new(nuevo);
	CopiarElem(e,nuevo^.info);
	nuevo^.sgte:=c^.sgte;
	c^.sgte:=nuevo;
END;

PROCEDURE Primero(c: TCola; VAR e: TInfo);{O(?)}
BEGIN
	IF NOT EsColaVacia(c) THEN
		CopiarElem(c^.info,e);
END;

PROCEDURE Eliminar(VAR c: TCola);{O(?)}
VAR
	pAux:TCola;
BEGIN
	pAux:=c;
	c:=c^.sgte;
	WHILE c^.sgte<>pAux DO
		c:=c^.sgte;
	c^.sgte:=pAux^.sgte;
	dispose(pAux);
END;

FUNCTION EsColaVacia(c: TCola): BOOLEAN;{O(?)}
BEGIN
	EsColaVacia:=(c=NIL);
END;

FUNCTION Iguales(c1,c2: TCola): BOOLEAN;{O(?)}
VAR
	p1,p2:TCola;
BEGIN
	IF EsColaVacia(c1) THEN
		Iguales:= EsColaVacia(c2)
	ELSE
	BEGIN
		Iguales:=TRUE;
		p1:=c1^.sgte;
		p2:=c2^.sgte;
		WHILE (p1<>c1) AND (p2<>c2) AND Iguales DO
		IF IgualesElem(p1^.info,p2^.info) THEN
		BEGIN
			p1:=p1^.sgte;
			p2:=p2^.sgte;
		END
		ELSE
			Iguales:=FALSE;
END;

PROCEDURE Copiar(VAR c2: TCola; c1: TCola);{O(?)}
BEGIN
	CrearColaVacia(c2);
	pAux:=c2;
	WHILE c1<>NIL DO
		CopiarElem
END;

PROCEDURE Destruir(VAR c: TCola);
VAR
	pAux:TCola;
BEGIN
	IF NOT EsColaVacia(c) THEN
	BEGIN
		WHILE c^.sgte<>c DO
		BEGIN
			pAux:=c^.sgte;
			c^.sgte:=pAux^.sgte;
			dispose(pAux);
		END;
		pAux:=c;
		c:=NIL
		dispose(pAux);
	END;{IF}
END;

END.
