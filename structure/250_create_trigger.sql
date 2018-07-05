-- ------------------------------------------------------------------------------- 
--   Génération des triggers de la base 
--   de données : Modèle_é
--   (28/5/2018 17:59:17)
-- ------------------------------------------------------------------------------- 

-- ------------------------------------------------------------------------------- 
--   Table : AEROPORT
-- ------------------------------------------------------------------------------- 

drop trigger TD_AEROPORT;

-- Trigger de suppression ----------------------------------------------
create trigger TD_AEROPORT
after delete on AEROPORT for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table AERO_VILLE.

     delete from AERO_VILLE
     where
          AERO_VILLE.CODE_AERO = :old.CODE_AERO;
     -- Interdire la suppression d'une occurrence de AEROPORT s'il existe des
     -- occurrences correspondantes de la table TERMINAL.

     select count(*) into numrows
     from TERMINAL
     where
          TERMINAL.CODE_AERO = :old.CODE_AERO;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "AEROPORT". Des occurrences de "TERMINAL" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de AEROPORT s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.CODE_AERO_DEP = :old.CODE_AERO;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "AEROPORT". Des occurrences de "VOL_REEL" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de AEROPORT s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.CODE_AERO_ARR = :old.CODE_AERO;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "AEROPORT". Des occurrences de "VOL_REEL" existent.');
     end if;

end;
/

drop trigger TU_AEROPORT;

-- Trigger de modification ----------------------------------------------
create trigger TU_AEROPORT
after update on AEROPORT for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de AEROPORT sur les 
     -- occurrences correspondantes de la table AERO_VILLE.

     if
          :old.CODE_AERO <> :new.CODE_AERO
     then
          update AERO_VILLE
          set
               AERO_VILLE.CODE_AERO = :new.CODE_AERO
          where
               AERO_VILLE.CODE_AERO = :old.CODE_AERO;
     end if;
     -- Répercuter la modification de la clé primaire de AEROPORT sur les 
     -- occurrences correspondantes de la table TERMINAL.

     if
          :old.CODE_AERO <> :new.CODE_AERO
     then
          update TERMINAL
          set
               TERMINAL.CODE_AERO = :new.CODE_AERO
          where
               TERMINAL.CODE_AERO = :old.CODE_AERO;
     end if;
     -- Répercuter la modification de la clé primaire de AEROPORT sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.CODE_AERO <> :new.CODE_AERO
     then
          update VOL_REEL
          set
               VOL_REEL.CODE_AERO_DEP = :new.CODE_AERO
          where
               VOL_REEL.CODE_AERO_DEP = :old.CODE_AERO;
     end if;
     -- Répercuter la modification de la clé primaire de AEROPORT sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.CODE_AERO <> :new.CODE_AERO
     then
          update VOL_REEL
          set
               VOL_REEL.CODE_AERO_ARR = :new.CODE_AERO
          where
               VOL_REEL.CODE_AERO_ARR = :old.CODE_AERO;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CATEGORIE
-- ------------------------------------------------------------------------------- 

drop trigger TD_CATEGORIE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_CATEGORIE
after delete on CATEGORIE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de CATEGORIE s'il existe des
     -- occurrences correspondantes de la table UTILISATEUR.

     select count(*) into numrows
     from UTILISATEUR
     where
          UTILISATEUR.NUM_CATEG = :old.NUM_CATEG;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CATEGORIE". Des occurrences de "UTILISATEUR" existent.');
     end if;

end;
/

drop trigger TU_CATEGORIE;

-- Trigger de modification ----------------------------------------------
create trigger TU_CATEGORIE
after update on CATEGORIE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de CATEGORIE sur les 
     -- occurrences correspondantes de la table UTILISATEUR.

     if
          :old.NUM_CATEG <> :new.NUM_CATEG
     then
          update UTILISATEUR
          set
               UTILISATEUR.NUM_CATEG = :new.NUM_CATEG
          where
               UTILISATEUR.NUM_CATEG = :old.NUM_CATEG;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : UTILISATEUR
-- ------------------------------------------------------------------------------- 

drop trigger TD_UTILISATEUR;


drop trigger TU_UTILISATEUR;

