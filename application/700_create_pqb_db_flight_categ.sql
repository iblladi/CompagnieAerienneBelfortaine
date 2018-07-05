CREATE OR REPLACE package body pa_categ is

	Function getid (nomcateg varchar2) return Number is 
		numcateg NUMBER;
	BEGIN
		SELECT NUM_CATEG into numcateg
		FROM CATEGORIE
		WHERE CATEG_PASG = nomcateg;
		return numcateg;
	END getid;


	Function getALLCateg return sqlcur is
		cur_categ sqlcur;
	BEGIN
		OPEN cur_categ FOR
			SELECT * 
			FROM CATEGORIE
			ORDER BY CATEG_PASG;
		return cur_categ;
	END getALLCateg;

END pa_categ;
/