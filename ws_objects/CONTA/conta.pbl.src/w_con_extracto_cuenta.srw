$PBExportHeader$w_con_extracto_cuenta.srw
$PBExportComments$€
forward
global type w_con_extracto_cuenta from w_int_con_empresa
end type
type gb_3 from groupbox within w_con_extracto_cuenta
end type
type pb_2 from upb_salir within w_con_extracto_cuenta
end type
type em_fechadesde from u_em_campo within w_con_extracto_cuenta
end type
type gb_1 from groupbox within w_con_extracto_cuenta
end type
type cb_consulta from u_boton within w_con_extracto_cuenta
end type
type em_fechahasta from u_em_campo within w_con_extracto_cuenta
end type
type st_1 from statictext within w_con_extracto_cuenta
end type
type cb_concepto from u_boton within w_con_extracto_cuenta
end type
type dw_listado from datawindow within w_con_extracto_cuenta
end type
type gb_2 from groupbox within w_con_extracto_cuenta
end type
type pb_imprimir_preli from picturebutton within w_con_extracto_cuenta
end type
type uo_1 from u_manejo_datawindow within w_con_extracto_cuenta
end type
type rb_si from radiobutton within w_con_extracto_cuenta
end type
type rb_no from radiobutton within w_con_extracto_cuenta
end type
type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta
end type
type dw_proceso2 from datawindow within w_con_extracto_cuenta
end type
type dw_1 from datawindow within w_con_extracto_cuenta
end type
type uo_cuenta from u_em_campo within w_con_extracto_cuenta
end type
type st_nom from statictext within w_con_extracto_cuenta
end type
type gb_cuenta from groupbox within w_con_extracto_cuenta
end type
end forward

global type w_con_extracto_cuenta from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2921
integer height = 2964
string title = "Consulta de Movimientos"
gb_3 gb_3
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
cb_concepto cb_concepto
dw_listado dw_listado
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
rb_si rb_si
rb_no rb_no
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
uo_cuenta uo_cuenta
st_nom st_nom
gb_cuenta gb_cuenta
end type
global w_con_extracto_cuenta w_con_extracto_cuenta

type variables
String ante_articulo,retrasos
Long  anyo
int inst_orden
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
tipo_array debe_haber
Datetime fechad,fechah
integer ejer
dec{2} debe,haber,saldo_inicial
integer ini
string con[100]
Integer numero,i,j=0

dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
uo_tipo2.visible  = FALSE


numero = uo_tipo2.dw_marca.RowCount()
IF numero <> 0  Then 
	FOR i = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(i,"marca") = "S" THEN
      j=j+1
		con[j]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
		END IF
	NEXT
	IF j=0 THEN
		FOR i = 1 To numero
   		con[i]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
			j=numero
		NEXT
		
	END IF
	FOR i = j+1 TO 100
		con[i]=""
	NEXT
END IF
	
fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))

if rb_si.checked=true then
	debe_haber=f_debe_haber_iniciales_nuevo(codigo_empresa,uo_cuenta.text,fechad,fechah)
	debe=dec(debe_haber.valor[1])
	haber=dec(debe_haber.valor[2])
	saldo_inicial=debe - haber
	ini=1
else
	debe=0
	haber=0
	saldo_inicial=0
	ini=0
end if

//dw_data.SetFilter(f_filtro())
//dw_data.Filter()
registros = dw_data.Retrieve(codigo_empresa,fechad,fechah,uo_cuenta.text,debe,haber,saldo_inicial,ini,con)

If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " EXTRACTO DE UNA CUENTA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"codigo")
  var_texto2   = dw_proceso2.GetItemString(x2,"descripcion")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Concepto"
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(em_fechadesde)
// Por defecto se ordena por fapunte
inst_orden = 1


end event

on w_con_extracto_cuenta.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.cb_concepto=create cb_concepto
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.rb_si=create rb_si
this.rb_no=create rb_no
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.uo_cuenta=create uo_cuenta
this.st_nom=create st_nom
this.gb_cuenta=create gb_cuenta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_concepto
this.Control[iCurrent+9]=this.dw_listado
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.pb_imprimir_preli
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.rb_si
this.Control[iCurrent+14]=this.rb_no
this.Control[iCurrent+15]=this.uo_tipo2
this.Control[iCurrent+16]=this.dw_proceso2
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.uo_cuenta
this.Control[iCurrent+19]=this.st_nom
this.Control[iCurrent+20]=this.gb_cuenta
end on

