-- -----------------------------------------------------------------------------
--       TABLE : UTILISATEUR
-- -----------------------------------------------------------------------------
CREATE TABLE UTILISATEUR
   (
    NUM_USER NUMBER(6)  NOT NULL,
    NUM_CATEG NUMBER(1)  NULL,
    NOM_USER VARCHAR2(50)  NOT NULL,
    PRE_USER VARCHAR2(50)  NOT NULL,
    DNAISS_USER DATE  NOT NULL,
    NRUE_USER VARCHAR2(35)  NOT NULL,
    CP_USER VARCHAR2(8)  NOT NULL,
    VILLE_USER VARCHAR2(25)  NOT NULL,
    PAYS_USER VARCHAR2(25)  NOT NULL,
    TEL_USER VARCHAR2(20)  NOT NULL,
    ADMEL_USER VARCHAR2(40)  NOT NULL,
    NATIO_PASG VARCHAR2(20)  NULL,
    NUMPASS_PASG VARCHAR2(30)  NULL,
    TYPE_USER CHAR(1)  NOT NULL
   )
ORGANIZATION INDEX   
PARTITION BY LIST (TYPE_USER)
(
    PARTITION P_CLIENT VALUES ('C'),
    PARTITION P_PASSAGER VALUES ('P')
) 
   TABLESPACE BD50_DATA ;
   

-- -----------------------------------------------------------------------------
--       TABLE : RESERVATION
-- -----------------------------------------------------------------------------
CREATE TABLE RESERVATION
   (
    NUM_RESERV NUMBER(10)  NOT NULL,
    NUM_USER NUMBER(6)  NOT NULL,
    DATE_RESERV DATE  NULL,
    CODE_PROMOTION_RESERV VARCHAR2(10)  NULL,
    PRIX_TOTAL_RESERV NUMBER(13,2)  NULL,
	EST_PAYEE NUMBER(1) DEFAULT 0 NOT NULL
   )
ORGANIZATION INDEX   
PARTITION BY RANGE(DATE_RESERV)
	(PARTITION P_RESJANVIER  VALUES LESS THAN (TO_DATE ('01/02/2018','DD/MM/YYYY')),
	PARTITION P_RESFEVRIER   VALUES LESS THAN (TO_DATE ('01/03/2018','DD/MM/YYYY')),
	PARTITION P_RESMARS      VALUES LESS THAN (TO_DATE ('01/04/2018','DD/MM/YYYY')),
	PARTITION P_RESAVRIL     VALUES LESS THAN (TO_DATE ('01/05/2018','DD/MM/YYYY')),
	PARTITION P_RESMAI       VALUES LESS THAN (TO_DATE ('01/06/2018','DD/MM/YYYY')),
	PARTITION P_RESJUIN      VALUES LESS THAN (TO_DATE ('01/07/2018','DD/MM/YYYY')),
	PARTITION P_RESJUILLET   VALUES LESS THAN (TO_DATE ('01/08/2018','DD/MM/YYYY')),
	PARTITION P_RESAOUT      VALUES LESS THAN (TO_DATE ('01/09/2018','DD/MM/YYYY')),
	PARTITION P_RESSEPTEMBRE VALUES LESS THAN (TO_DATE ('01/10/2018','DD/MM/YYYY')),
	PARTITION P_RESOCTOBRE   VALUES LESS THAN (TO_DATE ('01/11/2018','DD/MM/YYYY')),
	PARTITION P_RESNOVEMBRE  VALUES LESS THAN (TO_DATE ('01/12/2018','DD/MM/YYYY')),
	PARTITION P_RESDECEMBRE  VALUES LESS THAN (MAXVALUE)
)
   TABLESPACE BD50_DATA ;   

   
   
-- -----------------------------------------------------------------------------
--       TABLE : PERSONNEL
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNEL
   (
    CODE_PERSON NUMBER(6)  NOT NULL,
    NOM_PERSON VARCHAR2(50)  NOT NULL,
    PRE_PERSON VARCHAR2(50)  NOT NULL,
    SEXE_PERSON CHAR(1)  NOT NULL   CHECK (SEXE_PERSON IN ('H', 'F')),
    DNAISS_PERSON DATE  NOT NULL,
    DEMB_PERSON DATE  NOT NULL,
    NRUE_PERSON VARCHAR2(35)  NOT NULL,
    CP_PERSON VARCHAR2(8)  NOT NULL,
    VILLE_PERSON VARCHAR2(25)  NOT NULL,
    TEL_PERSON VARCHAR2(20)  NOT NULL,
    CUMUL_HRVOL_PERSON NUMBER(3)  NULL,
    SALAIRE_PERSON NUMBER(13,2)  NULL,
    LICENCE_PILOTE VARCHAR2(30)  NULL,
    DIPLOME_STEWARD VARCHAR2(30)  NULL,
    TYPE_PERSONNEL CHAR(1)  NOT NULL
   )
