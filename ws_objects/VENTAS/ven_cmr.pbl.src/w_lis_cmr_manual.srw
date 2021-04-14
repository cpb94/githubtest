$PBExportHeader$w_lis_cmr_manual.srw
forward
global type w_lis_cmr_manual from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_cmr_manual
end type
type st_6 from statictext within w_lis_cmr_manual
end type
type em_copias1 from editmask within w_lis_cmr_manual
end type
type pb_imprimir_preli from picturebutton within w_lis_cmr_manual
end type
type st_pagina from statictext within w_lis_cmr_manual
end type
type uo_1 from u_selec_impresoras within w_lis_cmr_manual
end type
type cb_preliminar_cmr from u_boton within w_lis_cmr_manual
end type
type dw_preliminar from datawindow within w_lis_cmr_manual
end type
type uo_cliente from u_em_campo_2 within w_lis_cmr_manual
end type
type st_1 from statictext within w_lis_cmr_manual
end type
type uo_agencia from u_em_campo_2 within w_lis_cmr_manual
end type
type st_2 from statictext within w_lis_cmr_manual
end type
type st_5 from statictext within w_lis_cmr_manual
end type
type matricula from u_em_campo within w_lis_cmr_manual
end type
type st_8 from statictext within w_lis_cmr_manual
end type
type remolque from u_em_campo within w_lis_cmr_manual
end type
type uo_conductor from u_em_campo_2 within w_lis_cmr_manual
end type
type gb_3 from groupbox within w_lis_cmr_manual
end type
type st_3 from statictext within w_lis_cmr_manual
end type
type pb_agencia from picturebutton within w_lis_cmr_manual
end type
type pb_conductor from picturebutton within w_lis_cmr_manual
end type
type st_4 from statictext within w_lis_cmr_manual
end type
type st_7 from statictext within w_lis_cmr_manual
end type
type st_9 from statictext within w_lis_cmr_manual
end type
type em_kilos from editmask within w_lis_cmr_manual
end type
type em_bultos from editmask within w_lis_cmr_manual
end type
type uo_envio from u_em_campo_2 within w_lis_cmr_manual
end type
type gb_1 from groupbox within w_lis_cmr_manual
end type
end forward

global type w_lis_cmr_manual from w_int_con_empresa
integer width = 3694
integer height = 4932
pb_1 pb_1
st_6 st_6
em_copias1 em_copias1
pb_imprimir_preli pb_imprimir_preli
st_pagina st_pagina
uo_1 uo_1
cb_preliminar_cmr cb_preliminar_cmr
dw_preliminar dw_preliminar
uo_cliente uo_cliente
st_1 st_1
uo_agencia uo_agencia
st_2 st_2
st_5 st_5
matricula matricula
st_8 st_8
remolque remolque
uo_conductor uo_conductor
gb_3 gb_3
st_3 st_3
pb_agencia pb_agencia
pb_conductor pb_conductor
st_4 st_4
st_7 st_7
st_9 st_9
em_kilos em_kilos
em_bultos em_bultos
uo_envio uo_envio
gb_1 gb_1
end type
global w_lis_cmr_manual w_lis_cmr_manual

type variables
string is_transportista,is_conductor
end variables

event open;call super::open;
istr_parametros.s_titulo_ventana="Listado CMR Manual"

This.title=istr_parametros.s_titulo_ventana

dw_preliminar.SetTransObject(SQLCA)
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

on w_lis_cmr_manual.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_6=create st_6
this.em_copias1=create em_copias1
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_pagina=create st_pagina
this.uo_1=create uo_1
this.cb_preliminar_cmr=create cb_preliminar_cmr
this.dw_preliminar=create dw_preliminar
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.uo_agencia=create uo_agencia
this.st_2=create st_2
this.st_5=create st_5
this.matricula=create matricula
this.st_8=create st_8
this.remolque=create remolque
this.uo_conductor=create uo_conductor
this.gb_3=create gb_3
this.st_3=create st_3
this.pb_agencia=create pb_agencia
this.pb_conductor=create pb_conductor
this.st_4=create st_4
this.st_7=create st_7
this.st_9=create st_9
this.em_kilos=create em_kilos
this.em_bultos=create em_bultos
this.uo_envio=create uo_envio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.em_copias1
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.st_pagina
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.cb_preliminar_cmr
this.Control[iCurrent+8]=this.dw_preliminar
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.uo_agencia
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.matricula
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.remolque
this.Control[iCurrent+17]=this.uo_conductor
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.pb_agencia
this.Control[iCurrent+21]=this.pb_conductor
this.Control[iCurrent+22]=this.st_4
this.Control[iCurrent+23]=this.st_7
this.Control[iCurrent+24]=this.st_9
this.Control[iCurrent+25]=this.em_kilos
this.Control[iCurrent+26]=this.em_bultos
this.Control[iCurrent+27]=this.uo_envio
this.Control[iCurrent+28]=this.gb_1
end on

