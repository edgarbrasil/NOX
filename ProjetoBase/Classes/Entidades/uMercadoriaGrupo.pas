unit uMercadoriaGrupo;

interface

uses uEntidadeBase;

type
  TMercadoriaGrupo = class(TEntidadeBase)
  private
    { private declarations }
    FCodigo: Integer;
    FNome: String;
    FCobraTaxaServico: Boolean;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
		property Nome: String read FNome write FNome;
		property CobraTaxaServico: Boolean read FCobraTaxaServico write FCobraTaxaServico;
  end;

implementation

uses SysUtils;

{ TMercadoriaGrupo }

constructor TMercadoriaGrupo.Create;
begin
  FCodigo := 0;
  FNome := EmptyStr;
  FCobraTaxaServico := False;
end;

destructor TMercadoriaGrupo.Destroy;
begin

  inherited;
end;

end.