ORGANIZATION INDEX   
PARTITION BY LIST (TYPE_PERSONNEL)
(
    PARTITION P_CLIENT VALUES ('P'),
    PARTITION P_PASSAGER VALUES ('S')
) 
   TABLESPACE BD50_DATA ;

   
   
-- -----------------------------------------------------------------------------
--       TABLE : VOL_REEL
-- -----------------------------------------------------------------------------

CREATE TABLE VOL_REEL
   (
    NUM_VOLCOM NUMBER(4)  NOT NULL,
    CODE_VOLREEL NUMBER(6)  NOT NULL,
    NUM_AVION NUMBER(6)  NOT NULL,
    DHDEP_VOLREEL DATE  NOT NULL,
    DHARR_VOLREEL DATE  NOT NULL,
    DUREE_VOL NUMBER GENERATED ALWAYS AS ((DHARR_VOLREEL - DHDEP_VOLREEL) * 24 * 60) VIRTUAL,
    PRIX_VOL NUMBER(13,2)  NOT NULL,
    RETARD_VOLREEL NUMBER(3) NULL,
    NB_REST_VOLREEL NUMBER(3)  NULL,
    VILLEDEP_VOLCOM VARCHAR2(20)  NULL,
    VILLEARR_VOLCOM VARCHAR2(20)  NULL,
    DDEP_ESCALE DATE  NULL,
    DARR_ESCALE DATE  NULL,
    VILLE_ESCALE VARCHAR2(20)  NULL,
    CODE_AERO_DEP NUMBER(6)  NOT NULL,
    NOM_AERO_DEP VARCHAR2(80)  NULL,
    CODE_AERO_ARR NUMBER(6)  NOT NULL,
    NOM_AERO_ARR VARCHAR2(80)  NULL,
    NUM_TERMINAL_DEP NUMBER(1)  NOT NULL,
    NOM_TERMINAL_DEP VARCHAR2(30)  NULL,
    NUM_TERMINAL_ARR NUMBER(1)  NOT NULL,
    NOM_TERMINAL_ARR VARCHAR2(30)  NULL,
    NB_PREVU_PASSG NUMBER(3)  NULL,
    NB_REEL_PASSG NUMBER(3)  NULL,
    NOM_AVION VARCHAR2(20)  NULL,
    CAPAC_AVION NUMBER(3)  NULL
   )
ORGANIZATION INDEX   
PARTITION BY RANGE(DHDEP_VOLREEL)
	(PARTITION P_VOLJANVIER  VALUES LESS THAN (TO_DATE ('01/02/2018','DD/MM/YYYY')),
	PARTITION P_VOLFEVRIER   VALUES LESS THAN (TO_DATE ('01/03/2018','DD/MM/YYYY')),
	PARTITION P_VOLMARS      VALUES LESS THAN (TO_DATE ('01/04/2018','DD/MM/YYYY')),
	PARTITION P_VOLAVRIL     VALUES LESS THAN (TO_DATE ('01/05/2018','DD/MM/YYYY')),
	PARTITION P_VOLMAI       VALUES LESS THAN (TO_DATE ('01/06/2018','DD/MM/YYYY')),
	PARTITION P_VOLJUIN      VALUES LESS THAN (TO_DATE ('01/07/2018','DD/MM/YYYY')),
	PARTITION P_VOLJUILLET   VALUES LESS THAN (TO_DATE ('01/08/2018','DD/MM/YYYY')),
	PARTITION P_VOLAOUT      VALUES LESS THAN (TO_DATE ('01/09/2018','DD/MM/YYYY')),
	PARTITION P_VOLSEPTEMBRE VALUES LESS THAN (TO_DATE ('01/10/2018','DD/MM/YYYY')),
	PARTITION P_VOLOCTOBRE   VALUES LESS THAN (TO_DATE ('01/11/2018','DD/MM/YYYY')),
	PARTITION P_VOLNOVEMBRE  VALUES LESS THAN (TO_DATE ('01/12/2018','DD/MM/YYYY')),
	PARTITION P_VOLDECEMBRE  VALUES LESS THAN (MAXVALUE)
)
   TABLESPACE BD50_DATA ;   