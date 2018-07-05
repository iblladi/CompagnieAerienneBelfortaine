CREATE OR REPLACE package body pa_facture as
    function getFacture (idreserv number) return sqlcur is
        cur_facture sqlcur;
    begin
    open cur_facture for
        select * 
        from facture
        where num_reserv = idreserv;
        return cur_facture;
    end getFacture;

end pa_facture;
/
