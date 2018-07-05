CREATE OR REPLACE PACKAGE BODY UI_DETAILS_VOL AS
  
  
procedure detailvol(volaller varchar2 DEFAULT NULL,volretour varchar2 DEFAULT NULL,classvol varchar2) AS

total number;
infovol vol_reel%rowtype;
BEGIN

htp.print('<div class="col-md-2">');
htp.print('</div>');
htp.print('<div class="col-md-4">');
htp.print('<div class="jumbotron">');
htp.print('<h2>Mes réservations</h2>');
htp.print('<hr>');
infovol := pa_volreel.getinfovol(TO_NUMBER(volaller));
htp.print('<h3>Vol aller</h3>');
htp.print('<h4>'||infovol.VILLEDEP_VOLCOM ||' <i class="fas fa-plane"></i> '|| infovol.VILLEARR_VOLCOM ||'<i class="far fa-calendar-alt pull-right"> '||infovol.DHDEP_VOLREEL||'</i></h4>');
if (volretour is not null) then
infovol := pa_volreel.getinfovol(TO_NUMBER(volretour));
htp.print('<h3>Vol retour</h3>');
htp.print('<h4>'||infovol.VILLEDEP_VOLCOM ||' <i class="fas fa-plane"></i> '|| infovol.VILLEARR_VOLCOM ||'<i class="far fa-calendar-alt pull-right"> '||infovol.DHDEP_VOLREEL||'</i></h4>');
end if;
if (volretour is not null) then
total:=pa_volreel.prixreduit(TO_NUMBER(volaller),classvol)+pa_volreel.prixreduit(TO_NUMBER(volretour),classvol);
else 
total:=pa_volreel.prixreduit(TO_NUMBER(volaller),classvol);
end if;
htp.print('<hr>');
htp.print('<h3>Prix total : <span id="prixtotal">'||total||'</span><span class="glyphicon glyphicon-euro pull-right"></span></h3>');
htp.print('</div>');
htp.print('</div>');
end detailvol;
end UI_DETAILS_VOL;
/
