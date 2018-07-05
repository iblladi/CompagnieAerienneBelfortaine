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