-- Trigger de modification ----------------------------------------------
create trigger TU_UTILISATEUR
after update on UTILISATEUR for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table UTILISATEUR s'il n'existe pas d'occurrence correspondante de la 
     -- table CATEGORIE.

     if
          :old.NUM_USER <> :new.NUM_USER
     then
          select count(*) into numrows
          from CATEGORIE
          where
               :new.NUM_CATEG = CATEGORIE.NUM_CATEG;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "UTILISATEUR" car "CATEGORIE" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de UTILISATEUR sur les 
     -- occurrences correspondantes de la table BILLET.

     if
          :old.NUM_USER <> :new.NUM_USER
     then
          update BILLET
          set
               BILLET.NUM_USER = :new.NUM_USER
          where
               BILLET.NUM_USER = :old.NUM_USER;
     end if;
     -- Répercuter la modification de la clé primaire de UTILISATEUR sur les 
     -- occurrences correspondantes de la table RESERVATION.

     if
          :old.NUM_USER <> :new.NUM_USER
     then
          update RESERVATION
          set
               RESERVATION.NUM_USER = :new.NUM_USER
          where
               RESERVATION.NUM_USER = :old.NUM_USER;
     end if;

end;
/

drop trigger TI_UTILISATEUR;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_UTILISATEUR
after insert on UTILISATEUR for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de UTILISATEUR 
     -- s'il n'existe pas d'occurrence correspondante dans la table CATEGORIE.

     select count(*) into numrows
     from CATEGORIE
     where
          :new.NUM_CATEG = CATEGORIE.NUM_CATEG;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "UTILISATEUR" car "CATEGORIE" n''existe pas.');
     end if;

end;
/

drop trigger TBI_USER;

create or replace trigger TBI_USER
before insert on UTILISATEUR for each row
when (new.NUM_USER IS NULL)
begin
    SELECT SEQ_USER.NEXTVAL 
     INTO :new.NUM_USER
     FROM dual;
end;
/


-- ------------------------------------------------------------------------------- 
--   Table : BILLET
-- ------------------------------------------------------------------------------- 

drop trigger TU_BILLET;

-- Trigger de modification ----------------------------------------------
create trigger TU_BILLET
after update on BILLET for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table BILLET s'il n'existe pas d'occurrence correspondante de la 
     -- table CLASSE.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_BILLET <> :new.NUM_BILLET
     then
          select count(*) into numrows
          from CLASSE
          where
               :new.NUM_CLASS = CLASSE.NUM_CLASS;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "BILLET" car "CLASSE" n''existe pas.');
          end if;
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- RESERVATION.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_BILLET <> :new.NUM_BILLET
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "RESERVATION" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table BILLET s'il n'existe pas d'occurrence correspondante de la 
     -- table VOL_REEL.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_BILLET <> :new.NUM_BILLET
     then
          select count(*) into numrows
          from VOL_REEL
          where
               :new.NUM_VOLCOM = VOL_REEL.NUM_VOLCOM and
               :new.CODE_VOLREEL = VOL_REEL.CODE_VOLREEL;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "BILLET" car "VOL_REEL" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table BILLET s'il n'existe pas d'occurrence correspondante de la 
     -- table UTILISATEUR.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_BILLET <> :new.NUM_BILLET
     then
          select count(*) into numrows
          from UTILISATEUR
          where
               :new.NUM_USER = UTILISATEUR.NUM_USER;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "BILLET" car "UTILISATEUR" n''existe pas.');
          end if;
     end if;

end;
/

drop trigger TI_BILLET;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_BILLET
after insert on BILLET for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de BILLET 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLASSE.

     select count(*) into numrows
     from CLASSE
     where
          :new.NUM_CLASS = CLASSE.NUM_CLASS;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "BILLET" car "CLASSE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de BILLET 
     -- s'il n'existe pas d'occurrence correspondante dans la table RESERVATION.

     select count(*) into numrows
     from RESERVATION
     where
          :new.NUM_RESERV = RESERVATION.NUM_RESERV;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "BILLET" car "RESERVATION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de BILLET 
     -- s'il n'existe pas d'occurrence correspondante dans la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          :new.NUM_VOLCOM = VOL_REEL.NUM_VOLCOM and
          :new.CODE_VOLREEL = VOL_REEL.CODE_VOLREEL;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "BILLET" car "VOL_REEL" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de BILLET 
     -- s'il n'existe pas d'occurrence correspondante dans la table UTILISATEUR.

     select count(*) into numrows
     from UTILISATEUR
     where
          :new.NUM_USER = UTILISATEUR.NUM_USER;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "BILLET" car "UTILISATEUR" n''existe pas.');
     end if;

end;
/


drop trigger TBI_BILLET;

create or replace trigger TBI_BILLET
before insert on BILLET for each row
when (new.NUM_BILLET IS NULL)
begin
    SELECT SEQ_BILLET.NEXTVAL 
     INTO :new.NUM_BILLET
     FROM dual;
end;
/

-- ------------------------------------------------------------------------------- 
--   Table : RESERVATION
-- ------------------------------------------------------------------------------- 

drop trigger TD_RESERVATION;


drop trigger TU_RESERVATION;

