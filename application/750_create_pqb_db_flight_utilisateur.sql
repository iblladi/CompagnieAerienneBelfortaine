CREATE OR REPLACE PACKAGE BODY PA_UTILISATEUR AS

	FUNCTION checkExistanceOfUser(admeluser VARCHAR2)
  RETURN sqlcur
  IS
	cursor_check sqlcur;
	BEGIN
  open cursor_check for
			SELECT * 
			FROM UTILISATEUR
			WHERE ADMEL_USER = admeluser;
		return cursor_check;
	END checkExistanceOfUser;
  
  Function getIdofUser(admeluser VARCHAR2) 
  return number
  is
  iduser number;
  BEGIN
    select num_user into iduser
    from utilisateur
    where admel_user = admeluser;
    return iduser;
  end getIdofUser;
  
  Function getAdmelUser(numuser number) 
  return varchar2
  is
  admeluser varchar2(50);
  BEGIN
    select admel_user into admeluser
    from utilisateur
    where num_user = numuser;
    return admeluser;
  end getAdmelUser;
  
	PROCEDURE AddUSER(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2) IS
	BEGIN
		INSERT INTO UTILISATEUR (NOM_USER,PRE_USER,NUM_CATEG,DNAISS_USER,NRUE_USER,CP_USER,VILLE_USER,PAYS_USER,TEL_USER,ADMEL_USER,TYPE_USER) VALUES (nomuser,preuser,numcateg,TO_DATE(dnaissuser,'YYYY-MM-DD'),nrueuser,cpuser,villeuser,paysuser,teluser,admeluser,'C');
    commit;
    ui_utlisateur.redirect_passager(admeluser);
  END AddUSER;

	PROCEDURE updateUser(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2,natiopasg VARCHAR2,numpasspasg VARCHAR2) IS
	BEGIN
		UPDATE UTILISATEUR 
		SET NATIO_PASG = natiopasg
		,NUMPASS_PASG = numpasspasg
		WHERE ADMEL_USER = admeluser;
    commit;
    ui_reservation.redirect(admeluser);
	END updateUser;
  
  PROCEDURE addpassager(nomuser VARCHAR2,preuser VARCHAR2,numcateg NUMBER,dnaissuser VARCHAR2,nrueuser VARCHAR2,cpuser VARCHAR2,villeuser VARCHAR2,paysuser VARCHAR2,teluser VARCHAR2,admeluser VARCHAR2,natiopasg VARCHAR2,numpasspasg VARCHAR2) IS
  begin
  INSERT INTO UTILISATEUR (NOM_USER,PRE_USER,NUM_CATEG,DNAISS_USER,NRUE_USER,CP_USER,VILLE_USER,PAYS_USER,TEL_USER,ADMEL_USER,TYPE_USER,NATIO_PASG,NUMPASS_PASG) VALUES (nomuser,preuser,numcateg,TO_DATE(dnaissuser,'YYYY-MM-DD'),nrueuser,cpuser,villeuser,paysuser,teluser,admeluser,'P',natiopasg,numpasspasg);
  commit;
  ui_reservation.redirect(admeluser);
  end addpassager;

END PA_UTILISATEUR;
/
