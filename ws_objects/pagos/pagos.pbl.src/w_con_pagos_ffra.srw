$PBExportHeader$w_con_pagos_ffra.srw
forward
global type w_con_pagos_ffra from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_ffra
end type
type cb_consulta from u_boton within w_con_pagos_ffra
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_ffra
end type
type cb_2 from u_boton within w_con_pagos_ffra
end type
type gb_cuenta from groupbox within w_con_pagos_ffra
end type
type em_hasta from u_em_campo within w_con_pagos_ffra
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_ffra
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_ffra
end type
type em_desde from u_em_campo within w_con_pagos_ffra
end type
type pb_excel from picturebutton within w_con_pagos_ffra
end type
type cbx_detallar_agrupados from checkbox within w_con_pagos_ffra
end type
type dw_1 from datawindow within w_con_pagos_ffra
end type
type em_a_fecha from u_em_campo within w_con_pagos_ffra
end type
type gb_1 from groupbox within w_con_pagos_ffra
end type
type gb_2 from groupbox within w_con_pagos_ffra
end type
type gb_3 from groupbox within w_con_pagos_ffra
end type
type uo_1 from u_manejo_datawindow within w_con_pagos_ffra
end type
type gb_4 from groupbox within w_con_pagos_ffra
end type
end forward

global type w_con_pagos_ffra from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3643
integer height = 2096
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
cb_2 cb_2
gb_cuenta gb_cuenta
em_hasta em_hasta
ddlb_1 ddlb_1
uo_tipo2 uo_tipo2
em_desde em_desde
pb_excel pb_excel
cbx_detallar_agrupados cbx_detallar_agrupados
dw_1 dw_1
em_a_fecha em_a_fecha
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
uo_1 uo_1
gb_4 gb_4
end type
global w_con_pagos_ffra w_con_pagos_ffra

type variables
String situaciond = "0"
String situacionh = "0"
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
DateTime fdesde,fhasta,ldt_a_fecha

dw_data.reset()
uo_tipo2.visible   = FALSE
dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()
dw_data.SetFilter(f_filtro())
dw_data.Filter()

fhasta = Datetime(Date(em_hasta.text))
fdesde = Datetime(Date(em_desde.text))

ldt_a_fecha = Datetime(Date(em_a_fecha.text))

dw_data.Setredraw(False)
dw_data.Retrieve(codigo_empresa,fdesde,fhasta,situaciond,situacionh,ldt_a_fecha)
dw_data.Setredraw(True)
registros = dw_data.RowCount()

end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS POR FECHA DE FACTURA"

dw_1.Setfocus()
em_hasta.text = String(Today(),em_hasta.mask)
//fechainicio=01,year(today)
em_desde.text = String(Today(),em_desde.mask)

em_a_fecha.text = String(Today(),em_a_fecha.mask)


Integer x2,registros2
String var_codigo2,var_texto2,marca2,maxdoc = '90'
DataStore dw_comodin
dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'" + " and tipodoc < '"+maxdoc+"'")
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

ddlb_1.text = 'Pendientes'

f_activar_campo(em_desde)


end event

on w_con_pagos_ffra.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.em_hasta=create em_hasta
this.ddlb_1=create ddlb_1
this.uo_tipo2=create uo_tipo2
this.em_desde=create em_desde
this.pb_excel=create pb_excel
this.cbx_detallar_agrupados=create cbx_detallar_agrupados
this.dw_1=create dw_1
this.em_a_fecha=create em_a_fecha
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.uo_1=create uo_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.gb_cuenta
this.Control[iCurrent+6]=this.em_hasta
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.em_desde
this.Control[iCurrent+10]=this.pb_excel
this.Control[iCurrent+11]=this.cbx_detallar_agrupados
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.em_a_fecha
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.uo_1
this.Control[iCurrent+18]=this.gb_4
end on

on w_con_pagos_ffra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.em_hasta)
destroy(this.ddlb_1)
destroy(this.uo_tipo2)
destroy(this.em_desde)
destroy(this.pb_excel)
destroy(this.cbx_detallar_agrupados)
destroy(this.dw_1)
destroy(this.em_a_fecha)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.gb_4)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_ffra
integer x = 594
integer y = 792
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_ffra
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_ffra
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_ffra
integer x = 3506
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_pagos_ffra
integer x = 2610
integer y = 152
integer width = 293
integer height = 96
integer taborder = 50
string text = "&Consulta"
end type

event clicked;Dec        j,asto
DateTime   ffra
String     fra,cta