-- Trigger de modification ----------------------------------------------
create trigger TU_RESERVATION
after update on RESERVATION for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table RESERVATION s'il n'existe pas d'occurrence correspondante de la 
     -- table UTILISATEUR.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV
     then
          select count(*) into numrows
          from UTILISATEUR
          where
               :new.NUM_USER = UTILISATEUR.NUM_USER;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "RESERVATION" car "UTILISATEUR" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de RESERVATION sur les 
     -- occurrences correspondantes de la table VOL_RESERV.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV
     then
          update VOL_RESERV
          set
               VOL_RESERV.NUM_RESERV = :new.NUM_RESERV
          where
               VOL_RESERV.NUM_RESERV = :old.NUM_RESERV;
     end if;
     -- Répercuter la modification de la clé primaire de RESERVATION sur les 
     -- occurrences correspondantes de la table BILLET.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV
     then
          update BILLET
          set
               BILLET.NUM_RESERV = :new.NUM_RESERV
          where
               BILLET.NUM_RESERV = :old.NUM_RESERV;
     end if;

end;
/

drop trigger TI_RESERVATION;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_RESERVATION
after insert on RESERVATION for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de RESERVATION 
     -- s'il n'existe pas d'occurrence correspondante dans la table UTILISATEUR.

     select count(*) into numrows
     from UTILISATEUR
     where
          :new.NUM_USER = UTILISATEUR.NUM_USER;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "RESERVATION" car "UTILISATEUR" n''existe pas.');
     end if;

end;
/

drop trigger TBI_RESERVATION;

create or replace trigger TBI_RESERVATION
before insert on RESERVATION for each row
when (new.NUM_RESERV IS NULL)
begin
    SELECT SEQ_RESERV.NEXTVAL 
     INTO :new.NUM_RESERV
     FROM dual;
end;
/


-- ------------------------------------------------------------------------------- 
--   Table : VILLE
-- ------------------------------------------------------------------------------- 

drop trigger TD_VILLE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_VILLE
after delete on VILLE for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table AERO_VILLE.

     delete from AERO_VILLE
     where
          AERO_VILLE.CP_VILLE = :old.CP_VILLE;
     -- Interdire la suppression d'une occurrence de VILLE s'il existe des
     -- occurrences correspondantes de la table VOL_COMMERCIAL.

     select count(*) into numrows
     from VOL_COMMERCIAL
     where
          VOL_COMMERCIAL.CP_VILLEARR = :old.CP_VILLE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "VILLE". Des occurrences de "VOL_COMMERCIAL" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de VILLE s'il existe des
     -- occurrences correspondantes de la table VOL_COMMERCIAL.

     select count(*) into numrows
     from VOL_COMMERCIAL
     where
          VOL_COMMERCIAL.CP_VILLEDEP = :old.CP_VILLE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "VILLE". Des occurrences de "VOL_COMMERCIAL" existent.');
     end if;

end;
/

drop trigger TU_VILLE;

-- Trigger de modification ----------------------------------------------
create trigger TU_VILLE
after update on VILLE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de VILLE sur les 
     -- occurrences correspondantes de la table AERO_VILLE.

     if
          :old.CP_VILLE <> :new.CP_VILLE
     then
          update AERO_VILLE
          set
               AERO_VILLE.CP_VILLE = :new.CP_VILLE
          where
               AERO_VILLE.CP_VILLE = :old.CP_VILLE;
     end if;
     -- Répercuter la modification de la clé primaire de VILLE sur les 
     -- occurrences correspondantes de la table VOL_COMMERCIAL.

     if
          :old.CP_VILLE <> :new.CP_VILLE
     then
          update VOL_COMMERCIAL
          set
               VOL_COMMERCIAL.CP_VILLEARR = :new.CP_VILLE
          where
               VOL_COMMERCIAL.CP_VILLEARR = :old.CP_VILLE;
     end if;
     -- Répercuter la modification de la clé primaire de VILLE sur les 
     -- occurrences correspondantes de la table VOL_COMMERCIAL.

     if
          :old.CP_VILLE <> :new.CP_VILLE
     then
          update VOL_COMMERCIAL
          set
               VOL_COMMERCIAL.CP_VILLEDEP = :new.CP_VILLE
          where
               VOL_COMMERCIAL.CP_VILLEDEP = :old.CP_VILLE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PERSONNEL
-- ------------------------------------------------------------------------------- 

drop trigger TD_PERSONNEL;

-- Trigger de suppression ----------------------------------------------
create trigger TD_PERSONNEL
after delete on PERSONNEL for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table PERSO_VOL.

     delete from PERSO_VOL
     where
          PERSO_VOL.CODE_PERSON = :old.CODE_PERSON;

end;
/

drop trigger TU_PERSONNEL;

