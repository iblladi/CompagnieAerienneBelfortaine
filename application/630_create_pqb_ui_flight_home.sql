CREATE OR REPLACE PACKAGE BODY UI_HOME AS

  procedure accueil AS
    title varchar2(30) := 'Accueil';
    c_ville sqlcur;
    c_classe sqlcur;
    cur_ville ville%rowtype;
    cur_classe classe%rowtype;
  BEGIN
   ui_menu_footer.entete(title);
   htp.print('<div class="text-center">');
   htp.img( cattributes => 'height="150" width="150"',curl=>'/public/image/logo.png');
   htp.print('</div>');
   htp.print('<br>');
   htp.print('<div id="container-center" class="container h-100 d-flex">');
    htp.print('<div class="row">'); 
    htp.print('<div class="jumbotron jumbotronhome">');
    htp.formopen('UI_VOL.recherchevol');
    htp.print('<div class="form-row">');
    htp.print('<div class="form-group col-md-3">');
    htp.print('<label>Départ</label>');
    htp.print('<select name="villedepart" class="form-control" id="sel1">');
    c_ville := pa_ville.getALLVille;
        fetch c_ville into cur_ville;
        while(c_ville%found) loop
            htp.print('<option>'||cur_ville.nom_ville||'</option>');
            fetch c_ville into cur_ville;
        end loop;
    htp.print('</select>');
    htp.print('</div>');
    htp.print('<div class="form-group col-md-3">');
    htp.print('<label>Arrivé</label>');
    htp.print('<select name="villearrive" class="form-control" id="sel1">');
    c_ville := pa_ville.getALLVille;
        fetch c_ville into cur_ville;
        while(c_ville%found) loop
            htp.print('<option>'||cur_ville.nom_ville||'</option>');
            fetch c_ville into cur_ville;
        end loop;
    htp.print('</select>');
    htp.print(' </div>');
    htp.print('<div class="form-group col-md-2">');
    htp.print('<label>Date de départ</label>');
    htp.print('<input name="datedepart" type="date" class="form-control" required>');
    htp.print('</div>');
    htp.print('<div class="form-group col-md-2">');
    htp.print('<label>Date de retour</label>');
    htp.print('<input name="dateretour" type="date" class="form-control">');
    htp.print('</div>');
    htp.print('<div class="form-group col-md-2">');
    htp.print('<label>Classe</label>');
    htp.print('<select name="classe" class="form-control" id="sel1">');
    c_classe := pa_classe.getAllClasse;
        fetch c_classe into cur_classe;
        while(c_classe%found) loop
            htp.print('<option>'||cur_classe.nom_class||'</option>');
            fetch c_classe into cur_classe;
        end loop;
    htp.print('</select>');
    htp.print(' </div>');
    htp.print('</div>');
    htp.print('<div class="text-right">');
    htp.print('<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>Chercher</button>');
    htp.print('</div>');
    htp.formclose;
    htp.print('</div>');
    htp.print('</div>');
   htp.print('</div>');
   ui_menu_footer.footer;
  END accueil;


END UI_HOME;
/