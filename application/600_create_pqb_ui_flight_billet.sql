CREATE OR REPLACE PACKAGE BODY UI_BILLET AS
  
  
procedure billet(idreserv number) AS

title varchar2(30) := 'Billets Vol';
c_facture sqlcur;
cur_facture facture%rowtype;
BEGIN

ui_menu_footer.entete(title);
htp.print('<div class="container">');
htp.print('<div class="row" id="billet_vol">');
htp.print('<h1>Billets </h1>');
c_facture := pa_facture.getFacture(idreserv);
fetch c_facture into cur_facture;
while(c_facture%found) loop
htp.print('<div class="jumbotron billet">');
htp.print('<ul class="list-inline">');
htp.print('<li class="list-inline-item"><img height="50" src="https://image.ibb.co/cMoR0J/unnamed.png"></li>');
htp.print('<li class="list-inline-item pull-right"><p><strong>Num Réservation:</strong> '||cur_facture.NUM_RESERV||'</p></li>');
htp.print('</ul>');
htp.print('<hr>');
htp.print('<ul class="list-inline">');
htp.print('<li class="list-inline-item"><p><strong>Passager :</strong> '|| cur_facture.PRE_USER ||' '|| cur_facture.NOM_USER ||'</p></li>');
htp.print('<li class="list-inline-item pull-right"><p><strong>Numéro de vol :</strong> '|| cur_facture.NUM_VOLCOM ||'</p></li>');
htp.print('</ul>');
htp.print('<ul class="list-inline">');
htp.print('<li class="list-inline-item"><p><strong>De :</strong> '|| cur_facture.NOM_AERO_DEP ||' ('|| cur_facture.NOM_TERMINAL_DEP ||') <i class="far fa-calendar-alt"></i> '|| TO_CHAR(cur_facture.DHDEP_VOLREEL,'DD/MM/YYYY HH24:MI') ||'</p></li>');
htp.print('<li class="list-inline-item"><p><strong>A :</strong> '|| cur_facture.NOM_AERO_ARR ||' ('|| cur_facture.NOM_TERMINAL_ARR ||') <i class="far fa-calendar-alt"></i> '|| TO_CHAR(cur_facture.DHARR_VOLREEL,'DD/MM/YYYY HH24:MI')  ||'</p></li>');
htp.print('</ul>');
htp.print('<ul class="list-inline">');
htp.print('<li class="list-inline-item"><p><strong>Classe :</strong> '|| cur_facture.NOM_CLASS ||'</li>');
htp.print('<li class="list-inline-item pull-right"><p><strong>Durée de vol:</strong> '|| cur_facture.DUREE_VOL ||'</p></li>');
htp.print('</ul>');
htp.print('<hr>');
htp.print('<p class="pull-right"><strong>Prix :</strong> '|| cur_facture.PRIX_BILLET ||' <span class="glyphicon glyphicon-euro"></span></p>');
htp.print('</div>');
fetch c_facture into cur_facture;
end loop;
htp.print('<button id="imprimer" onclick="javascript:window.print()" class="btn btn-primary pull-right">Imprimer</button>');
htp.print('</div>');
htp.print('</div>');
htp.print('<script>
var email_send="'||ui_cookie.getit('clientemail').vals(1)||'";
var body_mail = document.getElementById("billet_vol").innerHTML;
Email.send("test.bd50@gmail.com",
email_send,
"Billets Compagnie Belfortaine",
body_mail,
"smtp.gmail.com",
"test.bd50@gmail.com",
"bd50$$$$");
</script>');

end billet;

procedure redirect(idreserv number) as
begin
owa_util.redirect_url('ui_billet.billet?idreserv='||idreserv);
end redirect;

end UI_BILLET;
/
