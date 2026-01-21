unit WebModuleUnit1;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Param,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Pool,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Connection: TFDConnection;
  Query: TFDQuery;
  Html: TStringBuilder;
begin
  Connection := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);
  Html := TStringBuilder.Create;
  try
    Connection.DriverName := 'MSSQL';
    Connection.Params.Values['Server'] := 'localhost';
    Connection.Params.Values['Database'] := 'TourismWeb';
    Connection.Params.Values['User_Name'] := 'sa';
    Connection.Params.Values['Password'] := 'your_password';
    Connection.Params.Values['OSAuthent'] := 'No';
    Query.Connection := Connection;
    Connection.Connected := True;

    Query.SQL.Text := 'SELECT TOP 10 title, price FROM tour_packages ORDER BY price';
    Query.Open;

    Html.Append('<html><head><meta charset="utf-8"></head><body>');
    Html.Append('<h1>Каталог туров</h1><ul>');
    while not Query.Eof do
    begin
      Html.Append('<li>');
      Html.Append(Query.FieldByName('title').AsString);
      Html.Append(' — ');
      Html.Append(Query.FieldByName('price').AsString);
      Html.Append('</li>');
      Query.Next;
    end;
    Html.Append('</ul></body></html>');

    Response.ContentType := 'text/html; charset=utf-8';
    Response.Content := Html.ToString;
    Handled := True;
  finally
    Html.Free;
    Query.Free;
    Connection.Free;
  end;
end;

end.
