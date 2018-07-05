CREATE OR REPLACE package body pa_panier as
    function getList (admeluser varchar2) return sqlcur is
        cur_panier sqlcur;
    begin
    open cur_panier for
        select * 
        from panier
        where admel_user = admeluser
        and EST_PAYEE=0;
        return cur_panier;
    end getList;
    
    function getTotal(numreserv number) return number is
      total number;
    begin
      select sum(PRIX_BILLET) into total from BILLET where NUM_RESERV=numreserv;
      return total;
    end getTotal;
    
    procedure supreservation(idreserv number) is
    begin
      delete from RESERVATION where NUM_RESERV=idreserv;
      commit;
      UI_PANIER.redirect;
      
    end supreservation;

end pa_panier;
/

