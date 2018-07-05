CREATE OR REPLACE PACKAGE BODY pa_classe AS

FUNCTION getAllClasse RETURN sqlcur
IS
	cursor_classe sqlcur;
BEGIN
	OPEN cursor_classe FOR
		SELECT * 
		FROM CLASSE
		ORDER BY NOM_CLASS DESC;
	RETURN cursor_classe;
END getAllClasse;

FUNCTION getClasse(nomclass varchar2) RETURN number
IS
	numclass number;
BEGIN
  SELECT NUM_CLASS INTO numclass   
		FROM CLASSE
  where nom_class=nomclass;
	RETURN numclass;
END getClasse;

END pa_classe;
/