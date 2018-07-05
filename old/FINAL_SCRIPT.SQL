-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                        (26/5/2018 13:35:40)
-- -----------------------------------------------------------------------------
--      Nom de la base : SCRIPT_O
--      Projet : Compagnie_Belfortaine_bd50
--      Auteur : BLLADI
--      Date de dernière modification : 26/5/2018 13:34:22
-- -----------------------------------------------------------------------------

DROP TABLE AEROPORT CASCADE CONSTRAINTS;

DROP TABLE CATEGORIE CASCADE CONSTRAINTS;

DROP TABLE UTILISATEUR CASCADE CONSTRAINTS;

DROP TABLE BILLET CASCADE CONSTRAINTS;

DROP TABLE RESERVATION CASCADE CONSTRAINTS;

DROP TABLE VILLE CASCADE CONSTRAINTS;

DROP TABLE PERSONNEL CASCADE CONSTRAINTS;

DROP TABLE AVION CASCADE CONSTRAINTS;

DROP TABLE TERMINAL CASCADE CONSTRAINTS;

DROP TABLE CLASSE CASCADE CONSTRAINTS;

DROP TABLE VOL_COMMERCIAL CASCADE CONSTRAINTS;

DROP TABLE VOL_REEL CASCADE CONSTRAINTS;

DROP TABLE AERO_VILLE CASCADE CONSTRAINTS;

DROP TABLE VOL_RESERV CASCADE CONSTRAINTS;

DROP TABLE CLASSE_AVION CASCADE CONSTRAINTS;

DROP TABLE PERSO_VOL CASCADE CONSTRAINTS;



DROP TABLESPACE BD50_DATA INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

DROP TABLESPACE BD50_IND INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

PURGE RECYCLEBIN;

CREATE TABLESPACE BD50_DATA
	DATAFILE 'E:\ORACLE\ORADATA\PROD\BD50_DATA.dbf' SIZE 50M
    AUTOEXTEND ON
  ;

CREATE TABLESPACE BD50_IND
	DATAFILE 'E:\ORACLE\ORADATA\PROD\BD50_IND.dbf' SIZE 50M
    AUTOEXTEND ON
  ;




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
,   CONSTRAINT PK_AEROPORT PRIMARY KEY (CODE_AERO)  USING INDEX TABLESPACE BD50_IND 
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
,   CONSTRAINT PK_CATEGORIE PRIMARY KEY (NUM_CATEG)  USING INDEX TABLESPACE BD50_IND 
   )
   TABLESPACE BD50_DATA ;

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
,   CONSTRAINT PK_UTILISATEUR PRIMARY KEY (NUM_USER)  USING INDEX TABLESPACE BD50_IND 
   )  
PARTITION BY LIST (TYPE_USER)
(
    PARTITION P_CLIENT VALUES ('C'),
    PARTITION P_PASSAGER VALUES ('P')
) 
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE UTILISATEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_UTILISATEUR_CATEGORIE
     ON UTILISATEUR (NUM_CATEG ASC)
   
   TABLESPACE BD50_IND ;

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
	NUM_SIEGE VARCHAR2(3) NULL,
    PORTE_EMBARQ_BILLET VARCHAR2(4)  NULL,
    NOM_USER VARCHAR2(50)  NULL,
    PRE_USER VARCHAR2(50)  NULL,
    PRESENT_USER NUMBER(1)  NULL