on w_con_extracto_cuenta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.cb_concepto)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.rb_si)
destroy(this.rb_no)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.uo_cuenta)
destroy(this.st_nom)
destroy(this.gb_cuenta)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_con_extracto_cuenta = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_extracto_cuenta
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_extracto_cuenta
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_extracto_cuenta
integer y = 20
integer width = 2642
end type

type gb_3 from groupbox within w_con_extracto_cuenta
integer x = 1979
integer y = 152
integer width = 274
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Iniciales"
end type

type pb_2 from upb_salir within w_con_extracto_cuenta
integer x = 2725
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_con_extracto_cuenta
integer x = 41
integer y = 224
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;anyo=year(date(em_fechadesde.text))
end event

type gb_1 from groupbox within w_con_extracto_cuenta
integer x = 5
integer y = 152
integer width = 658
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_extracto_cuenta
integer x = 2565
integer y = 152
integer width = 283
integer height = 72
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

if rb_si.checked=true then
	dw_1.Object.DataWindow.header.Height = 185
else
	dw_1.Object.DataWindow.header.Height = 81
end if
	
dw_1.visible   = TRUE
end event

type em_fechahasta from u_em_campo within w_con_extracto_cuenta
integer x = 361
integer y = 224
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_extracto_cuenta
integer x = 320
integer y = 204
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_concepto from u_boton within w_con_extracto_cuenta
event clicked pbm_bnclicked
integer x = 2290
integer y = 152
integer width = 274
integer height = 72
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Tipos"
end type

event clicked;call super::clicked;dw_1.visible=false
uo_tipo2.visible=true
end event

type dw_listado from datawindow within w_con_extracto_cuenta
boolean visible = false
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_con_extracto_cuenta"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_extracto_cuenta
integer x = 2277
integer y = 116
integer width = 585
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_con_extracto_cuenta
integer x = 2738
integer y = 252
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)

// Si se ha cambiado el orden pulsando sobre dw_1 
if inst_orden = 2 then
	dw_listado.setsort("ffactura")
	dw_listado.sort()
end if


Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type uo_1 from u_manejo_datawindow within w_con_extracto_cuenta
integer x = 2263
integer y = 208
integer width = 608
integer height = 160
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type rb_si from radiobutton within w_con_extracto_cuenta
integer x = 2039
integer y = 204
integer width = 142
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sí"
boolean checked = true
end type

type rb_no from radiobutton within w_con_extracto_cuenta
integer x = 2039
integer y = 260
integer width = 142
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No"
end type

type uo_tipo2 from u_marca_lista within w_con_extracto_cuenta
boolean visible = false
integer x = 1435
integer y = 364
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_con_extracto_cuenta
boolean visible = false
integer x = 530
integer y = 24
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_extracto_cuenta
boolean visible = false
integer y = 356
integer width = 2857
integer height = 2432
string dataobject = "dw_con_extracto_cuenta"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row = 0 then return
	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
  
  OpenWithParm(w_int_contaapun,zstr_param) 


end event

event clicked;if dwo.name = "fdoc" then

	dw_1.setsort("ffactura")
	dw_1.sort()
	inst_orden = 2
end if


if dwo.name = "fechmov_t" then
	
	dw_1.setsort("fapunte")
	dw_1.sort()
	inst_orden = 1	
end if
end event

type uo_cuenta from u_em_campo within w_con_extracto_cuenta
integer x = 686
integer y = 224
integer width = 416
integer taborder = 30
fontcharset fontcharset = ansi!
string mask = "!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"

//ue_filtro     = "ejercicio = "+string(anyo,"####")+" "
ue_filtro     = "ejercicio = "+string(year (date(em_fechadesde.text)))+" "



end event

event modificado;call super::modificado;//st_nom.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,uo_cuenta.text)
st_nom.text=f_nombre_contaplan(year(date(em_fechadesde.text)),codigo_empresa,uo_cuenta.text)
If Trim(st_nom.text)="" then
	st_nom.text=""
	uo_cuenta.text=""
	Return
end if 


end event

type st_nom from statictext within w_con_extracto_cuenta
integer x = 1106
integer y = 224
integer width = 850
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_cuenta from groupbox within w_con_extracto_cuenta
integer x = 672
integer y = 152
integer width = 1303
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

