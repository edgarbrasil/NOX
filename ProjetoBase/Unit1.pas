unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMyClass = class(TComponent)
  private
    { private declarations }
    FTeste: String;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Teste: String read FTeste write FTeste;
  end;

  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    MyClass: TMyClass;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TMyClass }

constructor TMyClass.Create;
begin
  FTeste := '';
end;

destructor TMyClass.Destroy;
begin

  inherited;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Assigned(MyClass)) then
    FreeAndNIl(MyClass);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MyClass := TMyClass.Create;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//

end;

end.
