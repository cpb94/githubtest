$PBExportHeader$u_marca_lista.sru
$PBExportComments$Objeco de marcar y desmarcar datos relacionados.
forward
global type u_marca_lista from UserObject
end type
type p_buscar1 from up_buscar within u_marca_lista
end type
type p_buscar2 from up_buscar within u_marca_lista
end type
type dw_proceso from datawindow within u_marca_lista
end type
type cb_desmarcar from u_boton within u_marca_lista
end type
type cb_marcar from u_boton within u_marca_lista
end type
type st_titulo2 from statictext within u_marca_lista
end type
type st_titulo1 from statictext within u_marca_lista
end type
type dw_marca from datawindow within u_marca_lista
end type
end forward

global type u_marca_lista from UserObject
int Width=1358
int Height=660
boolean Border=true
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event itemchanged pbm_dwnitemchange
p_buscar1 p_buscar1
p_buscar2 p_buscar2
dw_proceso dw_proceso
cb_desmarcar cb_desmarcar
cb_marcar cb_marcar
st_titulo2 st_titulo2
st_titulo1 st_titulo1
dw_marca dw_marca
end type
global u_marca_lista u_marca_lista

type variables
Integer   ii_campo = 2            // Campo filtro para buscar
Long      il_nummarcas = 0    // Numero de registros marcados
end variables

forward prototypes
public subroutine f_cargar_datos (string as_datawindow, string as_patron, string as_filtro, string as_titulo1, string as_titulo2)
end prototypes

event itemchanged;return 0
end event

public subroutine f_cargar_datos (string as_datawindow, string as_patron, string as_filtro, string as_titulo1, string as_titulo2);Long ll_i
String marca = "N"
String ls_codigo, ls_texto, ls_campo, tipo_columna
String ls_campo1, ls_campo2

dw_marca.Reset()

dw_proceso.DataObject = as_datawindow

dw_proceso.SetTransObject(SQLCA)					// Ayuda para cargar informacion de marcado
dw_proceso.Reset()

This.st_titulo1.text = as_titulo1
This.st_titulo2.text = as_titulo2

IF IsNull(as_patron) OR as_patron = "" THEN 
		ls_campo1 = "%"
		ls_campo2 = "%"
ELSE
		marca = "S"		// Si ponemos un patron de busqueda por defecto los marcamos
		IF ii_campo = 1 THEN 
					ls_campo1 = "%" + TRIM(as_patron) + "%"
					ls_campo2 = "%"
		ELSE
					ls_campo1 = "%"
					ls_campo2 = "%" + TRIM(as_patron) + "%"
		END IF
END IF


IF valor_empresa = FALSE THEN
	il_nummarcas = dw_proceso.Retrieve(ls_campo1,ls_campo2)
ELSE	
		// Control filtro para tabla con claves decimales o alfanumericas.			
//		tipo_columna = dw_proceso.Describe("empresa.Coltype")
//		CHOOSE CASE Lower (Left (tipo_columna,1))
//		CASE "C","c"
				dw_proceso.Retrieve(codigo_empresa,ls_campo1,ls_campo2)
//		CASE ELSE
//				dw_proceso.Retrieve(empresa_decimal,ls_campo1,ls_campo2)
//		END CHOOSE
END IF
		// Si hay algun filtro, lo pasamos	
				
IF Not IsNull(as_filtro) AND as_filtro <> "" THEN 
	
		dw_proceso.SetFilter(as_filtro)
		dw_proceso.Filter()

END IF

il_nummarcas = dw_proceso.RowCount()

IF il_nummarcas <> 0 THEN
	FOR ll_i = 1 To il_nummarcas
		ls_codigo  = dw_proceso.GetItemString(ll_i,1)
		ls_texto   = dw_proceso.GetItemString(ll_i,2)

		dw_marca.InsertRow(ll_i)
		dw_marca.setitem(ll_i,"marca",marca)
		dw_marca.setitem(ll_i,"codigo",ls_codigo)
		dw_marca.setitem(ll_i,"texto",ls_texto)
	NEXT