-- Trigger de modification ----------------------------------------------
create trigger TU_PERSONNEL
after update on PERSONNEL for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de PERSONNEL sur les 
     -- occurrences correspondantes de la table PERSO_VOL.

     if
          :old.CODE_PERSON <> :new.CODE_PERSON
     then
          update PERSO_VOL
          set
               PERSO_VOL.CODE_PERSON = :new.CODE_PERSON
          where
               PERSO_VOL.CODE_PERSON = :old.CODE_PERSON;
     end if;

end;
/


-- Trigger d'insertion ----------------------------------------------

drop trigger TBI_PERSONNEL;

create or replace trigger TBI_PERSONNEL
before insert on PERSONNEL for each row
when (new.CODE_PERSON IS NULL)
begin
    SELECT SEQ_PERSON.NEXTVAL 
     INTO :new.CODE_PERSON
     FROM dual;
end;
/

-- ------------------------------------------------------------------------------- 
--   Table : AVION
-- ------------------------------------------------------------------------------- 

drop trigger TD_AVION;

-- Trigger de suppression ----------------------------------------------
create trigger TD_AVION
after delete on AVION for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table CLASSE_AVION.

     delete from CLASSE_AVION
     where
          CLASSE_AVION.NUM_AVION = :old.NUM_AVION;
     -- Interdire la suppression d'une occurrence de AVION s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.NUM_AVION = :old.NUM_AVION;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "AVION". Des occurrences de "VOL_REEL" existent.');
     end if;

end;
/

drop trigger TU_AVION;

-- Trigger de modification ----------------------------------------------
create trigger TU_AVION
after update on AVION for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de AVION sur les 
     -- occurrences correspondantes de la table CLASSE_AVION.

     if
          :old.NUM_AVION <> :new.NUM_AVION
     then
          update CLASSE_AVION
          set
               CLASSE_AVION.NUM_AVION = :new.NUM_AVION
          where
               CLASSE_AVION.NUM_AVION = :old.NUM_AVION;
     end if;
     -- Répercuter la modification de la clé primaire de AVION sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.NUM_AVION <> :new.NUM_AVION
     then
          update VOL_REEL
          set
               VOL_REEL.NUM_AVION = :new.NUM_AVION
          where
               VOL_REEL.NUM_AVION = :old.NUM_AVION;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TERMINAL
-- ------------------------------------------------------------------------------- 

drop trigger TD_TERMINAL;

-- Trigger de suppression ----------------------------------------------
create trigger TD_TERMINAL
after delete on TERMINAL for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de TERMINAL s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.NUM_TERMINAL_DEP = :old.NUM_TERMINAL;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "TERMINAL". Des occurrences de "VOL_REEL" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de TERMINAL s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.NUM_TERMINAL_ARR = :old.NUM_TERMINAL;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "TERMINAL". Des occurrences de "VOL_REEL" existent.');
     end if;

end;
/

drop trigger TU_TERMINAL;

-- Trigger de modification ----------------------------------------------
create trigger TU_TERMINAL
after update on TERMINAL for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- AEROPORT.

     if
          :old.CODE_AERO <> :new.CODE_AERO or 
          :old.NUM_TERMINAL <> :new.NUM_TERMINAL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "AEROPORT" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de TERMINAL sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.CODE_AERO <> :new.CODE_AERO or 
          :old.NUM_TERMINAL <> :new.NUM_TERMINAL
     then
          update VOL_REEL
          set
               VOL_REEL.NUM_TERMINAL_DEP = :new.NUM_TERMINAL
          where
               VOL_REEL.NUM_TERMINAL_DEP = :old.NUM_TERMINAL;
     end if;
     -- Répercuter la modification de la clé primaire de TERMINAL sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.CODE_AERO <> :new.CODE_AERO or 
          :old.NUM_TERMINAL <> :new.NUM_TERMINAL
     then
          update VOL_REEL
          set
               VOL_REEL.NUM_TERMINAL_ARR = :new.NUM_TERMINAL
          where
               VOL_REEL.NUM_TERMINAL_ARR = :old.NUM_TERMINAL;
     end if;

end;
/

drop trigger TI_TERMINAL;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_TERMINAL
after insert on TERMINAL for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de TERMINAL 
     -- s'il n'existe pas d'occurrence correspondante dans la table AEROPORT.

     select count(*) into numrows
     from AEROPORT
     where
          :new.CODE_AERO = AEROPORT.CODE_AERO;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "TERMINAL" car "AEROPORT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CLASSE
-- ------------------------------------------------------------------------------- 

drop trigger TD_CLASSE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_CLASSE
after delete on CLASSE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de CLASSE s'il existe des
     -- occurrences correspondantes de la table BILLET.

     select count(*) into numrows
     from BILLET
     where
          BILLET.NUM_CLASS = :old.NUM_CLASS;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CLASSE". Des occurrences de "BILLET" existent.');
     end if;
     -- Supprimer les occurrences correspondantes de la table CLASSE_AVION.

     delete from CLASSE_AVION
     where
          CLASSE_AVION.NUM_CLASS = :old.NUM_CLASS;

