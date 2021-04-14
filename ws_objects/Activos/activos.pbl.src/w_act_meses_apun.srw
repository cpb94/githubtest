$PBExportHeader$w_act_meses_apun.srw
forward
global type w_act_meses_apun from w_int_con_empresa
end type
type cb_1 from u_aceptar within w_act_meses_apun
end type
type cb_2 from u_boton within w_act_meses_apun
end type
type dw_1 from u_datawindow within w_act_meses_apun
end type
type pb_1 from upb_imprimir within w_act_meses_apun
end type
type dw_listado from datawindow within w_act_meses_apun
end type
end forward

global type w_act_meses_apun from w_int_con_empresa
integer x = 55
integer y = 392
integer width = 2853
integer height = 972
boolean resizable = true
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
pb_1 pb_1
dw_listado dw_listado
end type
global w_act_meses_apun w_act_meses_apun

type variables
String	empresa,ejercicio
end variables

on w_act_meses_apun.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.pb_1=create pb_1
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.dw_listado
end on

on w_act_meses_apun.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.dw_listado)
end on

event open;call super::open;DataStore	ds_tmp_apun
Integer		rr,xx
String		cadena

x = 55
y = 400


istr_parametros.s_titulo_ventana = "VISUALIZACION DEL ASIENTO RESUMIDO" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana
If istr_parametros.i_nargumentos >0 then 
	empresa = istr_parametros.s_argumentos[1] 
	ejercicio = istr_parametros.s_argumentos[2]
//	em_fconta.text = istr_parametros.s_argumentos[3]
End If

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)


ds_tmp_apun = CREATE DataStore
ds_tmp_apun.DataObject = "ds_act_tmp_apun"
ds_tmp_apun.SetTransObject(sqlca)
ds_tmp_apun.Retrieve()

rr = ds_tmp_apun.RowCount()

//f_mensaje("debug",string(rr) + " registros")

For xx = 1 to rr
	dw_1.InsertRow(1)
	dw_1.SetItem(1,"empresa",empresa)
	dw_1.SetItem(1,"codigo",Dec(ds_tmp_apun.Object.codigo[xx]))
	If isnull(ds_tmp_apun.Object.ampliacion[xx]) then
		cadena = f_nombre_contaplan(Dec(ejercicio),empresa,String(ds_tmp_apun.Object.cuenta[xx]))
	Else
		cadena = Trim(ds_tmp_apun.Object.ampliacion[xx]) 
	End If
	dw_1.SetItem(1,"desc_cuenta",cadena)
	dw_1.SetItem(1,"num_cuenta",String(ds_tmp_apun.Object.cuenta[xx]))
	dw_1.SetItem(1,"debe",ds_tmp_apun.GetItemDecimal(xx,"debe"))
	dw_1.SetItem(1,"haber",ds_tmp_apun.GetItemDecimal(xx,"haber"))
//	f_mensaje("debug",trim(ds_tmp_apun.GetItemString(xx,"cuenta")) + char(13) +&
//				String(ds_tmp_apun.Object.debe[xx]) + char(13) +&
//				String(ds_tmp_apun.Object.haber[xx]))
Next

dw_1.Sort()

Destroy ds_tmp_apun
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_act_meses_apun
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_act_meses_apun
end type

type st_empresa from w_int_con_empresa`st_empresa within w_act_meses_apun
end type

type cb_1 from u_aceptar within w_act_meses_apun
integer x = 1769
integer y = 208
integer height = 92
integer taborder = 40
end type

event clicked;DateTime	fechacon
Str_parametros	str_param

//fechacon = DateTime(Date(em_fconta.text))
//
//IF not f_control_fecha_apunte(codigo_empresa,Dec(ejercicio),fechacon) then
//	f_mensaje("ERROR","FECHA CONTABLE NO ACCESIBLE")
//	em_fconta.SetFocus()  
//	Return
//END IF

str_param.i_nargumentos = 2
str_param.s_argumentos[1]= '1'
//str_param.s_argumentos[2] = em_fconta.text

CloseWithReturn(Parent,str_param)
end event

type cb_2 from u_boton within w_act_meses_apun
integer x = 2208
integer y = 208
integer height = 92
integer taborder = 30
string text = "&Salir"
end type

event clicked;Str_parametros	str_param

str_param.i_nargumentos = 1
str_param.s_argumentos[1]= '0'


CloseWithReturn(Parent,str_param)
end event

type dw_1 from u_datawindow within w_act_meses_apun
integer x = 18
integer y = 336
integer width = 2761
integer height = 496
integer taborder = 10
string dataobject = "dw_con_apun"
boolean vscrollbar = true
end type

type pb_1 from upb_imprimir within w_act_meses_apun
integer x = 2656
integer y = 208
integer width = 123
integer height = 104
integer taborder = 20
boolean bringtotop = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;DataStore	ds_tmp_apun
Integer		rr,xx
String		cadena

ds_tmp_apun = CREATE DataStore
ds_tmp_apun.DataObject = "ds_act_tmp_apun"
ds_tmp_apun.SetTransObject(sqlca)
ds_tmp_apun.Retrieve()

rr = ds_tmp_apun.RowCount()

For xx = 1 to rr
	dw_listado.InsertRow(1)
	dw_listado.SetItem(1,"empresa",empresa)
	dw_listado.SetItem(1,"codigo",Dec(ds_tmp_apun.Object.codigo[xx]))
	If isnull(ds_tmp_apun.Object.ampliacion[xx]) then
		cadena = f_nombre_contaplan(Dec(ejercicio),empresa,String(ds_tmp_apun.Object.cuenta[xx]))
	Else
		cadena = Trim(ds_tmp_apun.Object.ampliacion[xx]) 
	End If
	dw_listado.SetItem(1,"desc_cuenta",cadena)
	dw_listado.SetItem(1,"num_cuenta",String(ds_tmp_apun.Object.cuenta[xx]))
	dw_listado.SetItem(1,"debe",ds_tmp_apun.GetItemDecimal(xx,"debe"))
	dw_listado.SetItem(1,"haber",ds_tmp_apun.GetItemDecimal(xx,"haber"))
Next

dw_listado.Sort()

Destroy ds_tmp_apun

f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_act_meses_apun
boolean visible = false
integer x = 1097
integer y = 160
integer width = 229
integer height = 160
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_con_apun_provis"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

