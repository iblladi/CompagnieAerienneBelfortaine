CREATE OR REPLACE PACKAGE UI_BILLET AS
  TYPE sqlcur IS REF CURSOR;
  procedure billet(idreserv number);
  procedure redirect(idreserv number);
END UI_BILLET;
/