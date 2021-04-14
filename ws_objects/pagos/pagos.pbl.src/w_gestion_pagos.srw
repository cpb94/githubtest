$PBExportHeader$w_gestion_pagos.srw
$PBExportComments$€
forward
global type w_gestion_pagos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_gestion_pagos
end type
type cb_consulta from u_boton within w_gestion_pagos
end type
type gb_7 from groupbox within w_gestion_pagos
end type
type gb_22 from groupbox within w_gestion_pagos
end type
type gb_2 from groupbox within w_gestion_pagos
end type
type cb_2 from u_boton within w_gestion_pagos
end type
type gb_cuenta from groupbox within w_gestion_pagos
end type
type ddlb_1 from dropdownlistbox within w_gestion_pagos
end type
type em_fdesde from editmask within w_gestion_pagos
end type
type em_fhasta from editmask within w_gestion_pagos
end type
type st_2 from statictext within w_gestion_pagos
end type
type st_3 from statictext within w_gestion_pagos
end type
type dw_1 from u_datawindow within w_gestion_pagos
end type
type cb_1 from commandbutton within w_gestion_pagos
end type
type uo_proveedor from u_em_campo_2 within w_gestion_pagos
end type
type uo_tipo2 from u_marca_lista within w_gestion_pagos
end type
type pb_1 from picturebutton within w_gestion_pagos
end type
end forward

global type w_gestion_pagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3648
integer height = 2272
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
gb_7 gb_7
gb_22 gb_22
gb_2 gb_2
cb_2 cb_2
gb_cuenta gb_cuenta
ddlb_1 ddlb_1
em_fdesde em_fdesde
em_fhasta em_fhasta
st_2 st_2
st_3 st_3
dw_1 dw_1
cb_1 cb_1
uo_proveedor uo_proveedor
uo_tipo2 uo_tipo2
pb_1 pb_1
end type
global w_gestion_pagos w_gestion_pagos

type variables
String situaciond,situacionh
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,x2
String filtro,filtro1

filtro = ""
numero = uo_tipo2.dw_marca.RowCount()
IF  numero =0 Then return ""
FOR x2 = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	IF Trim(filtro) = "" Then
         	filtro1 = " tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " Or tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
String pro1,pro2
string is_filtro=""
Datetime fdesde,fhasta
string proveedor 

dw_data.reset()
uo_tipo2.visible   = FALSE

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()
dw_data.SetFilter(f_filtro())
dw_data.Filter()

fdesde = datetime(date(em_fdesde.text))
fhasta = datetime(date(em_fhasta.text))

if uo_proveedor.em_codigo.text = ""  or isnull(uo_proveedor.em_codigo.text) then
	proveedor = '%'	
else
	proveedor = uo_proveedor.em_codigo.text
end if

dw_data.Retrieve(codigo_empresa,situaciond,situacionh,fdesde,fhasta, proveedor)


end subroutine

event open;call super::open;String mascara
Integer x2,registros2 
String var_codigo2,var_texto2,marca2
DataStore dw_comodin

dw_1.SetTransObject(sqlca)
This.title = " CONSULTA PAGOS GLOBAL"
dw_1.Setfocus()

//dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'")
f_cargar_cursor_nuevo("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'", dw_comodin)
registros2=dw_comodin.RowCOunt()
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_comodin.GetItemString(x2,"tipodoc")
  var_texto2   = dw_comodin.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"
em_fdesde.text = string(today())
em_fhasta.text = string(today())
situaciond = "0"
situacionh = "0"
ddlb_1.text = "Pendientes"
f_activar_campo(em_fdesde)

destroy dw_comodin


end event

on w_gestion_pagos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.gb_7=create gb_7
this.gb_22=create gb_22
this.gb_2=create gb_2
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.ddlb_1=create ddlb_1
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_proveedor=create uo_proveedor
this.uo_tipo2=create uo_tipo2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.gb_7
this.Control[iCurrent+4]=this.gb_22
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.gb_cuenta
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.em_fdesde
this.Control[iCurrent+10]=this.em_fhasta
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.uo_proveedor
this.Control[iCurrent+16]=this.uo_tipo2
this.Control[iCurrent+17]=this.pb_1
end on

on w_gestion_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.gb_7)
destroy(this.gb_22)
destroy(this.gb_2)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.ddlb_1)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_proveedor)
destroy(this.uo_tipo2)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_gestion_pagos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_gestion_pagos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_gestion_pagos
integer x = 18
integer y = 12
integer width = 3287
integer height = 84
integer textsize = -12
boolean italic = true
long textcolor = 8388608
end type