end;
/

drop trigger TU_CLASSE;

-- Trigger de modification ----------------------------------------------
create trigger TU_CLASSE
after update on CLASSE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de CLASSE sur les 
     -- occurrences correspondantes de la table BILLET.

     if
          :old.NUM_CLASS <> :new.NUM_CLASS
     then
          update BILLET
          set
               BILLET.NUM_CLASS = :new.NUM_CLASS
          where
               BILLET.NUM_CLASS = :old.NUM_CLASS;
     end if;
     -- Répercuter la modification de la clé primaire de CLASSE sur les 
     -- occurrences correspondantes de la table CLASSE_AVION.

     if
          :old.NUM_CLASS <> :new.NUM_CLASS
     then
          update CLASSE_AVION
          set
               CLASSE_AVION.NUM_CLASS = :new.NUM_CLASS
          where
               CLASSE_AVION.NUM_CLASS = :old.NUM_CLASS;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VOL_COMMERCIAL
-- ------------------------------------------------------------------------------- 

drop trigger TD_VOL_COMMERCIAL;

-- Trigger de suppression ----------------------------------------------
create trigger TD_VOL_COMMERCIAL
after delete on VOL_COMMERCIAL for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de VOL_COMMERCIAL s'il existe des
     -- occurrences correspondantes de la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          VOL_REEL.NUM_VOLCOM = :old.NUM_VOLCOM;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "VOL_COMMERCIAL". Des occurrences de "VOL_REEL" existent.');
     end if;

end;
/

drop trigger TU_VOL_COMMERCIAL;

-- Trigger de modification ----------------------------------------------
create trigger TU_VOL_COMMERCIAL
after update on VOL_COMMERCIAL for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_COMMERCIAL s'il n'existe pas d'occurrence correspondante de la 
     -- table VILLE.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM
     then
          select count(*) into numrows
          from VILLE
          where
               :new.CP_VILLEARR = VILLE.CP_VILLE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_COMMERCIAL" car "VILLE" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_COMMERCIAL s'il n'existe pas d'occurrence correspondante de la 
     -- table VILLE.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM
     then
          select count(*) into numrows
          from VILLE
          where
               :new.CP_VILLEDEP = VILLE.CP_VILLE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_COMMERCIAL" car "VILLE" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de VOL_COMMERCIAL sur les 
     -- occurrences correspondantes de la table VOL_REEL.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM
     then
          update VOL_REEL
          set
               VOL_REEL.NUM_VOLCOM = :new.NUM_VOLCOM
          where
               VOL_REEL.NUM_VOLCOM = :old.NUM_VOLCOM;
     end if;

end;
/

drop trigger TI_VOL_COMMERCIAL;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_VOL_COMMERCIAL
after insert on VOL_COMMERCIAL for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_COMMERCIAL 
     -- s'il n'existe pas d'occurrence correspondante dans la table VILLE.

     select count(*) into numrows
     from VILLE
     where
          :new.CP_VILLEARR = VILLE.CP_VILLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_COMMERCIAL" car "VILLE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_COMMERCIAL 
     -- s'il n'existe pas d'occurrence correspondante dans la table VILLE.

     select count(*) into numrows
     from VILLE
     where
          :new.CP_VILLEDEP = VILLE.CP_VILLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_COMMERCIAL" car "VILLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VOL_REEL
-- ------------------------------------------------------------------------------- 

drop trigger TD_VOL_REEL;

-- Trigger de suppression ----------------------------------------------
create trigger TD_VOL_REEL
after delete on VOL_REEL for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table VOL_RESERV.

     delete from VOL_RESERV
     where
          VOL_RESERV.NUM_VOLCOM = :old.NUM_VOLCOM and
          VOL_RESERV.CODE_VOLREEL = :old.CODE_VOLREEL;
     -- Interdire la suppression d'une occurrence de VOL_REEL s'il existe des
     -- occurrences correspondantes de la table BILLET.

     select count(*) into numrows
     from BILLET
     where
          BILLET.NUM_VOLCOM = :old.NUM_VOLCOM and
          BILLET.CODE_VOLREEL = :old.CODE_VOLREEL;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "VOL_REEL". Des occurrences de "BILLET" existent.');
     end if;
     -- Supprimer les occurrences correspondantes de la table PERSO_VOL.

     delete from PERSO_VOL
     where
          PERSO_VOL.NUM_VOLCOM = :old.NUM_VOLCOM and
          PERSO_VOL.CODE_VOLREEL = :old.CODE_VOLREEL;