on w_lis_cmr_manual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.pb_imprimir_preli)
destroy(this.st_pagina)
destroy(this.uo_1)
destroy(this.cb_preliminar_cmr)
destroy(this.dw_preliminar)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.uo_agencia)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.matricula)
destroy(this.st_8)
destroy(this.remolque)
destroy(this.uo_conductor)
destroy(this.gb_3)
destroy(this.st_3)
destroy(this.pb_agencia)
destroy(this.pb_conductor)
destroy(this.st_4)
destroy(this.st_7)
destroy(this.st_9)
destroy(this.em_kilos)
destroy(this.em_bultos)
destroy(this.uo_envio)
destroy(this.gb_1)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;//uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;//uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_cmr_manual
integer x = 2409
integer y = 452
integer taborder = 120
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_cmr_manual
integer taborder = 130
end type

event sle_opcion_orden::getfocus;call super::getfocus;//f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_cmr_manual
integer x = 14
integer y = 4
integer width = 3479
integer height = 96
end type

type pb_1 from upb_salir within w_lis_cmr_manual
integer x = 3538
integer y = 4
integer width = 142
integer height = 112
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type st_6 from statictext within w_lis_cmr_manual
integer x = 3127
integer y = 308
integer width = 215
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copias1 from editmask within w_lis_cmr_manual
integer x = 3355
integer y = 300
integer width = 192
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
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

type pb_imprimir_preli from picturebutton within w_lis_cmr_manual
boolean visible = false
integer x = 3557
integer y = 300
integer width = 101
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
end type

event clicked;//int  anyo
//long albaran

//Variables de conversion
//anyo		= dec(em_anyo.text)
//albaran	= dec(em_albaran.text)


//dw_preliminar.reset()
//dw_preliminar.dataobject = "report_list_cmr"
//dw_preliminar.SetRedraw(FALSE)
////f_carga_dw_cmr(codigo_empresa,anyo,albaran,dw_preliminar)
////dw_preliminar.Modify(" datawindow.print.copies = 4")
dw_preliminar.accepttext()
dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
//dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
//dw_preliminar.visible = TRUE
//
//pb_imprimir_preli.visible = TRUE
//dw_preliminar.SetRedraw(TRUE)

F_IMPRIMIR_DATAWINDOW(dw_preliminar)

//f_activar_campo(em_albaran)
end event

type st_pagina from statictext within w_lis_cmr_manual
integer x = 1733
integer y = 456
integer width = 361
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type uo_1 from u_selec_impresoras within w_lis_cmr_manual
integer x = 2057
integer height = 100
integer taborder = 160
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
//is_impresora = u_selec_impresoras_report.describe("datawindow.printer")
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type cb_preliminar_cmr from u_boton within w_lis_cmr_manual
integer x = 3109
integer y = 188
integer width = 549
integer height = 84
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Preliminar"
end type

event clicked;int  anyo
long albaran
string arg_cliente,arg_transportista,arg_cond_entrega,arg_envio,arg_matricula,arg_remolque
decimal arg_kilos,arg_palets
datetime arg_fecha
//Variables de conversion
//anyo		= dec(em_anyo.text)
//albaran	= dec(em_albaran.text)

arg_cliente       = uo_cliente.em_codigo.text
arg_transportista = uo_agencia.em_codigo.text
arg_cond_entrega  = ""
arg_envio         = uo_envio.em_codigo.text
arg_matricula     = matricula.text
arg_remolque      = remolque.text
arg_kilos         = dec(em_kilos.text)
arg_palets        = dec(em_bultos.text)
arg_fecha         = datetime(today())

select cod_entrega
into   :arg_cond_entrega
from   venclientes
where  empresa = :codigo_empresa
and    codigo  = :arg_cliente;

dw_preliminar.reset()
//dw_preliminar.dataobject = "report_list_cmr"
dw_preliminar.SetRedraw(FALSE)
f_carga_dw_cmr_manual(codigo_empresa,arg_cliente,arg_transportista,arg_cond_entrega,arg_envio,arg_matricula,arg_remolque,arg_kilos,arg_palets,arg_fecha,dw_preliminar)
//f_carga_dw_cmr(codigo_empresa,anyo,albaran,dw_preliminar)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible = TRUE

pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type dw_preliminar from datawindow within w_lis_cmr_manual
boolean visible = false
integer x = 9
integer y = 400
integer width = 3662
integer height = 4364
string dataobject = "report_list_cmr_manual"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_lis_cmr_manual
event destroy ( )
integer x = 293
integer y = 120
integer width = 1358
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;//if cb_contactos.checked then
//	uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)
//else
	uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
//end if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;//if cb_contactos.checked then
//	ue_titulo = "Selección de Contactos"
//	ue_datawindow ="dw_ayuda_vencliproforma"
//	ue_filtro = ""	
//else
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
//end if
end event

type st_1 from statictext within w_lis_cmr_manual
integer x = 18
integer y = 220
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Agencia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_agencia from u_em_campo_2 within w_lis_cmr_manual
event destroy ( )
integer x = 293
integer y = 208
integer width = 965
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agencia.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;

this.em_campo.text = f_nombre_ventransportista(codigo_empresa,this.em_codigo.text)
	
