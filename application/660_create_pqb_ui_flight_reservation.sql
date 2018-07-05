CREATE OR REPLACE PACKAGE BODY UI_RESERVATION AS

procedure paiement(admeluser VARCHAR2) AS
title varchar2(30) := 'Paiement Vol';
id_reservation number;
nomclass varchar2(50);
codevolreela varchar2(50);
codevolreelr varchar2(50);
BEGIN
ui_cookie.send('passagermail',admeluser);
-- get coockies and call procedure reservation :)
nomclass:=ui_cookie.getit('search').vals(1);
codevolreela:=ui_cookie.getit('volaller').vals(1);
codevolreelr:=ui_cookie.getit('volretour').vals(1);
ui_menu_footer.entete(title);
--htp.print(''||ui_cookie.getit('volaller').vals(1));
--htp.print(''||ui_cookie.getit('volretour').vals(1));

id_reservation:=pa_reserv_billet.generatereservation(pa_utilisateur.getidofuser(admeluser));

pa_reserv_billet.addbillet(id_reservation,nomclass,TO_NUMBER(codevolreela),admeluser);
if (codevolreelr is not null) then
  pa_reserv_billet.addbillet(id_reservation,nomclass,TO_NUMBER(codevolreelr),admeluser);
end if;

htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<div class="col-md-6">');
htp.print('<div class="jumbotron">');
htp.print('<h2>Paiement <i class="far fa-credit-card"></i></h2>');
htp.print('<form method="post" action="pa_reserv_billet.reserv_payee" id="formlogin">');
htp.print('<input type="hidden" name="idreserv" value="'||id_reservation||'">');
htp.print('<div class="form-group">');
htp.print('<label>Nom</label>');
htp.print('<input type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label for="cardNumber">Numéro de carte</label>');
htp.print('<div class="input-group">');
htp.print('<input type="text" class="form-control" id="cardNumber" placeholder="Numéro valide" autocomplete="off" required/>');
htp.print('<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>');
htp.print('</div>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label >Coupon</label>');
htp.print('<div class="input-group">');
htp.print('<input placeholder="Coupon" name="valcoup" id="couponvalue" type="text" class="form-control autocomplete="off"">');
htp.print('<span class="input-group-btn">');
htp.print('<button onclick="coupon()" class="btn btn-default" type="button">Valider</button>');
htp.print('</span>');
htp.print('</div>');
htp.print('</div>');
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Payer</button>');
htp.print('</div>');
htp.print('</form>');
htp.print('</div>');
htp.print('</div>');
ui_details_vol.detailvol(codevolreela,codevolreelr,nomclass);
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
END paiement;

procedure paiements(idreserv number) AS
title varchar2(30) := 'Paiement Vol';
c_facture sqlcur;
cur_facture facture%rowtype;
BEGIN
ui_menu_footer.entete(title);

htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<div class="col-md-6">');
htp.print('<div class="jumbotron">');
htp.print('<h2>Paiement <i class="far fa-credit-card"></i></h2>');
htp.print('<form method="post" action="pa_reserv_billet.reserv_payee" id="formlogin">');
htp.print('<input type="hidden" name="idreserv" value="'||idreserv||'">');
htp.print('<div class="form-group">');
htp.print('<label>Nom</label>');
htp.print('<input type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label for="cardNumber">Numéro de carte</label>');
htp.print('<div class="input-group">');
htp.print('<input type="text" class="form-control" id="cardNumber" placeholder="Numéro valide" autocomplete="off" required/>');
htp.print('<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>');
htp.print('</div>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label >Coupon</label>');
htp.print('<div class="input-group">');
htp.print('<input placeholder="Coupon" name="valcoup" id="couponvalue" type="text" class="form-control" autocomplete="off">');
htp.print('<span class="input-group-btn">');
htp.print('<button onclick="coupon()" class="btn btn-default" type="button">Valider</button>');
htp.print('</span>');
htp.print('</div>');
htp.print('</div>');
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Payer</button>');
htp.print('</div>');
htp.print('</form>');
htp.print('</div>');
htp.print('</div>');
htp.print('<div class="col-md-2">');
htp.print('</div>');
htp.print('<div class="col-md-4">');
htp.print('<div class="jumbotron">');
htp.print('<h2>Mes réservations</h2>');
htp.print('<hr>');
c_facture := pa_facture.getFacture(idreserv);
fetch c_facture into cur_facture;
while(c_facture%found) loop
htp.print('<h4>'||cur_facture.VILLEDEP_VOLCOM ||' <i class="fas fa-plane"></i> '|| cur_facture.VILLEARR_VOLCOM ||'<i class="far fa-calendar-alt pull-right"> '||cur_facture.DHDEP_VOLREEL||'</i></h4>');
fetch c_facture into cur_facture;
end loop;
htp.print('<hr>');
htp.print('<h3>Prix total : <span id="prixtotal">'||pa_panier.getTotal(idreserv)||'</span><span class="glyphicon glyphicon-euro pull-right"></span></h3>');
htp.print('</div>');
htp.print('</div>');
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
END paiements;

procedure redirect(admeluser VARCHAR2) as
begin
owa_util.redirect_url('ui_reservation.paiement?admeluser='||admeluser);
end redirect;
END UI_RESERVATION;
/