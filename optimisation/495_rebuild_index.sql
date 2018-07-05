  -- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE UTILISATEUR
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_UTILISATEUR_CATEGORIE REBUILD;
	
-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE BILLET
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_BILLET_CLASSE REBUILD;

ALTER  INDEX I_FK_BILLET_RESERVATION REBUILD;

ALTER  INDEX I_FK_BILLET_VOL_REEL REBUILD;

ALTER  INDEX I_FK_BILLET_UTILISATEUR REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE RESERVATION
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_RESERVATION_UTILISATEUR REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE TERMINAL
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_TERMINAL_AEROPORT REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE VOL_COMMERCIAL
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_VOL_COMMERCIAL_VILLEDEP REBUILD;

ALTER  INDEX I_FK_VOL_COMMERCIAL_VILLEARR REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE VOL_REEL
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_VOL_REEL_VOL_COMMERCIAL REBUILD;

ALTER  INDEX I_FK_VOL_REEL_AVION REBUILD;

ALTER  INDEX I_FK_VOL_REEL_AEROPORT_DEP REBUILD;

ALTER  INDEX I_FK_VOL_REEL_AEROPORT_ARR REBUILD;

ALTER  INDEX I_FK_VOL_REEL_TERMINAL_DEP REBUILD;

ALTER  INDEX I_FK_VOL_REEL_TERMINAL_ARR REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE AERO_VILLE
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_AERO_VILLE_AEROPORT REBUILD;

ALTER  INDEX I_FK_AERO_VILLE_VILLE REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE VOL_RESERV
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_VOL_RESERV_RESERVATION REBUILD;

ALTER  INDEX I_FK_VOL_RESERV_VOL_REEL REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE CLASSE_AVION
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_CLASSE_AVION_AVION REBUILD;

ALTER  INDEX I_FK_CLASSE_AVION_CLASSE REBUILD;

-- -----------------------------------------------------------------------------
--       REBUILD INDEX DE LA TABLE PERSO_VOL
-- -----------------------------------------------------------------------------

ALTER  INDEX I_FK_PERSO_VOL_PERSONNEL REBUILD;

ALTER  INDEX I_FK_PERSO_VOL_VOL_REEL REBUILD;

COMMIT;