CREATE OR REPLACE PACKAGE UI_VOL AS
  TYPE sqlcur IS REF CURSOR;
  procedure recherchevol(villedepart varchar2,villearrive varchar2,datedepart varchar2,dateretour varchar2,classe varchar2);
END UI_VOL;
/