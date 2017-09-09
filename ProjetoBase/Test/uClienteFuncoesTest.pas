unit uClienteFuncoesTest;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, uClienteFuncoes, uCliente,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.DApt, FireDAC.VCLUI.Wait;

type
  // Test methods for class TClienteFuncoes

  TestTClienteFuncoes = class(TTestCase)
  strict private
    //FClienteFuncoes: TClienteFuncoes;
    //FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestInserir;
    procedure TestAtualizar;
    procedure TestObter;
    procedure TestExcluir;
  end;

implementation

uses SysUtils;

procedure TestTClienteFuncoes.SetUp;
begin
  //FClienteFuncoes := TClienteFuncoes.Create;
  //FDPhysMSSQLDriverLink1 := TFDPhysMSSQLDriverLink.Create(nil);
end;

procedure TestTClienteFuncoes.TearDown;
begin
  {FClienteFuncoes.Free;
  FClienteFuncoes := nil;
  FreeAndNIl(FDPhysMSSQLDriverLink1);}
end;

procedure TestTClienteFuncoes.TestInserir;
var
  Cliente: TCliente;
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create;
  try
    Cliente := TCliente.Create;
    try
      Cliente.Codigo := 1; //arranjar uma forma mais espertinha para dar o codigo pra ele, no segundo teste da pau.
      Cliente.Nome := 'teste';
      ClienteFuncoes.Inserir(Cliente);
    finally
      FreeAndNil(Cliente);
    end;
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;

procedure TestTClienteFuncoes.TestAtualizar;
var
  Cliente: TCliente;
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create;
  try
    Cliente := TCliente.Create;
    try
      Cliente.Codigo := 1; //arranjar uma forma mais espertinha para dar o codigo pra ele, no segundo teste da pau.
      Cliente.Nome := 'teste atualizado';
      ClienteFuncoes.Atualizar(Cliente);
    finally
      FreeAndNil(Cliente);
    end;
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;

procedure TestTClienteFuncoes.TestObter;
var
  Cliente: TCliente;
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create;
  try
    Cliente := ClienteFuncoes.Obter(1);
    try
      CheckEquals(1, Cliente.Codigo);
      CheckEquals('teste atualizado', Cliente.Nome);
    finally
      FreeAndNil(Cliente);
    end;
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;

procedure TestTClienteFuncoes.TestExcluir;
var
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create;
  try
    ClienteFuncoes.Excluir(1);
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTClienteFuncoes.Suite);
end.

