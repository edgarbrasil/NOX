unit uCliente;

interface

uses uEntidadeBase, uIEntidadebase;

type
  TCliente = class(TEntidadebase{, IEntidadebase})
  private
    FCodigo: Integer;
    FNome: String;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;

    class function CriarObjeto(
      Codigo: Integer;
      Nome: String): TCliente;
  end;

implementation

uses SysUtils;

{ TCliente }

constructor TCliente.Create;
begin
  inherited;
  FCodigo := 0;
  FNome := EmptyStr;
end;

class function TCliente.CriarObjeto(Codigo: Integer;
  Nome: String): TCliente;
begin
  Result := TCliente.Create;
  Result.Codigo := Codigo;
  Result.Nome := Nome;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

end.