,   CONSTRAINT PK_BILLET PRIMARY KEY (NUM_RESERV, NUM_BILLET)  USING INDEX TABLESPACE BD50_IND 
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE BILLET
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_BILLET_CLASSE
     ON BILLET (NUM_CLASS ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_BILLET_RESERVATION
     ON BILLET (NUM_RESERV ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_BILLET_VOL_REEL
     ON BILLET (NUM_VOLCOM ASC, CODE_VOLREEL ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_BILLET_UTILISATEUR
     ON BILLET (NUM_USER ASC)
   
   TABLESPACE BD50_IND ;

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
,   CONSTRAINT PK_RESERVATION PRIMARY KEY (NUM_RESERV)  USING INDEX TABLESPACE BD50_IND 
   ) 
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
--       INDEX DE LA TABLE RESERVATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_RESERVATION_UTILISATEUR
     ON RESERVATION (NUM_USER ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : VILLE
-- -----------------------------------------------------------------------------

CREATE TABLE VILLE
   (
    CP_VILLE VARCHAR2(8)  NOT NULL,
    NOM_VILLE VARCHAR2(30)  NOT NULL,
    PAYS_VILLE VARCHAR2(30)  NOT NULL
,   CONSTRAINT PK_VILLE PRIMARY KEY (CP_VILLE)  USING INDEX TABLESPACE BD50_IND 
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
,   CONSTRAINT PK_PERSONNEL PRIMARY KEY (CODE_PERSON)  USING INDEX TABLESPACE BD50_IND 
   ) 
PARTITION BY LIST (TYPE_PERSONNEL)
(
    PARTITION P_CLIENT VALUES ('P'),
    PARTITION P_PASSAGER VALUES ('S')
) 
   TABLESPACE BD50_DATA ;


-- -----------------------------------------------------------------------------
--       TABLE : AVION
-- -----------------------------------------------------------------------------

CREATE TABLE AVION
   (
    NUM_AVION NUMBER(6)  NOT NULL,
    NOM_AVION VARCHAR2(20)  NULL,
    CAPAC_AVION NUMBER(3)  NULL,
    DDEB_SERV_AVION VARCHAR2(30)  NULL,
    LOCAL_AVION VARCHAR2(50)  NULL
,   CONSTRAINT PK_AVION PRIMARY KEY (NUM_AVION)  USING INDEX TABLESPACE BD50_IND 
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
,   CONSTRAINT PK_TERMINAL PRIMARY KEY (CODE_AERO, NUM_TERMINAL)  USING INDEX TABLESPACE BD50_IND 
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TERMINAL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TERMINAL_AEROPORT
     ON TERMINAL (CODE_AERO ASC)
    
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : CLASSE
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSE
   (
    NUM_CLASS NUMBER(1)  NOT NULL,
    NOM_CLASS VARCHAR2(30)  NOT NULL,
    REMISE_CLASS NUMBER(2)  NULL
,   CONSTRAINT PK_CLASSE PRIMARY KEY (NUM_CLASS)  USING INDEX TABLESPACE BD50_IND 
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
,   CONSTRAINT PK_VOL_COMMERCIAL PRIMARY KEY (NUM_VOLCOM)  USING INDEX TABLESPACE BD50_IND 
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VOL_COMMERCIAL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VOL_COMMERCIAL_VILLEDEP
     ON VOL_COMMERCIAL (CP_VILLEDEP ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_COMMERCIAL_VILLEARR
     ON VOL_COMMERCIAL (CP_VILLEARR ASC)
    
   TABLESPACE BD50_IND ;

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
,   CONSTRAINT PK_VOL_REEL PRIMARY KEY (NUM_VOLCOM, CODE_VOLREEL)  USING INDEX TABLESPACE BD50_IND
,   CONSTRAINT UNIQUE_VOLREEL UNIQUE (DHDEP_VOLREEL,DHARR_VOLREEL,VILLEDEP_VOLCOM,VILLEARR_VOLCOM)

   )   
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

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VOL_REEL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VOL_REEL_VOL_COMMERCIAL
     ON VOL_REEL (NUM_VOLCOM ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_REEL_AVION
     ON VOL_REEL (NUM_AVION ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_REEL_AEROPORT_DEP
     ON VOL_REEL (CODE_AERO_DEP ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_REEL_AEROPORT_ARR
     ON VOL_REEL (CODE_AERO_ARR ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_REEL_TERMINAL_DEP
     ON VOL_REEL (NUM_TERMINAL_DEP ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_REEL_TERMINAL_ARR
     ON VOL_REEL (NUM_TERMINAL_ARR ASC)
    
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : AERO_VILLE
-- -----------------------------------------------------------------------------

CREATE TABLE AERO_VILLE
   (
    CODE_AERO NUMBER(6)  NOT NULL,
    CP_VILLE VARCHAR2(8)  NOT NULL,
    DISTANCE_AERO_VILLE NUMBER(3)  NULL
,   CONSTRAINT PK_AERO_VILLE PRIMARY KEY (CODE_AERO, CP_VILLE) 
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE AERO_VILLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_AERO_VILLE_AEROPORT
     ON AERO_VILLE (CODE_AERO ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_AERO_VILLE_VILLE
     ON AERO_VILLE (CP_VILLE ASC)
    
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : VOL_RESERV
-- -----------------------------------------------------------------------------

CREATE TABLE VOL_RESERV
   (
    NUM_RESERV NUMBER(10)  NOT NULL,
    NUM_VOLCOM NUMBER(4)  NOT NULL,
    CODE_VOLREEL NUMBER(6)  NOT NULL
,   CONSTRAINT PK_VOL_RESERV PRIMARY KEY (NUM_RESERV, NUM_VOLCOM, CODE_VOLREEL)
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VOL_RESERV
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VOL_RESERV_RESERVATION
     ON VOL_RESERV (NUM_RESERV ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOL_RESERV_VOL_REEL
     ON VOL_RESERV (NUM_VOLCOM ASC, CODE_VOLREEL ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : CLASSE_AVION
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSE_AVION
   (
    NUM_AVION NUMBER(6)  NOT NULL,
    NUM_CLASS NUMBER(1)  NOT NULL
,   CONSTRAINT PK_CLASSE_AVION PRIMARY KEY (NUM_AVION, NUM_CLASS) 
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CLASSE_AVION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CLASSE_AVION_AVION
     ON CLASSE_AVION (NUM_AVION ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_CLASSE_AVION_CLASSE
     ON CLASSE_AVION (NUM_CLASS ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       TABLE : PERSO_VOL
-- -----------------------------------------------------------------------------

CREATE TABLE PERSO_VOL
   (
    CODE_PERSON NUMBER(6)  NOT NULL,
    NUM_VOLCOM NUMBER(4)  NOT NULL,
    CODE_VOLREEL NUMBER(6)  NOT NULL
,   CONSTRAINT PK_PERSO_VOL PRIMARY KEY (CODE_PERSON, NUM_VOLCOM, CODE_VOLREEL) 
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSO_VOL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSO_VOL_PERSONNEL
     ON PERSO_VOL (CODE_PERSON ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PERSO_VOL_VOL_REEL
     ON PERSO_VOL (NUM_VOLCOM ASC, CODE_VOLREEL ASC)
   
   TABLESPACE BD50_IND ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE UTILISATEUR ADD (
     CONSTRAINT FK_UTILISATEUR_CATEGORIE
          FOREIGN KEY (NUM_CATEG)
               REFERENCES CATEGORIE (NUM_CATEG)) ;

ALTER TABLE BILLET ADD (
     CONSTRAINT FK_BILLET_CLASSE
          FOREIGN KEY (NUM_CLASS)
               REFERENCES CLASSE (NUM_CLASS)) ;

ALTER TABLE BILLET ADD (
     CONSTRAINT FK_BILLET_RESERVATION
          FOREIGN KEY (NUM_RESERV)
               REFERENCES RESERVATION (NUM_RESERV) ON DELETE CASCADE);

ALTER TABLE BILLET ADD (
     CONSTRAINT FK_BILLET_VOL_REEL
          FOREIGN KEY (NUM_VOLCOM, CODE_VOLREEL)
               REFERENCES VOL_REEL (NUM_VOLCOM, CODE_VOLREEL));

ALTER TABLE BILLET ADD (
     CONSTRAINT FK_BILLET_UTILISATEUR
          FOREIGN KEY (NUM_USER)
               REFERENCES UTILISATEUR (NUM_USER) ON DELETE CASCADE);

ALTER TABLE RESERVATION ADD (
     CONSTRAINT FK_RESERVATION_UTILISATEUR
          FOREIGN KEY (NUM_USER)
               REFERENCES UTILISATEUR (NUM_USER) ON DELETE CASCADE);

ALTER TABLE TERMINAL ADD (
     CONSTRAINT FK_TERMINAL_AEROPORT
          FOREIGN KEY (CODE_AERO)
               REFERENCES AEROPORT (CODE_AERO))   ;

ALTER TABLE VOL_COMMERCIAL ADD (
     CONSTRAINT FK_VOL_COMMERCIAL_VILLEARR
          FOREIGN KEY (CP_VILLEARR)
               REFERENCES VILLE (CP_VILLE))   ;

ALTER TABLE VOL_COMMERCIAL ADD (
     CONSTRAINT FK_VOL_COMMERCIAL_VILLEDEP
          FOREIGN KEY (CP_VILLEDEP)
               REFERENCES VILLE (CP_VILLE))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_VOL_COMMERCIAL
          FOREIGN KEY (NUM_VOLCOM)
               REFERENCES VOL_COMMERCIAL (NUM_VOLCOM))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_AVION
          FOREIGN KEY (NUM_AVION)
               REFERENCES AVION (NUM_AVION))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_AEROPORT_DEP
          FOREIGN KEY (CODE_AERO_DEP)
               REFERENCES AEROPORT (CODE_AERO))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_AEROPORT_ARR
          FOREIGN KEY (CODE_AERO_ARR)
               REFERENCES AEROPORT (CODE_AERO))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_TERMINAL_DEP
          FOREIGN KEY (NUM_TERMINAL_DEP,CODE_AERO_DEP)
               REFERENCES TERMINAL (NUM_TERMINAL,CODE_AERO))   ;

ALTER TABLE VOL_REEL ADD (
     CONSTRAINT FK_VOL_REEL_TERMINAL_ARR
          FOREIGN KEY (NUM_TERMINAL_ARR,CODE_AERO_ARR)
               REFERENCES TERMINAL (NUM_TERMINAL,CODE_AERO))   ;

ALTER TABLE AERO_VILLE ADD (
     CONSTRAINT FK_AERO_VILLE_AEROPORT
          FOREIGN KEY (CODE_AERO)
               REFERENCES AEROPORT (CODE_AERO)
                    ON DELETE CASCADE
)   ;

ALTER TABLE AERO_VILLE ADD (
     CONSTRAINT FK_AERO_VILLE_VILLE
          FOREIGN KEY (CP_VILLE)
               REFERENCES VILLE (CP_VILLE)
                    ON DELETE CASCADE
)   ;

ALTER TABLE VOL_RESERV ADD (
     CONSTRAINT FK_VOL_RESERV_RESERVATION
          FOREIGN KEY (NUM_RESERV)
               REFERENCES RESERVATION (NUM_RESERV)
                    ON DELETE CASCADE
) ;

ALTER TABLE VOL_RESERV ADD (
     CONSTRAINT FK_VOL_RESERV_VOL_REEL
          FOREIGN KEY (NUM_VOLCOM, CODE_VOLREEL)
               REFERENCES VOL_REEL (NUM_VOLCOM, CODE_VOLREEL)
                    ON DELETE CASCADE
) ;

ALTER TABLE CLASSE_AVION ADD (
     CONSTRAINT FK_CLASSE_AVION_AVION
          FOREIGN KEY (NUM_AVION)
               REFERENCES AVION (NUM_AVION)
                    ON DELETE CASCADE
) ;

ALTER TABLE CLASSE_AVION ADD (
     CONSTRAINT FK_CLASSE_AVION_CLASSE
          FOREIGN KEY (NUM_CLASS)
               REFERENCES CLASSE (NUM_CLASS)
                    ON DELETE CASCADE
) ;

ALTER TABLE PERSO_VOL ADD (
     CONSTRAINT FK_PERSO_VOL_PERSONNEL
          FOREIGN KEY (CODE_PERSON)
               REFERENCES PERSONNEL (CODE_PERSON)
                    ON DELETE CASCADE
) ;

ALTER TABLE PERSO_VOL ADD (
     CONSTRAINT FK_PERSO_VOL_VOL_REEL
          FOREIGN KEY (NUM_VOLCOM, CODE_VOLREEL)
               REFERENCES VOL_REEL (NUM_VOLCOM, CODE_VOLREEL)
                    ON DELETE CASCADE
)  ;



-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------