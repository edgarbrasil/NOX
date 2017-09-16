unit uColecaoBase;

interface

uses Contnrs;

type
  TColecaoBase = class
  private
    { private declarations }
  protected
    { protected declarations }
    FColecao: TObjectList;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function Quantidade: Integer;
    procedure Limpar;
  end;

implementation

uses SysUtils;

{ TColecaoBase }

constructor TColecaoBase.Create;
begin
  FColecao := TObjectList.Create(True);
end;

destructor TColecaoBase.Destroy;
begin
  if (Assigned(FColecao)) then
    FreeAndNIl(FColecao);
  inherited;
end;

procedure TColecaoBase.Limpar;
begin
  if (Assigned(FColecao)) then
    FColecao.Clear;
end;

function TColecaoBase.Quantidade: Integer;
begin
  Result := 0;
  if (Assigned(FColecao)) then
    Result := FColecao.Count;
end;

end.
