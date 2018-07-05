CREATE OR REPLACE package pa_facture as
    type sqlcur is ref cursor;
    function getFacture (idreserv number) return sqlcur;
end pa_facture;
/