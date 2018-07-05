create or replace
PACKAGE UI_UTLISATEUR AS
TYPE sqlcur IS REF CURSOR;
procedure client(volaller varchar2 DEFAULT NULL,volretour varchar2 DEFAULT NULL);
procedure passager(admeluser varchar2);
procedure redirect_passager(admeluser varchar2);
end UI_UTLISATEUR;