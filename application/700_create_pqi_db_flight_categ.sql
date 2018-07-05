CREATE OR REPLACE package pa_categ is
	TYPE sqlcur IS REF CURSOR;
	Function getid (nomcateg varchar2) return Number;
	Function getALLCateg return sqlcur;
END pa_categ;
/