CREATE OR REPLACE PACKAGE BODY UI_MENU_FOOTER AS

  procedure entete(title varchar2) AS
    viewport varchar(255) := '<meta name="viewport" content="width=device-width, initial-scale=1">';
    css varchar2(255) := '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">';
    mycss varchar2(255) := '<link rel="stylesheet" href="/public/css/style.css">';
    jsq varchar2(255) := '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>';
    js varchar2(255) := '<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>';
    myjs varchar2(255) := '<script src="/public/js/myjs.js"></script>';
    jsemail varchar2(255) := '<script src="https://smtpjs.com/v2/smtp.js"></script>';
    icon varchar2(255) := '<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">';
  BEGIN
    htp.htmlopen;
    htp.headopen;
    htp.print('<title>Compagnie Belfortaine | '||title||'</title>');
    htp.print(viewport);
    htp.print(css);
    htp.print(mycss);
    htp.print(jsq);
    htp.print(js);
    htp.print(myjs);
    htp.print(jsemail);
    htp.print(icon);
    htp.headclose;
    htp.headclose;
    htp.bodyopen;

    htp.print('<nav class="navbar navbar-default">');
    htp.print('<div class="container-fluid">');
    htp.print('<div class="navbar-header">');
    htp.print('<a class="navbar-brand" href="ui_home.accueil"><img style="width: 100px; margin-top:-5px;" src="/public/image/logonv.png" alt="Image text"></a>');
    htp.print('</div>');
    htp.print('<ul class="nav navbar-nav navbar-right">');
    htp.print('<li><a href="ui_panier.paniers"><span class="glyphicon glyphicon-shopping-cart"></span> Panier</a></li>');
    htp.print('</ul>');
    htp.print('</div>');
    htp.print('</nav>');
      


  END entete;

  procedure footer AS
  BEGIN
    htp.print('<footer class="text-center">');
    htp.print('<div>');
    htp.print('<p>&copy; 2018 - FLIGHT G04 - BD50 </p>');
    htp.print('</div>');        
    htp.print('</footer>');
    htp.bodyclose;
    htp.htmlclose;
  END footer;

END UI_MENU_FOOTER;
/
