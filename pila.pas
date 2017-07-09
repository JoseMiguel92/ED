{*******************************************************************
* *
* Tipo: Programa() InterfazImplementacion TAD () Otros() *
* Autor/es: Jose Miguel Garcia Benayas *
* Descripcion: Unidad para Pilas *
* *
*******************************************************************}

UNIT Pila;
INTERFACE
USES Elem;
TYPE
	TInfo=TElem;
	TPila= ^TNodo;
	TNodo = RECORD
		info: TInfo;
		sgte: TPila;
END;
    {Constructoras generadoras}
    PROCEDURE CrearPilaVacia(VAR p: TPila);{O(?)}
    {Pre = TRUE}
    {Post = devuelve la pila vac�a}
    PROCEDURE Apilar(VAR p: TPila; e: TInfo);{O(?)}
    {Pre = recibe una pila que puede ser vac�a o no}
    {Post = devuelve la pila con el elemento e en la cima}
    {Observadoras selectoras}
    PROCEDURE Cima(p: TPila; VAR e: TInfo);{O(?)}
    {Pre = Recibe la pila no vac�a}
    {Post = devuelve el primer elemento de la pila}
    PROCEDURE Desapilar(VAR p: TPila);{O(?)}
    {Pre = recibe una pila no vac�a}
    {Post = devuelve una pila sin el primer elemento de la original}
    {Observadoras no selectoras}
    FUNCTION EsPilaVacia(p: TPila): BOOLEAN;{O(?)}
    {Pre = recibe una pila que puede ser vac�a o no}
    {Post = devuelve TRUE si la pila es vac�a, FALSE en caso contrario}
    PROCEDURE Copiar (VAR destino: TPila; origen: TPila);
    {Pre = la variable destino es una pila creada, vac�a o con elementos}
    {Post = la variable destino es una copia exacta de la pila origen}
    FUNCTION Iguales(p1, p2: TPila): Boolean;
    {Pre = TRUE}
    {Post = devuelve TRUE si las dos pilas son iguales}
    PROCEDURE Destruir (VAR pila: TPila);
    {Pre = TRUE}
    {Post = libera la memoria utilizada y devuelve la pila vac�a}

IMPLEMENTATION
    PROCEDURE CrearPilaVacia(VAR p: TPila);{O(?)}
	BEGIN
		p:=NIL;
	END;

    PROCEDURE Apilar(VAR p: TPila; e: TInfo);{O(?)}
    VAR
    	nuevo:TPila;
	BEGIN
		new(nuevo);
		CopiarElem(e,nuevo^.info);
		nuevo^.sgte:=p;
		p:=nuevo;
	END;

    PROCEDURE Cima(p: TPila; VAR e: TInfo);{O(?)}
	BEGIN
		IF NOT EsPilaVacia(p) THEN
			CopiarElem(p^.info,e);
	END;

    PROCEDURE Desapilar(VAR p: TPila);{O(?)}
	VAR
		pAux:TPila;
	BEGIN
		IF NOT EsPilaVacia(p) THEN
		BEGIN
			pAux:=p;
			p:=p^.sgte;
			dispose(paux);
		END;
	END;

    FUNCTION EsPilaVacia(p: TPila): BOOLEAN;{O(?)}
	BEGIN
		EsPilaVacia:=(p=NIL);
	END;

    PROCEDURE Copiar (VAR destino: TPila; origen: TPila);
	VAR
		pAux:TPila;
	BEGIN
		CrearPilaVacia(destino);
		pAux:=destino;
		WHILE origen<>NIL DO
		BEGIN
			CopiarElem(origen^.info,pAux^.info);
			pAux:=pAux^.sgte;
			origen:=origen^.sgte;
		END;{WHILE}
	END;

    FUNCTION Iguales(p1, p2: TPila): Boolean;
	BEGIN
		IF EsPilaVacia(p1) AND EsPilaVacia(p2) THEN
			Iguales:=TRUE
		ELSE
		BEGIN
			Iguales:=TRUE;
			WHILE (p1<>NIL) AND (p2<>NIL) AND Iguales DO
				IF IgualesElem(p1^.info,p2^.info) THEN
				BEGIN
					Iguales:=TRUE;
					p1:=p1^.sgte;
					p2:=p2^.sgte;
				END
				ELSE
					Iguales:=FALSE;
		END;{ELSE}
		Iguales:=(p1=NIL)AND(p2=NIL)AND(Iguales);
	END;

    PROCEDURE Destruir (VAR pila: TPila);
	BEGIN
		WHILE pila<>NIL DO
			Desapilar(pila);
	END;
END.
