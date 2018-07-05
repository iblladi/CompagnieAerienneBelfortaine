CREATE OR REPLACE package body pa_reserv_billet is

	function generateReservation(numuser number) return number is
			idreserv number;
		begin
			insert into reservation (NUM_USER,DATE_RESERV, PRIX_TOTAL_RESERV)
				values (numuser, sysdate,0) RETURNING NUM_RESERV INTO idreserv;
      commit;
      return idreserv;
		end generateReservation;


	procedure addBillet(idreserv number,classvol varchar2, codevolreel number, admeluser varchar2) is
      c_user sqlcur;
      cur_user utilisateur%rowtype;
      nomuser varchar2(50);
      preuser varchar2(50);
      numuser number:=pa_utilisateur.getidofuser(admeluser);
      numvolcom number:=pa_volreel.getnumvolcombycodevolreel(codevolreel);
      prixbillet number:=pa_volreel.prixreduit(codevolreel,classvol);
      numclass number:=pa_classe.getclasse(classvol);
		begin
      c_user := PA_UTILISATEUR.checkExistanceOfUser(admeluser);
      fetch c_user into cur_user;
      while(c_user%found) loop
      nomuser:=cur_user.NOM_USER;
      preuser:=cur_user.PRE_USER;
      fetch c_user into cur_user;
      end loop;
      
			insert into billet (NUM_RESERV, NUM_CLASS,NUM_VOLCOM,CODE_VOLREEL,NUM_USER,PRIX_BILLET,NOM_USER,PRE_USER,PRESENT_USER)
				values (idreserv, numclass, numvolcom, codevolreel, numuser, prixbillet,nomuser,preuser,0);
      commit;
		end addBillet;
    
    procedure reserv_payee(idreserv number, valcoup number DEFAULT 0) is
            prix number;
        begin
            select sum(PRIX_BILLET) into prix
            from billet
            where NUM_RESERV = idreserv;
            --***************************
            update reservation
            set PRIX_TOTAL_RESERV = prix - valcoup
            , EST_PAYEE = 1
            ,code_promotion_reserv=valcoup
            where NUM_RESERV = idreserv;
            commit;
        ui_billet.redirect(idreserv);
    end reserv_payee;
end pa_reserv_billet;
/