type pb_2 from upb_salir within w_gestion_pagos
integer x = 3461
integer y = 20
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_gestion_pagos
integer x = 2944
integer y = 156
integer width = 297
integer height = 108
integer taborder = 80
string text = "&Consulta"
end type

event clicked;
CHOOSE CASE ddlb_1.text
	CASE "Pendientes"
		situaciond = '0'
		situacionh = '0'
	CASE "Emitidos"
		situaciond = '1'
		situacionh = '1'
	CASE "Pagados"
		situaciond = '2'
		situacionh = '2'
	CASE "Pendientes/Emitidos"
		situaciond = '0'
		situacionh = '1'
	CASE "Todos"
		situaciond = '0'
		situacionh = '2'
END CHOOSE

f_cargar(dw_1)
if dw_1.rowcount() = 0 then
	messagebox("Atención","No hay datos")
	f_activar_campo(em_fdesde)
else
	dw_1.setfocus()
	dw_1.setrow(1)
	dw_1.scrolltorow(1)
end if

end event

type gb_7 from groupbox within w_gestion_pagos
integer x = 1056
integer y = 108
integer width = 955
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proveedor"
end type

type gb_22 from groupbox within w_gestion_pagos
integer x = 3255
integer y = 116
integer width = 325
integer height = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_gestion_pagos
integer x = 2930
integer y = 116
integer width = 325
integer height = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cb_2 from u_boton within w_gestion_pagos
event clicked pbm_bnclicked
integer x = 2597
integer y = 160
integer width = 311
integer height = 96
integer taborder = 70
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;if uo_tipo2.visible then
	uo_tipo2.visible = FALSE
else
	uo_tipo2.visible = TRUE
end if

end event

type gb_cuenta from groupbox within w_gestion_pagos
integer y = 124
integer width = 1038
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type ddlb_1 from dropdownlistbox within w_gestion_pagos
integer x = 2025
integer y = 160
integer width = 544
integer height = 416
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
end type

type em_fdesde from editmask within w_gestion_pagos
integer x = 366
integer y = 164
integer width = 293
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yy"
end type

type em_fhasta from editmask within w_gestion_pagos
integer x = 718
integer y = 164
integer width = 293
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yy"
end type

type st_2 from statictext within w_gestion_pagos
integer x = 667
integer y = 168
integer width = 46
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_gestion_pagos
integer x = 27
integer y = 172
integer width = 329
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Vto :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_gestion_pagos
integer y = 288
integer width = 3579
integer height = 1752
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_gestion_pagos"
boolean vscrollbar = true
end type

event doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
CASE "carpagos_banco_recep"
	bus_datawindow = "dw_ayuda_carbancos"
	bus_titulo = "VENTANA SELECCION DE BANCOS"
CASE "carpagos_banco_envio"
	bus_datawindow = "dw_ayuda_carbancos"
	bus_titulo = "VENTANA SELECCION DE BANCOS"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key
end event

event itemchanged;if dwo.name = "carpagos_banco_recep" then
	dw_1.object.carpagos_banco_recep2[row] = f_nombre_banco_abr(codigo_empresa,data)
end if
end event

type cb_1 from commandbutton within w_gestion_pagos
integer x = 3269
integer y = 156
integer width = 297
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;long fila, columna

fila = dw_1.GetRow()
columna =dw_1.GetColumn()

if dw_1.update() = -1 then
	messagebox("Atención","Error al actualizar")
	rollback;
else
	commit;
end if
//dw_1.Reset()
dw_1.setrow(fila)
dw_1.SetColumn(fila)
dw_1.ScrollToRow(fila)
dw_1.SetFocus()
//f_activar_campo(em_fdesde)
end event

type uo_proveedor from u_em_campo_2 within w_gestion_pagos
event destroy ( )
integer x = 1074
integer y = 156
integer width = 914
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_prov

select razon
into :des_prov
from genter
where empresa = :codigo_empresa
and tipoter = 'P'
and codigo = :uo_proveedor.em_codigo.text;

uo_proveedor.em_campo.text = des_prov
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""



end event

type uo_tipo2 from u_marca_lista within w_gestion_pagos
boolean visible = false
integer x = 887
integer y = 268
integer width = 1362
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type pb_1 from picturebutton within w_gestion_pagos
integer x = 3333
integer y = 20
integer width = 110
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;f_imprimir_datawindow(dw_1)

end event

