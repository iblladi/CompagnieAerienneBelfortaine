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
--       INDEX DE LA TABLE TERMINAL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TERMINAL_AEROPORT
     ON TERMINAL (CODE_AERO ASC)
    
   TABLESPACE BD50_IND ;

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
--       INDEX DE LA TABLE AERO_VILLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_AERO_VILLE_AEROPORT
     ON AERO_VILLE (CODE_AERO ASC)
    
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_AERO_VILLE_VILLE
     ON AERO_VILLE (CP_VILLE ASC)
    
   TABLESPACE BD50_IND ;

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
--       INDEX DE LA TABLE CLASSE_AVION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CLASSE_AVION_AVION
     ON CLASSE_AVION (NUM_AVION ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_CLASSE_AVION_CLASSE
     ON CLASSE_AVION (NUM_CLASS ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSO_VOL
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSO_VOL_PERSONNEL
     ON PERSO_VOL (CODE_PERSON ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PERSO_VOL_VOL_REEL
     ON PERSO_VOL (NUM_VOLCOM ASC, CODE_VOLREEL ASC)
   
   TABLESPACE BD50_IND ;