end;
/

drop trigger TU_VOL_REEL;

-- Trigger de modification ----------------------------------------------
create trigger TU_VOL_REEL
after update on VOL_REEL for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- VOL_COMMERCIAL.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VOL_COMMERCIAL" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_REEL s'il n'existe pas d'occurrence correspondante de la 
     -- table AVION.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          select count(*) into numrows
          from AVION
          where
               :new.NUM_AVION = AVION.NUM_AVION;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_REEL" car "AVION" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_REEL s'il n'existe pas d'occurrence correspondante de la 
     -- table AEROPORT.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          select count(*) into numrows
          from AEROPORT
          where
               :new.CODE_AERO_DEP = AEROPORT.CODE_AERO;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_REEL" car "AEROPORT" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_REEL s'il n'existe pas d'occurrence correspondante de la 
     -- table AEROPORT.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          select count(*) into numrows
          from AEROPORT
          where
               :new.CODE_AERO_ARR = AEROPORT.CODE_AERO;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_REEL" car "AEROPORT" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_REEL s'il n'existe pas d'occurrence correspondante de la 
     -- table TERMINAL.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          select count(*) into numrows
          from TERMINAL
          where
               :new.NUM_TERMINAL_DEP = TERMINAL.NUM_TERMINAL;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_REEL" car "TERMINAL" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOL_REEL s'il n'existe pas d'occurrence correspondante de la 
     -- table TERMINAL.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          select count(*) into numrows
          from TERMINAL
          where
               :new.NUM_TERMINAL_ARR = TERMINAL.NUM_TERMINAL;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOL_REEL" car "TERMINAL" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de VOL_REEL sur les 
     -- occurrences correspondantes de la table VOL_RESERV.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          update VOL_RESERV
          set
               VOL_RESERV.NUM_VOLCOM = :new.NUM_VOLCOM,
               VOL_RESERV.CODE_VOLREEL = :new.CODE_VOLREEL
          where
               VOL_RESERV.NUM_VOLCOM = :old.NUM_VOLCOM and
               VOL_RESERV.CODE_VOLREEL = :old.CODE_VOLREEL;
     end if;
     -- Répercuter la modification de la clé primaire de VOL_REEL sur les 
     -- occurrences correspondantes de la table BILLET.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          update BILLET
          set
               BILLET.NUM_VOLCOM = :new.NUM_VOLCOM,
               BILLET.CODE_VOLREEL = :new.CODE_VOLREEL
          where
               BILLET.NUM_VOLCOM = :old.NUM_VOLCOM and
               BILLET.CODE_VOLREEL = :old.CODE_VOLREEL;
     end if;
     -- Répercuter la modification de la clé primaire de VOL_REEL sur les 
     -- occurrences correspondantes de la table PERSO_VOL.

     if
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
          update PERSO_VOL
          set
               PERSO_VOL.NUM_VOLCOM = :new.NUM_VOLCOM,
               PERSO_VOL.CODE_VOLREEL = :new.CODE_VOLREEL
          where
               PERSO_VOL.NUM_VOLCOM = :old.NUM_VOLCOM and
               PERSO_VOL.CODE_VOLREEL = :old.CODE_VOLREEL;
     end if;

end;
/

drop trigger TI_VOL_REEL;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_VOL_REEL
after insert on VOL_REEL for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table VOL_COMMERCIAL.

     select count(*) into numrows
     from VOL_COMMERCIAL
     where
          :new.NUM_VOLCOM = VOL_COMMERCIAL.NUM_VOLCOM;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "VOL_COMMERCIAL" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table AVION.

     select count(*) into numrows
     from AVION
     where
          :new.NUM_AVION = AVION.NUM_AVION;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "AVION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table AEROPORT.

     select count(*) into numrows
     from AEROPORT
     where
          :new.CODE_AERO_DEP = AEROPORT.CODE_AERO;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "AEROPORT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table AEROPORT.

     select count(*) into numrows
     from AEROPORT
     where
          :new.CODE_AERO_ARR = AEROPORT.CODE_AERO;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "AEROPORT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table TERMINAL.

     select count(*) into numrows
     from TERMINAL
     where
          :new.NUM_TERMINAL_DEP = TERMINAL.NUM_TERMINAL;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "TERMINAL" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOL_REEL 
     -- s'il n'existe pas d'occurrence correspondante dans la table TERMINAL.

     select count(*) into numrows
     from TERMINAL
     where
          :new.NUM_TERMINAL_ARR = TERMINAL.NUM_TERMINAL;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOL_REEL" car "TERMINAL" n''existe pas.');
     end if;

end;
/


drop trigger TBI_VOL_REEL;

