-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE UTILISATEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_UTILISATEUR_CATEGORIE
     ON UTILISATEUR (NUM_CATEG ASC)
   
   TABLESPACE BD50_IND ;
   
-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE RESERVATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_RESERVATION_UTILISATEUR
     ON RESERVATION (NUM_USER ASC)
   
   TABLESPACE BD50_IND ;
   
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