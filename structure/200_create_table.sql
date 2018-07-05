-- -----------------------------------------------------------------------------
--       TABLE : AEROPORT
-- -----------------------------------------------------------------------------

CREATE TABLE AEROPORT
   (
    CODE_AERO NUMBER(6)  NOT NULL,
    NOM_AERO VARCHAR2(80)  NOT NULL,
    DESC_AERO CLOB  NULL,
    HO_AERO DATE  NULL,
    HF_AERO DATE  NULL 
   )
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------
CREATE TABLE CATEGORIE
   (
    NUM_CATEG NUMBER(1)  NOT NULL,
    CATEG_PASG VARCHAR2(10)  NULL,
    REMISE_CATEG NUMBER(2)  NULL
   )
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : BILLET
-- -----------------------------------------------------------------------------

CREATE TABLE BILLET
   (
    NUM_RESERV NUMBER(10)  NOT NULL,
    NUM_BILLET VARCHAR2(20)  NOT NULL,
    NUM_CLASS NUMBER(1)  NOT NULL,
    NUM_VOLCOM NUMBER(4)  NOT NULL,
    CODE_VOLREEL NUMBER(6)  NOT NULL,
    NUM_USER NUMBER(6)  NOT NULL,
    PRIX_BILLET NUMBER(13,2)  NOT NULL,
    PORTE_EMBARQ_BILLET VARCHAR2(4)  NULL,
    NOM_USER VARCHAR2(50)  NULL,
    PRE_USER VARCHAR2(50)  NULL,
    PRESENT_USER NUMBER(1)  NULL
   )
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : VILLE
-- -----------------------------------------------------------------------------

CREATE TABLE VILLE
   (
    CP_VILLE VARCHAR2(8)  NOT NULL,
    NOM_VILLE VARCHAR2(30)  NOT NULL,
    PAYS_VILLE VARCHAR2(30)  NOT NULL
   )
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : TERMINAL
-- -----------------------------------------------------------------------------

CREATE TABLE TERMINAL
   (
    CODE_AERO NUMBER(6)  NOT NULL,
    NUM_TERMINAL NUMBER(1)  NOT NULL,
    NOM_TERMINAL VARCHAR2(30)  NULL
   )
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : CLASSE
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSE
   (
    NUM_CLASS NUMBER(1)  NOT NULL,
    NOM_CLASS VARCHAR2(30)  NOT NULL,
    REMISE_CLASS NUMBER(2)  NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : VOL_COMMERCIAL
-- -----------------------------------------------------------------------------

CREATE TABLE VOL_COMMERCIAL
   (
    NUM_VOLCOM NUMBER(4)  NOT NULL,
    CP_VILLEDEP VARCHAR2(8)  NOT NULL,
    VILLEDEP_VOLCOM VARCHAR2(20)  NOT NULL,
    CP_VILLEARR VARCHAR2(8)  NOT NULL,
    VILLEARR_VOLCOM VARCHAR2(20)  NOT NULL,
    HRDEP_VOLCOM DATE  NULL,
    HRARR_VOLCOM DATE  NULL,
    J1 NUMBER(1)  NULL,
    J2 NUMBER(1)  NULL,
    J3 NUMBER(1)  NULL,
    J4 NUMBER(1)  NULL,
    J5 NUMBER(1)  NULL,
    J6 NUMBER(1)  NULL,
    J7 NUMBER(1)  NULL
   )
   TABLESPACE BD50_DATA ;
