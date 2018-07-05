CREATE OR REPLACE PACKAGE BODY pa_volreel AS

FUNCTION rechercheVol(villedep VARCHAR2,villearr VARCHAR2,datedep VARCHAR2,classe varchar2) 
RETURN sqlcur
IS
	cursor_recherchevol sqlcur;
BEGIN
	OPEN cursor_recherchevol FOR
		SELECT *
		FROM view_volreel_recherche
		WHERE
			VILLEDEP_VOLCOM = villedep
				AND
			VILLEARR_VOLCOM = villearr
				AND
			TO_CHAR(DHDEP_VOLREEL,'YYYY-MM-DD') = datedep
        			AND
      			nom_class = classe
		ORDER BY PRIX_VOL;
	RETURN cursor_recherchevol;
END rechercheVol;
	
	
	
FUNCTION PrixReduit(numvol NUMBER,cls VARCHAR2) 
return Number
IS
    remiseclasse number;
    prixreduit number;
    prixvol number;
BEGIN
  select REMISE_CLASS,PRIX_VOL into remiseclasse,prixvol
  FROM VIEW_VOLREEL_RECHERCHE
  WHERE NOM_CLASS = cls and CODE_VOLREEL=numvol;
  prixreduit := prixvol - (prixvol * remiseclasse/100);
	return prixreduit;

END PrixReduit;

function getNUMVOLCOMByCODEVOLREEL(codevolreel number) return NUMBER is 
    numvolcom NUMBER;
		begin
			select NUM_VOLCOM into numvolcom
			from VOL_REEL
			where CODE_VOLREEL = codevolreel;
		return numvolcom;
end getNUMVOLCOMByCODEVOLREEL;

function getinfovol(codevolreel number) return vol_reel%rowtype is
infovol vol_reel%rowtype;
begin
  select * into infovol from VOL_REEL where code_volreel=codevolreel;
return infovol;
end getinfovol;
  

END pa_volreel;
/