END IF
end subroutine

on u_marca_lista.create
this.p_buscar1=create p_buscar1
this.p_buscar2=create p_buscar2
this.dw_proceso=create dw_proceso
this.cb_desmarcar=create cb_desmarcar
this.cb_marcar=create cb_marcar
this.st_titulo2=create st_titulo2
this.st_titulo1=create st_titulo1
this.dw_marca=create dw_marca
this.Control[]={this.p_buscar1,&
this.p_buscar2,&
this.dw_proceso,&
this.cb_desmarcar,&
this.cb_marcar,&
this.st_titulo2,&
this.st_titulo1,&
this.dw_marca}
end on

on u_marca_lista.destroy
destroy(this.p_buscar1)
destroy(this.p_buscar2)
destroy(this.dw_proceso)
destroy(this.cb_desmarcar)
destroy(this.cb_marcar)

destroy(this.st_titulo2)
destroy(this.st_titulo1)
destroy(this.dw_marca)
end on

event constructor;dw_marca.height=this.height - 184
cb_marcar.y=this.height - 100
cb_desmarcar.y=this.height - 100
end event

type p_buscar1 from up_buscar within u_marca_lista
int X=0
int Y=4
int Width=69
int Height=64
boolean Visible=false
end type

type p_buscar2 from up_buscar within u_marca_lista
int X=576
int Y=8
int Width=69
int Height=64
boolean OriginalSize=false
end type

type dw_proceso from datawindow within u_marca_lista
int Y=44
int Width=768
int Height=96
int TabOrder=40
boolean Visible=false
boolean LiveScroll=true
end type

type cb_desmarcar from u_boton within u_marca_lista
int X=667
int Y=576
int Width=681
int Height=80
int TabOrder=60
string Text="&Desmarcar Todos"
end type

event clicked;long indice,total

total = dw_marca.RowCount()

for indice = 1 to total	
	if dw_marca.event itemchanged(indice,dw_marca.object.marca,"N") = 0 then
		dw_marca.setitem(indice,"marca","N")
	end if
next
end event

type cb_marcar from u_boton within u_marca_lista
int X=0
int Y=576
int Width=667
int Height=80
int TabOrder=50
string Text="&Marcar Todos"
end type

event clicked;
long indice,total

total = dw_marca.RowCount()

for indice = 1 to total	
	if dw_marca.event itemchanged(indice,dw_marca.object.marca,"S") = 0 then
		dw_marca.setitem(indice,"marca","S")
	end if
next
end event

type st_titulo2 from statictext within u_marca_lista
int X=526
int Width=823
int Height=84
int TabOrder=20
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Texto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_campo = 2			// Buscar por el segundo campo

p_buscar1.Visible = FALSE
p_buscar2.Visible = TRUE

end event

type st_titulo1 from statictext within u_marca_lista
int Width=526
int Height=84
int TabOrder=10
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Código"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
string Pointer="\BMP\MANO.CUR"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
ii_campo = 1			// Buscar por el primer campo

p_buscar1.Visible = TRUE
p_buscar2.Visible = FALSE
end event

type dw_marca from datawindow within u_marca_lista
int Y=84
int Width=1349
int Height=492
int TabOrder=30
string DataObject="dw_marca_lista"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="None!"
end type

event clicked;//integer x1
//string marca
//
//x1 = row
//IF x1<>0 THEN
//  marca=dw_marca.GetItemString(x1,"marca")
//  IF marca="S" THEN
//       dw_marca.setitem(x1,"marca","N")
//		 il_nummarcas --
//  ELSE
//       dw_marca.setitem(x1,"marca","S")
// 		 il_nummarcas ++
//  END IF
// 
//END IF
end event

event itemchanged;
return parent.event itemchanged(row,dwo,data)
end event