create or replace trigger TBI_VOL_REEL
before insert on VOL_REEL for each row
when (new.CODE_VOLREEL IS NULL)
begin
    SELECT SEQ_VOLREEL.NEXTVAL 
     INTO :new.CODE_VOLREEL
     FROM dual;
end;
/
-- ------------------------------------------------------------------------------- 
--   Table : AERO_VILLE
-- ------------------------------------------------------------------------------- 

drop trigger TU_AERO_VILLE;

-- Trigger de modification ----------------------------------------------
create trigger TU_AERO_VILLE
after update on AERO_VILLE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- AEROPORT.

     if
          :old.CODE_AERO <> :new.CODE_AERO or 
          :old.CP_VILLE <> :new.CP_VILLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "AEROPORT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- VILLE.

     if
          :old.CODE_AERO <> :new.CODE_AERO or 
          :old.CP_VILLE <> :new.CP_VILLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VILLE" interdite.');
     end if;

end;
/

drop trigger TI_AERO_VILLE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_AERO_VILLE
after insert on AERO_VILLE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de AERO_VILLE 
     -- s'il n'existe pas d'occurrence correspondante dans la table AEROPORT.

     select count(*) into numrows
     from AEROPORT
     where
          :new.CODE_AERO = AEROPORT.CODE_AERO;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "AERO_VILLE" car "AEROPORT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de AERO_VILLE 
     -- s'il n'existe pas d'occurrence correspondante dans la table VILLE.

     select count(*) into numrows
     from VILLE
     where
          :new.CP_VILLE = VILLE.CP_VILLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "AERO_VILLE" car "VILLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VOL_RESERV
-- ------------------------------------------------------------------------------- 

drop trigger TU_VOL_RESERV;

-- Trigger de modification ----------------------------------------------
create trigger TU_VOL_RESERV
after update on VOL_RESERV for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- RESERVATION.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "RESERVATION" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- VOL_REEL.

     if
          :old.NUM_RESERV <> :new.NUM_RESERV or 
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VOL_REEL" interdite.');
     end if;

end;
/

drop trigger TI_VOL_RESERV;





-- ------------------------------------------------------------------------------- 
--   Table : CLASSE_AVION
-- ------------------------------------------------------------------------------- 

drop trigger TU_CLASSE_AVION;

-- Trigger de modification ----------------------------------------------
create trigger TU_CLASSE_AVION
after update on CLASSE_AVION for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- AVION.

     if
          :old.NUM_AVION <> :new.NUM_AVION or 
          :old.NUM_CLASS <> :new.NUM_CLASS
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "AVION" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLASSE.

     if
          :old.NUM_AVION <> :new.NUM_AVION or 
          :old.NUM_CLASS <> :new.NUM_CLASS
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLASSE" interdite.');
     end if;

end;
/

drop trigger TI_CLASSE_AVION;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_CLASSE_AVION
after insert on CLASSE_AVION for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de CLASSE_AVION 
     -- s'il n'existe pas d'occurrence correspondante dans la table AVION.

     select count(*) into numrows
     from AVION
     where
          :new.NUM_AVION = AVION.NUM_AVION;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "CLASSE_AVION" car "AVION" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de CLASSE_AVION 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLASSE.

     select count(*) into numrows
     from CLASSE
     where
          :new.NUM_CLASS = CLASSE.NUM_CLASS;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "CLASSE_AVION" car "CLASSE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PERSO_VOL
-- ------------------------------------------------------------------------------- 

drop trigger TU_PERSO_VOL;

-- Trigger de modification ----------------------------------------------
create trigger TU_PERSO_VOL
after update on PERSO_VOL for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- PERSONNEL.

     if
          :old.CODE_PERSON <> :new.CODE_PERSON or 
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "PERSONNEL" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- VOL_REEL.

     if
          :old.CODE_PERSON <> :new.CODE_PERSON or 
          :old.NUM_VOLCOM <> :new.NUM_VOLCOM or 
          :old.CODE_VOLREEL <> :new.CODE_VOLREEL
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VOL_REEL" interdite.');
     end if;

end;
/

drop trigger TI_PERSO_VOL;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_PERSO_VOL
after insert on PERSO_VOL for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PERSO_VOL 
     -- s'il n'existe pas d'occurrence correspondante dans la table PERSONNEL.

     select count(*) into numrows
     from PERSONNEL
     where
          :new.CODE_PERSON = PERSONNEL.CODE_PERSON;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PERSO_VOL" car "PERSONNEL" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PERSO_VOL 
     -- s'il n'existe pas d'occurrence correspondante dans la table VOL_REEL.

     select count(*) into numrows
     from VOL_REEL
     where
          :new.NUM_VOLCOM = VOL_REEL.NUM_VOLCOM and
          :new.CODE_VOLREEL = VOL_REEL.CODE_VOLREEL;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PERSO_VOL" car "VOL_REEL" n''existe pas.');
     end if;

