CREATE OR REPLACE PACKAGE UI_RESERVATION AS
TYPE sqlcur IS REF CURSOR;
procedure paiement(admeluser VARCHAR2);
procedure paiements(idreserv number);
procedure redirect(admeluser VARCHAR2);
end UI_RESERVATION;
/