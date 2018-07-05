CREATE OR REPLACE PACKAGE  UI_DETAILS_VOL AS  
procedure detailvol(volaller varchar2 DEFAULT NULL,volretour varchar2 DEFAULT NULL,classvol varchar2);
end UI_DETAILS_VOL;
/