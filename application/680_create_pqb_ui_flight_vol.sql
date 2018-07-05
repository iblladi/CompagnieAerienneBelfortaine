CREATE OR REPLACE PACKAGE BODY UI_VOL AS

  procedure recherchevol(villedepart varchar2,villearrive varchar2,datedepart varchar2,dateretour varchar2,classe varchar2) AS
    title varchar2(30) := 'Recherche Vol';
    c_vol sqlcur;
    cur_vol view_volreel_recherche%rowtype;
    target_cookie OWA_COOKIE.vc_arr;
  BEGIN
  
   ui_cookie.send('search', classe);
   ui_menu_footer.entete(title);
   htp.print('<div class="container">');
   htp.header(2,'Les vols : ');
   htp.print('<div class="jumbotron">');
   htp.formopen('UI_UTLISATEUR.client');
   --htp.print('<form method="post" action="UI_UTLISATEUR.client">');
    c_vol := pa_volreel.rechercheVol(villedepart,villearrive,datedepart,classe);
      fetch c_vol into cur_vol;
    while(c_vol%found) loop
          htp.print('<h2>Vol Aller : ' ||cur_vol.VILLEDEP_VOLCOM|| ' <i class="fas fa-plane"></i> ' ||cur_vol.VILLEARR_VOLCOM|| ' </h2>');
          htp.print('<div class="radio radioflight">');
            htp.print('<label><input type="radio" value="'||cur_vol.CODE_VOLREEL||'"  name="volaller" required> ' || cur_vol.VILLEDEP_VOLCOM || ' <i class="fas fa-plane"></i> ' || cur_vol.VILLEARR_VOLCOM || ' </label>');
            htp.print('<label>Départ <i class="far fa-calendar-alt"></i> ' ||TO_CHAR(cur_vol.DHDEP_VOLREEL,'DD/MM/YYYY HH24:MI:SS')|| ' </label>');
            htp.print('<label>Arrivé <i class="far fa-calendar-alt"></i> ' ||TO_CHAR(cur_vol.DHARR_VOLREEL,'DD/MM/YYYY HH24:MI:SS')|| ' </label>');
            htp.print('<label class="pull-right">Prix : ' ||pa_volreel.prixreduit(cur_vol.CODE_VOLREEL,cur_vol.NOM_CLASS)|| '€ </label>');
            htp.print('<label class="pull-right">Classe : <i class="fas fa-briefcase"></i> ' ||cur_vol.NOM_CLASS|| ' </label>');
          htp.print('</div>');
      fetch c_vol into cur_vol;
    end loop;
    
    c_vol := pa_volreel.rechercheVol(villearrive,villedepart,dateretour,classe);
      fetch c_vol into cur_vol;
    while(c_vol%found) loop
          htp.print('<h2>Vol Retour : ' ||cur_vol.VILLEDEP_VOLCOM|| ' <i class="fas fa-plane"></i> ' ||cur_vol.VILLEARR_VOLCOM|| ' </h2>');
          htp.print('<div class="radio radioflight">');
            htp.print('<label><input type="radio" value="'||cur_vol.CODE_VOLREEL||'"  name="volretour"> ' || cur_vol.VILLEDEP_VOLCOM || ' <i class="fas fa-plane"></i> ' || cur_vol.VILLEARR_VOLCOM || ' </label>');
            htp.print('<label>Départ <i class="far fa-calendar-alt"></i> ' ||TO_CHAR(cur_vol.DHDEP_VOLREEL,'DD/MM/YYYY HH24:MI:SS')|| ' </label>');
            htp.print('<label>Arrivé <i class="far fa-calendar-alt"></i> ' ||TO_CHAR(cur_vol.DHARR_VOLREEL,'DD/MM/YYYY HH24:MI:SS')|| ' </label>');
            htp.print('<label class="pull-right">Prix : ' ||pa_volreel.prixreduit(cur_vol.CODE_VOLREEL,cur_vol.NOM_CLASS)|| '€ </label>');
            htp.print('<label class="pull-right">Classe : <i class="fas fa-briefcase"></i> ' ||cur_vol.NOM_CLASS|| ' </label>');
          htp.print('</div>');
      fetch c_vol into cur_vol;
    end loop;
   htp.print('<div class="text-right">');
   htp.print('<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-bookmark"></span> Réserver</button>');
   htp.print('</div>');
   htp.formclose;
   htp.print('</div>');
   htp.print('</div>');
   ui_menu_footer.footer;
  END recherchevol;


END UI_VOL;
/
