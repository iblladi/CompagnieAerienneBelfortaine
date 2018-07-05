CREATE OR REPLACE PACKAGE pa_ville AS
  TYPE sqlcur IS REF CURSOR;
  function getALLVille return sqlcur;
END pa_ville;
/