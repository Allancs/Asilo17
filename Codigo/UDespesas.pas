unit UDespesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DBCtrls, DB, Mask, FMTBcd, SqlExpr,
  jpeg, ExtCtrls;

type
  TDespesas = class(TForm)
    DataSource1: TDataSource;
    sqlAux: TSQLQuery;
    Image1: TImage;
    Baixo: TPanel;
    Direita: TBitBtn;
    Esquerda: TBitBtn;
    btnInserir: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnEditar: TBitBtn;
    btnDeletar: TBitBtn;
    LadoEsquerdo: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    DBMemo1: TDBMemo;
    DBEdit5: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    procedure btnEditarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure DireitaClick(Sender: TObject);
    procedure EsquerdaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Despesas: TDespesas;

implementation

uses UModulo;

{$R *.dfm}

procedure TDespesas.btnEditarClick(Sender: TObject);
begin
Modulo.cdsDespesas.Edit;
          btnInserir.Enabled    := False;
          btnDeletar.Enabled    := False;

          btnEditar.Enabled     := False;
          Direita.Enabled       := False;
          Esquerda.Enabled      := False;

          DBEdit2.Enabled       := True;
          DBMemo1.Enabled       := True;
          DBEdit4.Enabled       := True;
          DBEdit5.Enabled       := True;
          

          btnGravar.Enabled      := True;

end;

procedure TDespesas.btnInserirClick(Sender: TObject);
Var NReg : integer;
begin

          btnInserir.Enabled    := False;
          btnDeletar.Enabled    := False;

          btnEditar.Enabled     := False;
          Direita.Enabled       := False;
          Esquerda.Enabled      := False;


          DBEdit2.Enabled       := True;
          DBMemo1.Enabled       := True;
          DBEdit4.Enabled       := True;
          DBEdit5.Enabled       := True;

          btnGravar.Enabled      := True;



          sqlAux.Close;


          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('SELECT MAX(COD_DESPESA) AS ULTIMO FROM DESPESAS ');

          sqlAux.Open;
           If sqlAux.FieldByName('ULTIMO').Value = Null
           Then NReg :=1
           Else NReg := sqlAux.FieldByName('ULTIMO').Value + 1;

           Modulo.cdsDespesas.Insert;


           Modulo.cdsDespesasCOD_DESPESA.Value := NReg;


           DBEdit2.SetFocus;
end;

procedure TDespesas.btnDeletarClick(Sender: TObject);
begin
IF (DBEdit1.Text = '')
then
begin
   MessageDlg ('N�o a registros no banco',
                       mtWarning,
                       [mbyes,mbno],
                       0)
end
else
begin

          DBEdit2.Enabled       := False;
          DBMemo1.Enabled       := False;
          DBEdit4.Enabled       := False;
          DBEdit5.Enabled       := False;
 If
           MessageDlg ('Voc� tem certeza que deseja excluir?',
                       mtWarning,
                       [mbyes,mbno],
                       0)
          = mryes Then Begin
                         Modulo.cdsDespesas.Delete;
                         Modulo.cdsDespesas.ApplyUpdates(-1);
                         ShowMessage ('Registro Excluido com sucesso!');
                       End
                  Else Begin
                          ShowMessage ('Nenhum registro deletado!');
                       End;
                       end;


end;

procedure TDespesas.btnCancelarClick(Sender: TObject);
begin
Modulo.cdsDespesas.Cancel;
          DBEdit2.Enabled       := False;
          DBMemo1.Enabled       := False;
          DBEdit4.Enabled       := False;
          DBEdit5.Enabled       := False;

          btnInserir.Enabled    := True;
          btnDeletar.Enabled    := True;

          btnEditar.Enabled     := True;
          Direita.Enabled       := True;
          Esquerda.Enabled      := True;

          // Ligar o Gravar
          btnGravar.Enabled      := False;

end;

procedure TDespesas.btnGravarClick(Sender: TObject);
begin
Modulo.cdsDespesas.Post;

         Modulo.cdsDespesas.ApplyUpdates(-1);

         btnCancelar.Click;

end;

procedure TDespesas.DireitaClick(Sender: TObject);
begin
Modulo.cdsDespesas.Prior;
end;

procedure TDespesas.EsquerdaClick(Sender: TObject);
begin
Modulo.cdsDespesas.Next;
end;

procedure TDespesas.FormCreate(Sender: TObject);
begin
if DBEdit1.Text = ''
Then Begin
      btnEditar.Enabled := False;
      End
      Else Begin
      btnEditar.Enabled := True;;
      End;
end;

end.
