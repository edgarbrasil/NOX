unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Phys.ODBCBase, FireDAC.Comp.UI, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    FDQuery1: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uEntidadeBase, uFactoryEntidade, uEnumeradores, uCliente;

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  EntidadeBase: TEntidadeBase;
begin
  EntidadeBase := TFactoryEntidade.InstanciarEntidade(teCliente);
  try
    if not (EntidadeBase is TCliente) then
    begin
      showmessage('ahauihau');
      Exit;
    end;

    TCliente(EntidadeBase).Codigo := 0;
    TCliente(EntidadeBase).Nome := 'TEste';
  finally
    FreeAndNil(EntidadeBase);
  end;
end;

end.
