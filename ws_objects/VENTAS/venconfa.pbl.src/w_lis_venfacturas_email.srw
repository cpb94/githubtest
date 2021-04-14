$PBExportHeader$w_lis_venfacturas_email.srw
forward
global type w_lis_venfacturas_email from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_venfacturas_email
end type
type em_fecha1 from u_em_campo within w_lis_venfacturas_email
end type
type em_fecha2 from u_em_campo within w_lis_venfacturas_email
end type
type dw_proceso from datawindow within w_lis_venfacturas_email
end type
type dw_preliminar from datawindow within w_lis_venfacturas_email
end type
type em_copias1 from editmask within w_lis_venfacturas_email
end type
type cb_2 from u_boton within w_lis_venfacturas_email
end type
type st_13 from statictext within w_lis_venfacturas_email
end type
type uo_1 from u_selec_impresoras within w_lis_venfacturas_email
end type
type st_6 from statictext within w_lis_venfacturas_email
end type
type cabecera from dropdownlistbox within w_lis_venfacturas_email
end type
type gb_4 from groupbox within w_lis_venfacturas_email
end type
type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas_email
end type
type cb_1 from commandbutton within w_lis_venfacturas_email
end type
type dw_1 from datawindow within w_lis_venfacturas_email
end type
type uo_adv from u_em_campo_2 within w_lis_venfacturas_email
end type
type uo_cliente from u_em_campo_2 within w_lis_venfacturas_email
end type
type p_1 from picture within w_lis_venfacturas_email
end type
type gb_1 from groupbox within w_lis_venfacturas_email
end type
type gb_2 from groupbox within w_lis_venfacturas_email
end type
type gb_3 from groupbox within w_lis_venfacturas_email
end type
end forward

global type w_lis_venfacturas_email from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4283
integer height = 3276
pb_1 pb_1
em_fecha1 em_fecha1
em_fecha2 em_fecha2
dw_proceso dw_proceso
dw_preliminar dw_preliminar
em_copias1 em_copias1
cb_2 cb_2
st_13 st_13
uo_1 uo_1
st_6 st_6
cabecera cabecera
gb_4 gb_4
cbx_declaracion_entrada_entrega_intracom cbx_declaracion_entrada_entrega_intracom
cb_1 cb_1
dw_1 dw_1
uo_adv uo_adv
uo_cliente uo_cliente
p_1 p_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_lis_venfacturas_email w_lis_venfacturas_email

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 28
integer lnpie,contador,var_tipo
Integer reg,reg1,ante_anyo_albaran
Dec ante_albaran,var_anyo,v_anyo_albaran,v_albaran,var_factura
DateTime v_falbaran,var_ffactura
String  cc = "1"
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Facturas entre fechas"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
em_fecha1.text = String(Today(),"dd-mm-yy")
em_fecha2.text = String(Today(),"dd-mm-yy")
var_tipo = 1

cabecera.text = "Si"
istr_parametros = Message.PowerObjectParm
//f_activar_campo(em_serie)




end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_lis_venfacturas_email.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_fecha1=create em_fecha1
this.em_fecha2=create em_fecha2
this.dw_proceso=create dw_proceso
this.dw_preliminar=create dw_preliminar
this.em_copias1=create em_copias1
this.cb_2=create cb_2
this.st_13=create st_13
this.uo_1=create uo_1
this.st_6=create st_6
this.cabecera=create cabecera
this.gb_4=create gb_4
this.cbx_declaracion_entrada_entrega_intracom=create cbx_declaracion_entrada_entrega_intracom
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_adv=create uo_adv
this.uo_cliente=create uo_cliente
this.p_1=create p_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_fecha1
this.Control[iCurrent+3]=this.em_fecha2
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.dw_preliminar
this.Control[iCurrent+6]=this.em_copias1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_13
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.cabecera
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.cbx_declaracion_entrada_entrega_intracom
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.dw_1
this.Control[iCurrent+16]=this.uo_adv
this.Control[iCurrent+17]=this.uo_cliente
this.Control[iCurrent+18]=this.p_1
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_3
end on

