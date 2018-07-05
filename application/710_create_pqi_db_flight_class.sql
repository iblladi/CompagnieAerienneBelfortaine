CREATE OR REPLACE PACKAGE pa_classe AS
  TYPE sqlcur IS REF CURSOR;
  function getAllClasse return sqlcur;
  FUNCTION getClasse(nomclass varchar2) RETURN number;
END pa_classe;
/
