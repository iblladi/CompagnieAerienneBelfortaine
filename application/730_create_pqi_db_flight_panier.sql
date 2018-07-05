CREATE OR REPLACE package pa_panier as
    TYPE sqlcur IS REF CURSOR;
    function getList (admeluser varchar2) return sqlcur;  
    function getTotal(numreserv number) return number;
    procedure supreservation(idreserv number);
end pa_panier;
/