CREATE OR REPLACE PACKAGE BODY UI_PANIER AS
  
  
procedure paniers AS

title varchar2(30) := 'Panier Vol';
c_panier sqlcur;
cur_panier panier%rowtype;
admeluser varchar(50);
BEGIN


admeluser := ui_cookie.getit('passagermail').vals(1);
ui_menu_footer.entete(title);
htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<h1>Mes réservation </h1>');

if (admeluser is not null) then
c_panier := pa_panier.getList(admeluser);
fetch c_panier into cur_panier;
while(c_panier%found) loop
htp.print('<div class="jumbotron">');
htp.print('<ul class="list-inline">');
htp.print('<li class="list-inline-item"> <span class="glyphicon glyphicon-tag"></span> '|| cur_panier.NUM_RESERV ||'</li>');
htp.print('<li class="list-inline-item"> <span class="glyphicon glyphicon-calendar"></span> '|| cur_panier.DATE_RESERV ||'</li>');
htp.print('<li class="list-inline-item"> <span class="glyphicon glyphicon-user"></span> '|| cur_panier.PRE_USER ||' '|| cur_panier.NOM_USER ||'</li>');
htp.print('<li class="list-inline-item pull-right">'|| pa_panier.getTotal(cur_panier.NUM_RESERV) ||'<span class="glyphicon glyphicon-euro"></span></li>');
htp.print('</ul>');
htp.print('<hr>');
htp.print('<div class="btn-toolbar">');
htp.print('<a href="ui_reservation.paiements?idreserv='||cur_panier.NUM_RESERV ||'" class="btn btn-primary pull-right">Payer</a>');
htp.print('<a href="pa_panier.supreservation?idreserv='||cur_panier.NUM_RESERV ||'" class="btn btn-danger pull-right">Supprimer <span class="glyphicon glyphicon-trash"></span></a>');
htp.print('</div>');
htp.print('</div>');
fetch c_panier into cur_panier;
end loop;
else
htp.print('<div class="jumbotron">');
htp.print('<p>Votre panier est vide</p>');
htp.print('</div>');
end if;
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
Exception when others then
ui_menu_footer.entete(title);
htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<div class="jumbotron">');
htp.print('<p>Votre panier est vide</p>');
htp.print('</div>');
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
end paniers;

procedure redirect as
begin
owa_util.redirect_url('ui_panier.paniers');
end redirect;

end UI_PANIER;
/