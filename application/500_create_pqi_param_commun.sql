CREATE OR REPLACE PACKAGE UI_COOKIE AS
  procedure send(cookie_name IN VARCHAR2 DEFAULT NULL, cookie_val IN VARCHAR2 DEFAULT NULL);
  procedure sendtwo(cookie_vala IN VARCHAR2 DEFAULT NULL,cookie_valr IN VARCHAR2 DEFAULT NULL);
  function getit(cookie_name IN VARCHAR2 DEFAULT NULL) return OWA_COOKIE.cookie;
  function getAll return OWA_COOKIE.vc_arr;
END UI_COOKIE;
/