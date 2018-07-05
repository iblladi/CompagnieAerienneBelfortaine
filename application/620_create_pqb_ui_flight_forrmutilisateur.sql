CREATE OR REPLACE PACKAGE BODY UI_FORM_UTILISATEUR AS
  
  
	procedure formulaire_utlisateur(nomuser VARCHAR2 DEFAULT NULL,preuser VARCHAR2 DEFAULT NULL,numcateg NUMBER DEFAULT NULL,dnaissuser VARCHAR2 DEFAULT NULL,nrueuser VARCHAR2 DEFAULT NULL,cpuser VARCHAR2 DEFAULT NULL,villeuser VARCHAR2 DEFAULT NULL,paysuser VARCHAR2 DEFAULT NULL,teluser VARCHAR2 DEFAULT NULL,admeluser VARCHAR2 DEFAULT NULL) AS
	c_categ sqlcur;
  cur_categ categorie%rowtype;
  BEGIN
	htp.print('<div class="form-group">');
	htp.print('<label>* Nom :</label>');
	htp.print('<input name="nomuser" value="'||nomuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Prénom :</label>');
	htp.print('<input name="preuser" value="'||preuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
  htp.print('<div class="form-group">');
  htp.print('<label>* Catégorie :</label>');
    htp.print('<select name="numcateg" value="numcateg" class="form-control" id="sel1">');
    c_categ := pa_categ.getallcateg;
        fetch c_categ into cur_categ;
        while(c_categ%found) loop
            htp.print('<option value="'||cur_categ.num_categ||'">'||cur_categ.CATEG_PASG||'</option>');
            fetch c_categ into cur_categ;
        end loop;
    htp.print('</select>');
  htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Date de naissance :</label>');
	htp.print('<input type="date" name="dnaissuser" value="'||dnaissuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Rue :</label>');
	htp.print('<input name="nrueuser" value="'||nrueuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Code postal :</label>');
	htp.print('<input name="cpuser" value="'||cpuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Ville :</label>');
	htp.print('<input name="villeuser" value="'||villeuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Pays :</label>');
	htp.print('<input name="paysuser" value="'||paysuser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Tel :</label>');
	htp.print('<input name="teluser" value="'||teluser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	htp.print('<div class="form-group">');
	htp.print('<label>* Mél :</label>');
	htp.print('<input name="admeluser" value="'||admeluser||'" type="text" class="form-control" required>');
	htp.print('</div>');
	END formulaire_utlisateur;
END UI_FORM_UTILISATEUR;
/