If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	is_transportista = ""
else
	is_transportista = this.em_codigo.text
end if 



	
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE TRANSPORTISTAS"
ue_datawindow = "dw_ayuda_ventransportistas"
ue_filtro     = ""
is_transportista = ""

return 0
end event

type st_2 from statictext within w_lis_cmr_manual
integer x = 1376
integer y = 220
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Conductor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_lis_cmr_manual
integer x = 18
integer y = 308
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Matrícula:"
alignment alignment = right!
boolean focusrectangle = false
end type

type matricula from u_em_campo within w_lis_cmr_manual
integer x = 293
integer y = 300
integer width = 617
integer taborder = 40
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type st_8 from statictext within w_lis_cmr_manual
integer x = 928
integer y = 308
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Remolque:"
alignment alignment = right!
boolean focusrectangle = false
end type

type remolque from u_em_campo within w_lis_cmr_manual
integer x = 1221
integer y = 300
integer width = 617
integer taborder = 50
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type uo_conductor from u_em_campo_2 within w_lis_cmr_manual
event destroy ( )
integer x = 1678
integer y = 208
integer width = 1010
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_conductor.destroy
call u_em_campo_2::destroy
end on

event modificado;string ls_dni,ls_matricula,ls_remolque

this.em_campo.text = f_venconductores_nombre(codigo_empresa,is_transportista,this.em_codigo.text)

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	is_conductor = ""
	ls_dni = ""
	ls_matricula = ""
	ls_remolque = ""		
else  
	is_conductor = this.em_codigo.text
	
	SELECT dni,   
			 matricula,   
			 telefono  
	INTO  :ls_dni,   
			:ls_matricula,   
			:ls_remolque  
	FROM venconductores  
	WHERE ( empresa       = :codigo_empresa ) 
	AND   ( transportista = :uo_agencia.em_codigo.text) 
	AND   ( codigo        = :this.em_codigo.text );
	
	if isnull(ls_dni) then ls_dni = ""
	if isnull(ls_matricula) then ls_matricula = ""
	if isnull(ls_remolque) then ls_remolque = ""	
	
end if 
//transportista.text = this.em_campo.text
matricula.text = ls_matricula
remolque.text  = ls_remolque
//if trim(ls_dni) <> "" then
//	texto.text     = "D.N.I. :"+ls_dni
//end if
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CONDUCTORES"
ue_datawindow = "dw_ayuda_venconductores"
ue_filtro     = " transportista = '" +is_transportista + "'"
end event

type gb_3 from groupbox within w_lis_cmr_manual
integer x = 5
integer y = 80
integer width = 3090
integer height = 316
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_3 from statictext within w_lis_cmr_manual
integer x = 18
integer y = 132
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_agencia from picturebutton within w_lis_cmr_manual
integer x = 1266
integer y = 208
integer width = 101
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\BMP\CARPETA.BMP"
alignment htextalign = right!
end type

event clicked;  
 str_parametros lstr_param

lstr_param.i_nargumentos 	= 2
lstr_param.s_argumentos[1] = uo_agencia.em_codigo.text

OpenWithParm(wi_mant_ventransportistas,lstr_param)
end event

type pb_conductor from picturebutton within w_lis_cmr_manual
integer x = 2697
integer y = 208
integer width = 101
integer height = 84
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\BMP\CARPETA.BMP"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos 	= 3
lstr_param.s_argumentos[2] = uo_agencia.em_codigo.text
lstr_param.s_argumentos[3] = uo_conductor.em_codigo.text

OpenWithParm(wi_mant_venconductores,lstr_param)
end event

type st_4 from statictext within w_lis_cmr_manual
integer x = 1669
integer y = 132
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Dir. Envio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_lis_cmr_manual
integer x = 1847
integer y = 308
integer width = 155
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Kilos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_lis_cmr_manual
integer x = 2263
integer y = 308
integer width = 183
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Bultos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_kilos from editmask within w_lis_cmr_manual
integer x = 2011
integer y = 300
integer width = 242
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

type em_bultos from editmask within w_lis_cmr_manual
integer x = 2455
integer y = 300
integer width = 201
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

type uo_envio from u_em_campo_2 within w_lis_cmr_manual
event destroy ( )
integer x = 1938
integer y = 120
integer width = 1138
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_envio.destroy
call u_em_campo_2::destroy
end on

event modificado;//if cb_contactos.checked then
//	uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)
//else
	this.em_campo.text=f_nombre_venenvio(codigo_empresa,uo_cliente.em_codigo.text,this.em_codigo.text)
//end if

If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;//if cb_contactos.checked then
//	ue_titulo = "Selección de Contactos"
//	ue_datawindow ="dw_ayuda_vencliproforma"
//	ue_filtro = ""	
//else

	ue_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
	ue_datawindow ="dw_ayuda_venenvio"
	ue_filtro = " cliente = '" +uo_cliente.em_codigo.text+ "'"
//end if
end event

type gb_1 from groupbox within w_lis_cmr_manual
integer x = 3095
integer y = 144
integer width = 576
integer height = 252
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