end;
/



------------------------Trigger champ calculé----------------------------------
--CUMUL_HRVOL_PERSON CHAMP CALCULE
create or replace
TRIGGER TI_PERSO_VOL
AFTER INSERT ON PERSO_VOL 
FOR EACH ROW
DECLARE
     HR_VOL NUMBER;
     v_CUMUL_HRVOL_PERSON NUMBER(3);
BEGIN
     --SELECTIONNER L'HEURE DE VOL
     SELECT DUREE_VOL INTO HR_VOL  
     FROM VOL_REEL
     WHERE CODE_VOLREEL = :NEW.CODE_VOLREEL;
     --SELECTIONNER L'ANCIEN CUMUL D'HEURES DU PERSONNEL
     SELECT CUMUL_HRVOL_PERSON INTO v_CUMUL_HRVOL_PERSON
     FROM PERSONNEL
     WHERE CODE_PERSON = :NEW.CODE_PERSON;
     --METTRE A JOUR LA VALEUR D'HEURES CUMULEES DANS LA TABLE PERSONNEL
     --APRES SON AFFECTATION A UN VOL REEL
     UPDATE PERSONNEL
     SET CUMUL_HRVOL_PERSON = v_CUMUL_HRVOL_PERSON + HR_VOL
     WHERE CODE_PERSON = :NEW.CODE_PERSON;
END;
/

--RETARD_VOLREEL CHAMP CALCULE
create or replace
TRIGGER TBI_VOL_REEL_RETARD
BEFORE UPDATE OF DHDEP_VOLREEL ON VOL_REEL
FOR EACH ROW
DECLARE
    hrdepvolcom DATE;
BEGIN
    SELECT HRDEP_VOLCOM INTO hrdepvolcom 
    FROM VOL_COMMERCIAL 
    WHERE NUM_VOLCOM = :NEW.NUM_VOLCOM;
     --SELECTIONNER L'HEURE DE DEPART DE VOL COMMERCIAL
    :NEW.RETARD_VOLREEL := extract(hour from to_timestamp(:NEW.DHDEP_VOLREEL))*60 + extract(minute from to_timestamp(:NEW.DHDEP_VOLREEL))
        -(extract(hour from to_timestamp(hrdepvolcom))*60 + extract(minute from to_timestamp(hrdepvolcom)));

END;
/


--NB_REST_VOLREEL CHAMP CALCULE
create or replace
TRIGGER TBI_VOL_REEL_NBREST
AFTER INSERT OR DELETE ON VOL_RESERV
FOR EACH ROW
DECLARE
  nb_rest_volreel NUMBER;
BEGIN
IF INSERTING THEN
    SELECT NB_REST_VOLREEL INTO nb_rest_volreel
    FROM VOL_REEL
    WHERE CODE_VOLREEL = :NEW.CODE_VOLREEL;
    IF (nb_rest_volreel > 0) THEN 
          UPDATE VOL_REEL
          SET NB_REST_VOLREEL = NB_REST_VOLREEL - 1,
          NB_REEL_PASSG=NB_REEL_PASSG+1
          WHERE CODE_VOLREEL = :NEW.CODE_VOLREEL;
     
     ELSE
          raise_application_error(
          -20001,
          'Plus de places disponible !!');
      END IF;
END IF;
IF DELETING THEN
	UPDATE VOL_REEL
          SET NB_REST_VOLREEL = NB_REST_VOLREEL + 1,
          NB_REEL_PASSG = NB_REEL_PASSG - 1
          WHERE CODE_VOLREEL = :OLD.CODE_VOLREEL;
END IF;	  
END;
/

--INSERT VOL_RESERV
create or replace
TRIGGER T_VOL_RESERV 
AFTER UPDATE OF EST_PAYEE ON RESERVATION
FOR EACH ROW
WHEN (NEW.EST_PAYEE = 1)
DECLARE
  CURSOR cur_volreserv is
    SELECT CODE_VOLREEL, NUM_VOLCOM, NUM_RESERV
    FROM BILLET BILL
    WHERE num_reserv = :NEW.NUM_RESERV;
  volreserv cur_volreserv%ROWTYPE;
BEGIN
  OPEN cur_volreserv;
  LOOP
    FETCH cur_volreserv into volreserv;
    EXIT WHEN cur_volreserv%NOTFOUND;
      INSERT INTO VOL_RESERV (NUM_RESERV,NUM_VOLCOM,CODE_VOLREEL)
        VALUES (volreserv.NUM_RESERV,volreserv.NUM_VOLCOM,volreserv.CODE_VOLREEL);
  END LOOP;
  CLOSE cur_volreserv;
END T_VOL_RESERV;
/


