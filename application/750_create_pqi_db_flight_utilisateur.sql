CREATE OR REPLACE PACKAGE PA_UTILISATEUR AS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION checkExistanceOfUser(admeluser VARCHAR2) RETURN sqlcur;
  Function getIdofUser(admeluser VARCHAR2) return number;
  Function getAdmelUser(numuser number) return varchar2;
	PROCEDURE AddUSER(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2);
	PROCEDURE updateUser(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2,natiopasg VARCHAR2,numpasspasg VARCHAR2);
  PROCEDURE addpassager(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2,natiopasg VARCHAR2,numpasspasg VARCHAR2);

END PA_UTILISATEUR;
/