on w_lis_venfacturas_email.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_fecha1)
destroy(this.em_fecha2)
destroy(this.dw_proceso)
destroy(this.dw_preliminar)
destroy(this.em_copias1)
destroy(this.cb_2)
destroy(this.st_13)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.cabecera)
destroy(this.gb_4)
destroy(this.cbx_declaracion_entrada_entrega_intracom)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_adv)
destroy(this.uo_cliente)
destroy(this.p_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_venfacturas_email
integer taborder = 130
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_venfacturas_email
end type

type st_empresa from w_int_con_empresa`st_empresa within w_lis_venfacturas_email
integer x = 14
integer y = 8
integer width = 3570
integer height = 84
end type

type pb_1 from upb_salir within w_lis_venfacturas_email
integer x = 4096
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type em_fecha1 from u_em_campo within w_lis_venfacturas_email
integer x = 2619
integer y = 176
integer width = 279
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_fecha2 from u_em_campo within w_lis_venfacturas_email
integer x = 2935
integer y = 176
integer width = 293
integer taborder = 40
string text = "    "
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

type dw_proceso from datawindow within w_lis_venfacturas_email
boolean visible = false
integer x = 2624
integer y = 40
integer width = 494
integer height = 60
boolean bringtotop = true
string dataobject = "dw_proceso_venlifac_dto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_preliminar from datawindow within w_lis_venfacturas_email
boolean visible = false
integer x = 46
integer y = 432
integer width = 3685
integer height = 2588
boolean bringtotop = true
string dataobject = "report_list_venfacturas1"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_copias1 from editmask within w_lis_venfacturas_email
boolean visible = false
integer x = 2423
integer y = 316
integer width = 174
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string displaydata = " ~v¼~rpbedit050"
double increment = 1
end type

event getfocus;this.selectText(1,2)
end event

type cb_2 from u_boton within w_lis_venfacturas_email
event clicked pbm_bnclicked
integer x = 3726
integer y = 164
integer width = 320
integer height = 96
integer taborder = 60
string text = "Enviar"
end type

event clicked;if messagebox("ATENCION", "Se generarán las facturas seleccionadas en PDF y se enviarán a los mails respectivos.~n¿Está seguro?", question!, yesno!, 2) = 2 then return


long i
string email, factura, cliente

for i = 1 to dw_1.rowcount()
	
	if dw_1.object.enviar[i] = 'S' then
		
		factura = string(dw_1.object.factura[i])
		cliente = dw_1.object.cliente[i]
		email   = dw_1.object.email[i]
		
		messagebox("", factura + "~n" + cliente + "~n" + email)
		
	end if
	
next



return

messagebox("", "QUE HACES!!!")

return

DateTime fecha1,fecha2
String   sel,cri
Dec r,r1,anyo,fra

//IF Trim(em_serie.text) = "" Then
//	f_mensaje("Campo Obligarorio","Introduzca la serie")
//	f_activar_campo(em_serie)
//	Return
//END IF

dw_preliminar.DataObject = "report_list_venfacturas1"
dw_preliminar.visible= FALSE
IF em_copias1.text = "0" or Trim(em_copias1.text) = "" Then
	em_copias1.text = "1"
END IF



fecha1 = DateTime(date(em_fecha1.text))
fecha2 = DateTime(date(em_fecha2.text))

//IF integer(em_fra1.text) = 0  and integer(em_fra2.text) = 0 Then
//	cri = ""
//ELSE
//	cri = " And    factura >= "+String(Dec(em_fra1.text),"#######0")+" and factura <="+String(Dec(em_fra2.text),"######0")
//END IF
sel = " Select anyo,factura From venfac " + &
      " Where  "+&
		" And    empresa ='"+codigo_empresa + "'"+&
		" And    ffactura >= '"+String(Date(fecha1),"dd/mm/yyyy")+"' and ffactura <='"+String(Date(fecha2),"dd/mm/yyyy")+"'" + &
		cri +&	
		" Order By anyo,factura"
DataStore  dw
//dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
r1 = dw.RowCOunt()
dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
iF r1 = 0 Then 
	destroy dw
	Return
end if
For r = 1 to r1
	//yield()
	anyo = dw.getItemNumber(r,"anyo")
	fra = dw.getItemNumber(r,"factura")
	f_mensaje_proceso("Fra: " + STring(fra,f_mascara_decimales(0)),r,r1)
	
	str_parametros lstr_param
	lstr_param.i_nargumentos   = 8
	lstr_param.s_argumentos[2] = String(anyo,"#######")
	lstr_param.s_argumentos[3] = String(fra,"##########")
	lstr_param.s_argumentos[4] = cabecera.text
	lstr_param.s_argumentos[5] = em_copias1.text
	lstr_param.s_argumentos[6] = uo_1.sle_impresora.text
	lstr_param.s_argumentos[7] = "N"

		
	if cbx_declaracion_entrada_entrega_intracom.checked then
		lstr_param.s_argumentos[8] = "S"
	else
		lstr_param.s_argumentos[8] = "N"
	end if
		
	//OpenWithParm(w_lis_venfacturas,lstr_param)
NEXT


f_activar_campo(em_fecha1)

destroy dw
end event

type st_13 from statictext within w_lis_venfacturas_email
boolean visible = false
integer x = 2629
integer y = 320
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera:"
boolean focusrectangle = false
end type

type uo_1 from u_selec_impresoras within w_lis_venfacturas_email
boolean visible = false
integer x = 46
integer y = 288
integer width = 1403
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type st_6 from statictext within w_lis_venfacturas_email
boolean visible = false
integer x = 2158
integer y = 324
integer width = 256
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cabecera from dropdownlistbox within w_lis_venfacturas_email
boolean visible = false
integer x = 2898
integer y = 312
integer width = 247
integer height = 228
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Sí","No"}
end type

type gb_4 from groupbox within w_lis_venfacturas_email
boolean visible = false
integer x = 1458
integer y = 252
integer width = 2295
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cbx_declaracion_entrada_entrega_intracom from checkbox within w_lis_venfacturas_email
boolean visible = false
integer x = 1477
integer y = 312
integer width = 727
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Declaracion Entrega Intr."
end type

type cb_1 from commandbutton within w_lis_venfacturas_email
integer x = 3351
integer y = 160
integer width = 315
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consultar"
end type

event clicked;DateTime fecha1,fecha2
String   sel,cri
Dec r,r1,anyo,fra

//IF Trim(em_serie.text) = "" Then
//	f_mensaje("Campo Obligarorio","Introduzca la serie")
//	f_activar_campo(em_serie)
//	Return
//END IF

fecha1 = DateTime(date(em_fecha1.text))
fecha2 = DateTime(date(em_fecha2.text))

string cliente, adv

if uo_cliente.em_codigo.text = '' then 
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text
end if

if uo_adv.em_codigo.text = '' then 
	adv = '%'
else
	adv = uo_adv.em_codigo.text
end if

dw_1.retrieve(codigo_empresa, cliente, adv, fecha1, fecha2)
end event

type dw_1 from datawindow within w_lis_venfacturas_email
integer x = 32
integer y = 308
integer width = 4210
integer height = 2776
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "dw_envio_email_facturas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_adv from u_em_campo_2 within w_lis_venfacturas_email
event destroy ( )
integer x = 1385
integer y = 176
integer width = 1088
integer height = 76
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_adv.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;//dw_1.Reset()
//dw_detalle.Reset()
em_campo.text = f_nombre_ven_adv(codigo_empresa, em_codigo.text)

If Trim(em_campo.text)="" then
	em_campo.text=""
	em_codigo.text=""
	Return
end if 

//dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de ADV"
	ue_datawindow ="dw_ayuda_ven_adv"
	ue_filtro = ""

end event

type uo_cliente from u_em_campo_2 within w_lis_venfacturas_email
event destroy ( )
integer x = 23
integer y = 176
integer width = 1271
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;//dw_1.Reset()
//dw_detalle.Reset()
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

//dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

type p_1 from picture within w_lis_venfacturas_email
integer y = 148
integer width = 4274
integer height = 2984
boolean bringtotop = true
string picturename = "NotFound!"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_lis_venfacturas_email
integer x = 1349
integer y = 112
integer width = 1143
integer height = 176
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Administrativa"
end type

type gb_2 from groupbox within w_lis_venfacturas_email
integer x = 5
integer y = 112
integer width = 1326
integer height = 176
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_3 from groupbox within w_lis_venfacturas_email
integer x = 2519
integer y = 112
integer width = 754
integer height = 176
integer taborder = 90
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha Factura"
end type

