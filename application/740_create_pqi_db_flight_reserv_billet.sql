CREATE OR REPLACE package pa_reserv_billet is
	function generateReservation(numuser number) return number;
	procedure addBillet(idreserv number,classvol varchar2, codevolreel number, admeluser varchar2);
  procedure reserv_payee(idreserv number, valcoup number DEFAULT 0);
  TYPE sqlcur IS REF CURSOR;
end pa_reserv_billet;
/