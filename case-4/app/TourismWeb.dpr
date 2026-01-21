library TourismWeb;

uses
  Web.WebReq,
  Web.HTTPApp,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
