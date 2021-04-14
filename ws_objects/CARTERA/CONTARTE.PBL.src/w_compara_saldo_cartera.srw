$PBExportHeader$w_compara_saldo_cartera.srw
forward
global type w_compara_saldo_cartera from w_int_con_empresa
end type
type pb_2 from upb_salir within w_compara_saldo_cartera
end type
type cb_1 from u_boton within w_compara_saldo_cartera
end type
type uo_tipo from u_marca_lista within w_compara_saldo_cartera
end type
type dw_proceso from datawindow within w_compara_saldo_cartera
end type
type cb_consulta from u_boton within w_compara_saldo_cartera
end type
type pb_imprimir_preli from picturebutton within w_compara_saldo_cartera
end type
type dw_listado from datawindow within w_compara_saldo_cartera
end type
type uo_tipo2 from u_marca_lista within w_compara_saldo_cartera
end type
type dw_proceso2 from datawindow within w_compara_saldo_cartera
end type
type gb_2 from groupbox within w_compara_saldo_cartera
end type
type uo_cliente from u_em_campo_2 within w_compara_saldo_cartera
end type
type cb_2 from u_boton within w_compara_saldo_cartera
end type
type gb_cuenta from groupbox within w_compara_saldo_cartera
end type
type st_1 from statictext within w_compara_saldo_cartera
end type
type uo_ejercicio from u_ejercicio within w_compara_saldo_cartera
end type
type dw_1 from datawindow within w_compara_saldo_cartera
end type
end forward

global type w_compara_saldo_cartera from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2875
integer height = 1660
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
gb_2 gb_2
uo_cliente uo_cliente
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
uo_ejercicio uo_ejercicio
dw_1 dw_1
end type
global w_compara_saldo_cartera w_compara_saldo_cartera

type variables
String ante_articulo,retrasos,isle_campo


str_paramemp em
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros,i,k,dec_moneda_emp
String cli1,cli2
string situacion[],marca


dec_moneda_emp = f_decimales_moneda(em.moneda_emp)


f_mascara_columna(dw_data,"importe_cartera",f_mascara_decimales(dec_moneda_emp))
f_mascara_columna(dw_data,"saldo_contable",f_mascara_decimales(dec_moneda_emp))
f_mascara_columna(dw_data,"resta",f_mascara_decimales(dec_moneda_emp))



dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)

k = 0
for i = 1 to uo_tipo.dw_marca.rowcount()
	marca = uo_tipo.dw_marca.getitemstring(i,"marca")
	if marca = "S" then
		k = k + 1		
		situacion[k] = uo_tipo.dw_marca.getitemstring(i,"codigo")
	end if
next


iF Trim(uo_cliente.em_codigo.text) = "" Then
   cli1 = "."
   cli2 = "Z"
ELSE
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF

Datetime fecha1,fecha2


dw_data.Retrieve(codigo_empresa,cli1,cli2,situacion)

registros = dw_data.RowCount()
If registros = 0 Then Return



string cliente,cuenta
dec saldo,ejer
ejer = dec(uo_ejercicio.em_ejercicio.text)

for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Procesando",i,dw_data.rowcount())
	
	cliente = dw_data.getitemstring(i,"cliente")
	cuenta = f_cuenta_genter(codigo_empresa,"C",cliente)
	saldo = f_saldo_cuenta_nivel5(ejer,codigo_empresa,cuenta)
	dw_data.setitem(i,"saldo_contable",saldo)


next


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE SALDO CONTABLE Y CARTERA POR CLIENTE"

dw_1.Setfocus()


Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
registros=dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"codigo")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  if var_codigo = "4" or var_codigo = "7" or var_codigo = "9" or var_codigo = "5" then 
  	  marca = "N"	
  else
     marca="S"  
  end if
  
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF



uo_tipo.st_titulo1.text="Situación"
uo_tipo.st_titulo2.text="Descripcion"


Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"tipodoc")
  var_texto2   = dw_proceso2.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(uo_cliente.em_campo)

em = f_paramemp(codigo_empresa)
end event

on w_compara_saldo_cartera.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.uo_ejercicio=create uo_ejercicio
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.uo_cliente
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.gb_cuenta
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.uo_ejercicio
this.Control[iCurrent+16]=this.dw_1
end on

on w_compara_saldo_cartera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.uo_ejercicio)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_compara_saldo_cartera
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_compara_saldo_cartera
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_compara_saldo_cartera
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_compara_saldo_cartera
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type cb_1 from u_boton within w_compara_saldo_cartera
integer x = 1317
integer y = 136
integer width = 311
integer height = 72
integer taborder = 30
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_compara_saldo_cartera
boolean visible = false
integer x = 1413
integer y = 316
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_compara_saldo_cartera
boolean visible = false
integer x = 430
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_compara_saldo_cartera
integer x = 1627
integer y = 212
integer width = 293
integer height = 72
integer taborder = 40
string text = "&Consulta"
end type

event clicked;f_cargar(dw_1)
if dw_1.rowcount() > 0 then
	dw_1.visible   = TRUE
end if
f_activar_campo(uo_cliente.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_compara_saldo_cartera
integer x = 1993
integer y = 164
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

event clicked;f_cargar(dw_listado)

f_imprimir_datawindow(dw_listado)
dw_listado.visible = FALSE

f_activar_campo(uo_cliente.em_campo)
end event

type dw_listado from datawindow within w_compara_saldo_cartera
boolean visible = false
integer x = 2574
integer width = 160
integer height = 136
string dataobject = "report_compara_saldo_cartera"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_compara_saldo_cartera
boolean visible = false
integer x = 242
integer y = 320
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_compara_saldo_cartera
boolean visible = false
integer x = 110
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_2 from groupbox within w_compara_saldo_cartera
integer x = 1298
integer y = 96
integer width = 640
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_compara_saldo_cartera
event destroy ( )
integer x = 27
integer y = 196
integer width = 1225
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"

end event

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

dw_1.Reset()
//dw_1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
end event

type cb_2 from u_boton within w_compara_saldo_cartera
event clicked pbm_bnclicked
integer x = 1317
integer y = 212
integer width = 311
integer height = 72
integer taborder = 20
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type gb_cuenta from groupbox within w_compara_saldo_cartera
integer y = 96
integer width = 1294
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_compara_saldo_cartera
integer x = 27
integer y = 144
integer width = 1225
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "C  l  i  e  n  t  e"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_compara_saldo_cartera
event destroy ( )
integer x = 2190
integer y = 160
integer height = 276
integer taborder = 40
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_1 from datawindow within w_compara_saldo_cartera
boolean visible = false
integer x = 59
integer y = 300
integer width = 2725
integer height = 1116
boolean bringtotop = true
string dataobject = "dw_compara_saldo_cartera"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

