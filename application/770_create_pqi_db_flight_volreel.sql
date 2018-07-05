CREATE OR REPLACE PACKAGE pa_volreel AS
  TYPE sqlcur IS REF CURSOR;
  FUNCTION rechercheVol(villedep VARCHAR2,villearr VARCHAR2,datedep VARCHAR2,classe VARCHAR2) return sqlcur;
  FUNCTION PrixReduit(numvol NUMBER,cls VARCHAR2) return Number;
  FUNCTION getNUMVOLCOMByCODEVOLREEL(codevolreel number) return Number;
  function getinfovol(codevolreel number) return vol_reel%rowtype;
END pa_volreel;
/