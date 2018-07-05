CREATE OR REPLACE PACKAGE BODY pa_ville AS

FUNCTION getALLVille RETURN sqlcur
IS
	cursor_ville sqlcur;
BEGIN
	OPEN cursor_ville FOR
		SELECT *  
		FROM VILLE
		ORDER BY NOM_VILLE;
	RETURN cursor_ville;
END getALLVille ;

END pa_ville;
/

