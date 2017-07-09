{*******************************************************************
* *
* Tipo: Programa() InterfazImplementacion TAD () Otros() *
* Autor/es: Jose Miguel Garcia Benayas *
* Descripcion: Unidad Elemento *
* *
*******************************************************************}

UNIT Elem;
INTERFACE
	TYPE
		TElem = Integer;
	PROCEDURE CopiarElem (origen: TElem; VAR destino: TElem);
	FUNCTION IgualesElem (e1,e2: TElem): Boolean;
	PROCEDURE ImprimirElem (e: TElem);
IMPLEMENTATION
	PROCEDURE CopiarElem (origen: TElem; VAR destino: TElem);
	BEGIN
		destino:=origen;
	END;
	FUNCTION IgualesElem (e1,e2: TElem): Boolean;
	BEGIN
		IgualesElem:=(e1=e2);
	END;
	PROCEDURE ImprimirElem(e: TElem);
	BEGIN
		write (e);
	END;
END.