if cbx_detallar_agrupados.checked then
	dw_1.dataobject = 'dw_con_pagos_ffra_detalle_agrupados'
else
	dw_1.dataobject = 'dw_con_pagos_ffra'
end if

dw_1.settransobject(sqlca)

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

f_activar_campo(em_desde)

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_ffra
integer x = 3488
integer y = 152
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = ddlb_1.text+" "+em_desde.text+" a "+em_hasta.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_1.Object.DataWindow.Zoom = 100//75

u_imp.event ue_imprimir(dw_1)

destroy u_imp

//dw_1.Object.DataWindow.Zoom = 133//100

end event

type cb_2 from u_boton within w_con_pagos_ffra
event clicked pbm_bnclicked
integer x = 1705
integer y = 160
integer width = 293
integer height = 92
integer taborder = 40
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

end event

type gb_cuenta from groupbox within w_con_pagos_ffra
integer x = 5
integer y = 116
integer width = 695
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fechas de Factura"
end type

type em_hasta from u_em_campo within w_con_pagos_ffra
integer x = 361
integer y = 164
integer width = 325
integer height = 76
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type ddlb_1 from dropdownlistbox within w_con_pagos_ffra
integer x = 709
integer y = 160
integer width = 590
integer height = 456
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
end type

type uo_tipo2 from u_marca_lista within w_con_pagos_ffra
boolean visible = false
integer x = 645
integer y = 332
integer width = 1349
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type em_desde from u_em_campo within w_con_pagos_ffra
integer x = 18
integer y = 164
integer width = 325
integer height = 76
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type pb_excel from picturebutton within w_con_pagos_ffra
integer x = 2903
integer y = 156
integer width = 114
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom043!"
alignment htextalign = left!
end type

event clicked;string ls_nombre_fichero,ls_ruta_fichero

long ll_registros 

ll_registros = dw_1.rowcount()

if ll_registros > 0 then

	
	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
		//dw_1.SaveAs(ls_ruta_fichero, Excel!, true)
		uf_save_dw_as_excel(dw_1,ls_ruta_fichero)
		
	end if

//	if GetFileSaveName("Seleccione Archivo", ls_ruta_fichero, ls_nombre_fichero, "xls", "Archivos Excel (*.xls), *.xls") = 1 then
//		//dw_1.SaveAs(ls_ruta_fichero, Excel!, true)
//		
//		guardaraexcel2(dw_1,ls_ruta_fichero)
//	end if

end if

end event

type cbx_detallar_agrupados from checkbox within w_con_pagos_ffra
integer x = 2007
integer y = 160
integer width = 567
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detallar Agrupados"
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_con_pagos_ffra
integer x = 5
integer y = 264
integer width = 3616
integer height = 1668
string dataobject = "dw_con_pagos_ffra_detalle_agrupados"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;

str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param) 
End If
end event

event rbuttondown;Dec  asiento,ejer
Datetime fapunte,ffra
STring cta,fra
IF row = 0 or IsNUll(row) Then return


   ffra  =  dw_1.Object.ffra[row]
	fra   =  dw_1.Object.fra[row]
	cta   =  dw_1.Object.cuenta[row]
  
SELECT ejercicio,asiento,fapunte INTO :ejer,:asiento,:fapunte FROM contaapun
WHERE empresa     = :codigo_empresa
AND   ffactura   = :ffra
and   cuenta      =:cta
and   documento     =:fra
and   origen = '3';

IF IsNull(asiento) THEN asiento = 0
	


	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(ejer)
 	zstr_param.s_argumentos[3]="3"
 	zstr_param.s_argumentos[4]=string(date(fapunte))
	zstr_param.s_argumentos[5]=string(asiento)
  
  OpenWithParm(w_int_contaapun,zstr_param) 
end event

type em_a_fecha from u_em_campo within w_con_pagos_ffra
integer x = 1321
integer y = 164
integer width = 325
integer height = 76
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type gb_1 from groupbox within w_con_pagos_ffra
integer x = 2606
integer y = 116
integer width = 416
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_con_pagos_ffra
integer x = 704
integer y = 116
integer width = 603
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Situación"
end type

type gb_3 from groupbox within w_con_pagos_ffra
integer x = 1312
integer y = 116
integer width = 343
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "A Fecha"
end type

type uo_1 from u_manejo_datawindow within w_con_pagos_ffra
integer x = 3013
integer y = 108
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type gb_4 from groupbox within w_con_pagos_ffra
integer x = 1659
integer y = 116
integer width = 942
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Opciones"
end type

