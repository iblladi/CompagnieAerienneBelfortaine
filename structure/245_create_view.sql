-- -----------------------------------------------------------------------------
--       VUE : view_volreel_recherche
-- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW VIEW_VOLREEL_RECHERCHE
AS
  (SELECT vr.code_volreel,
    vr.num_volcom,
    vr.VILLEDEP_VOLCOM,
    vr.NOM_AERO_DEP,
    vr.DHDEP_VOLREEL,
    vr.VILLEARR_VOLCOM,
    vr.NOM_AERO_ARR,
    vr.DHARR_VOLREEL,
    vr.DUREE_VOL,
    vr.VILLE_ESCALE,
    vr.PRIX_VOL,
    cl.nom_class,
    cl.REMISE_CLASS
  FROM VOL_REEL vr
  INNER JOIN AVION av
  ON vr.num_avion = av.num_avion
  INNER JOIN classe_avion clav
  ON vr.num_avion = clav.num_avion
  INNER JOIN classe cl
  ON cl.num_class = clav.num_class
  );
 
-- -----------------------------------------------------------------------------
--       VUE : Facture
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW FACTURE
AS
 (SELECT BILL.NUM_RESERV ,
    BILL.NUM_BILLET ,
    BILL.num_user ,
    BILL.NOM_USER ,
    bill.pre_user ,
    bill.PRIX_BILLET ,
    VR.NUM_VOLCOM ,
    VR.VILLEDEP_VOLCOM ,
    vr.NOM_TERMINAL_DEP,
    vr.DHDEP_VOLREEL ,
    VR.VILLEARR_VOLCOM ,
    vr.NOM_TERMINAL_ARR,
    vr.DHARR_VOLREEL ,
    vr.DUREE_VOL ,
    vr.NOM_AERO_DEP ,
    vr.NOM_AERO_ARR ,
    cls.nom_class ,
    res.prix_total_reserv ,
    res.EST_PAYEE
  FROM CLASSE CLS
  INNER JOIN BILLET BILL
  ON CLS.NUM_CLASS = BILL.NUM_CLASS
  INNER JOIN RESERVATION RES
  ON BILL.NUM_RESERV = RES.NUM_RESERV
  INNER JOIN VOL_REEL VR
  ON BILL.CODE_VOLREEL = VR.CODE_VOLREEL
  );


-- -----------------------------------------------------------------------------
--       VUE : Panier
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW PANIER
AS
 (SELECT usr.NOM_USER,
    usr.PRE_USER,
    usr.ADMEL_USER,
    res.NUM_RESERV,
    res.NUM_USER,
    res.DATE_RESERV,
    res.EST_PAYEE
  FROM UTILISATEUR usr
  INNER JOIN RESERVATION res
  ON usr.NUM_USER=res.NUM_USER);