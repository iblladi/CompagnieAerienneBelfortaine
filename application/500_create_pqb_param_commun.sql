CREATE OR REPLACE PACKAGE BODY UI_COOKIE AS

  procedure send(cookie_name IN VARCHAR2 DEFAULT NULL, cookie_val IN VARCHAR2 DEFAULT NULL) AS
  BEGIN
     -- Cookies must be set within the header
   OWA_UTIL.mime_header ('text/html', FALSE);
   -- Send a cookie if a name was entered
   IF cookie_name IS NOT NULL
   THEN
      OWA_COOKIE.send (cookie_name, cookie_val);
   END IF;
   OWA_UTIL.http_header_close;
  END send;
  
  procedure sendtwo( cookie_vala IN VARCHAR2 DEFAULT NULL,cookie_valr IN VARCHAR2 DEFAULT NULL) AS
  BEGIN
     -- Cookies must be set within the header
   OWA_UTIL.mime_header ('text/html', FALSE);
   -- Send a cookie if a name was entered
  
  
      OWA_COOKIE.send ('volaller', cookie_vala);
      OWA_COOKIE.send ('volretour', cookie_valr);
   
   OWA_UTIL.http_header_close;
  END sendtwo;

  function getit(cookie_name IN VARCHAR2 DEFAULT NULL) return OWA_COOKIE.cookie AS
    --target_cookie OWA_COOKIE.cookie;
  BEGIN
    return OWA_COOKIE.get(cookie_name);
  
  END getit;

  function getAll return OWA_COOKIE.vc_arr IS
    current_cookie_names          OWA_COOKIE.vc_arr;
    current_cookie_vals           OWA_COOKIE.vc_arr;
    n                             INTEGER DEFAULT 0;

  BEGIN
    -- Fetch and print the current cookies
    OWA_COOKIE.get_all (
      current_cookie_names,
      current_cookie_vals,
      n
    );
    return current_cookie_vals;
  END;

END UI_COOKIE;
/
