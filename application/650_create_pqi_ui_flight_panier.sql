CREATE OR REPLACE PACKAGE  UI_PANIER AS 
TYPE sqlcur IS REF CURSOR;
procedure paniers;
procedure redirect;
end UI_PANIER;
/