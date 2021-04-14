$PBExportHeader$u_marca_lista_old.sru
$PBExportComments$Objeco de marcar y desmarcar datos relacionados.
forward
global type u_marca_lista_old from userobject
end type
type p_buscar1 from up_buscar within u_marca_lista_old
end type
type p_buscar2 from up_buscar within u_marca_lista_old
end type
type dw_proceso from datawindow within u_marca_lista_old
end type
type cb_desmarcar from u_boton within u_marca_lista_old
end type
type cb_marcar from u_boton within u_marca_lista_old
end type
type st_titulo2 from statictext within u_marca_lista_old
end type
type st_titulo1 from statictext within u_marca_lista_old
end type
type dw_marca from datawindow within u_marca_lista_old
end type
end forward

global type u_marca_lista_old from userobject
integer width = 1353
integer height = 660
boolean border = true
long backcolor = 12632256
long tabtextcolor = 33554432
p_buscar1 p_buscar1
p_buscar2 p_buscar2
dw_proceso dw_proceso
cb_desmarcar cb_desmarcar
cb_marcar cb_marcar
st_titulo2 st_titulo2
st_titulo1 st_titulo1
dw_marca dw_marca
end type
global u_marca_lista_old u_marca_lista_old

type variables
Integer   ii_campo = 2            // Campo filtro para buscar
Long      il_nummarcas = 0    // Numero de registros marcados
end variables

forward prototypes
public subroutine f_cargar_datos (string as_datawindow, string as_patron, string as_filtro, string as_titulo1, string as_titulo2)
end prototypes

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
		tipo_columna = dw_proceso.Describe("empresa.Coltype")
		CHOOSE CASE Lower (Left (tipo_columna,1))
		CASE "C","c"
				dw_proceso.Retrieve(codigo_empresa,ls_campo1,ls_campo2)
		CASE ELSE
				dw_proceso.Retrieve(empresa_decimal,ls_campo1,ls_campo2)
		END CHOOSE
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

on u_marca_lista_old.create
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

on u_marca_lista_old.destroy
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

type p_buscar1 from up_buscar within u_marca_lista_old
boolean visible = false
integer y = 4
integer width = 69
end type

type p_buscar2 from up_buscar within u_marca_lista_old
integer x = 576
integer y = 8
integer width = 69
boolean originalsize = false
end type

type dw_proceso from datawindow within u_marca_lista_old
boolean visible = false
integer y = 44
integer width = 768
integer height = 96
integer taborder = 40
boolean livescroll = true
end type

type cb_desmarcar from u_boton within u_marca_lista_old
integer x = 667
integer y = 576
integer width = 681
integer height = 80
integer taborder = 60
string text = "&Desmarcar Todos"
end type

event clicked;call super::clicked;integer li_x, li_y

li_y = dw_marca.RowCount()
IF li_y = 0 THEN  Return

FOR li_x = 1 TO li_y
	dw_marca.setitem(li_x,"marca","N")
NEXT

il_nummarcas = 0
end event

type cb_marcar from u_boton within u_marca_lista_old
integer y = 576
integer width = 667
integer height = 80
integer taborder = 50
string text = "&Marcar Todos"
end type

event clicked;call super::clicked;
integer li_x

il_nummarcas = dw_marca.RowCount()
IF il_nummarcas = 0 THEN  Return

FOR li_x = 1 TO il_nummarcas
		dw_marca.setitem(li_x,"marca","S")
NEXT
end event

type st_titulo2 from statictext within u_marca_lista_old
integer x = 526
integer width = 823
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Texto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;ii_campo = 2			// Buscar por el segundo campo

p_buscar1.Visible = FALSE
p_buscar2.Visible = TRUE

end event

type st_titulo1 from statictext within u_marca_lista_old
integer width = 526
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\MANO.CUR"
long backcolor = 12632256
string text = "Código"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
ii_campo = 1			// Buscar por el primer campo

p_buscar1.Visible = TRUE
p_buscar2.Visible = FALSE
end event

type dw_marca from datawindow within u_marca_lista_old
integer y = 84
integer width = 1349
integer height = 492
integer taborder = 30
string dataobject = "dw_marca_lista"
boolean vscrollbar = true
string icon = "None!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;integer x1
string marca

x1 = row
IF x1<>0 THEN
  marca=dw_marca.GetItemString(x1,"marca")
  IF marca="S" THEN
       dw_marca.setitem(x1,"marca","N")
		 il_nummarcas --
  ELSE
       dw_marca.setitem(x1,"marca","S")
 		 il_nummarcas ++
  END IF
 
END IF
end event

