$PBExportHeader$w_pedir_datos_expedicion.srw
forward
global type w_pedir_datos_expedicion from window
end type
type em_importe_forma_envio from u_em_campo within w_pedir_datos_expedicion
end type
type uo_forma_envio from u_em_campo_2 within w_pedir_datos_expedicion
end type
type st_13 from statictext within w_pedir_datos_expedicion
end type
type st_12 from statictext within w_pedir_datos_expedicion
end type
type em_1 from u_em_campo within w_pedir_datos_expedicion
end type
type st_11 from statictext within w_pedir_datos_expedicion
end type
type cbx_metodo_2 from checkbox within w_pedir_datos_expedicion
end type
type cbx_metodo_1 from checkbox within w_pedir_datos_expedicion
end type
type st_10 from statictext within w_pedir_datos_expedicion
end type
type tara_contenedor from u_em_campo within w_pedir_datos_expedicion
end type
type st_9 from statictext within w_pedir_datos_expedicion
end type
type booking from u_em_campo within w_pedir_datos_expedicion
end type
type st_7 from statictext within w_pedir_datos_expedicion
end type
type cbx_imprimir_vgm from checkbox within w_pedir_datos_expedicion
end type
type uo_agencia from u_em_campo_2 within w_pedir_datos_expedicion
end type
type pb_conductor from picturebutton within w_pedir_datos_expedicion
end type
type pb_agencia from picturebutton within w_pedir_datos_expedicion
end type
type em_total_pallets from u_em_campo within w_pedir_datos_expedicion
end type
type st_6 from statictext within w_pedir_datos_expedicion
end type
type uo_conductor from u_em_campo_2 within w_pedir_datos_expedicion
end type
type st_2 from statictext within w_pedir_datos_expedicion
end type
type st_1 from statictext within w_pedir_datos_expedicion
end type
type cbx_imprimir_cmr from checkbox within w_pedir_datos_expedicion
end type
type remolque from u_em_campo within w_pedir_datos_expedicion
end type
type st_8 from statictext within w_pedir_datos_expedicion
end type
type peso_neto from u_em_campo within w_pedir_datos_expedicion
end type
type dni from u_em_campo within w_pedir_datos_expedicion
end type
type matricula from u_em_campo within w_pedir_datos_expedicion
end type
type st_5 from statictext within w_pedir_datos_expedicion
end type
type st_4 from statictext within w_pedir_datos_expedicion
end type
type precinto from u_em_campo within w_pedir_datos_expedicion
end type
type texto from multilineedit within w_pedir_datos_expedicion
end type
type peso from u_em_campo within w_pedir_datos_expedicion
end type
type contenedor from u_em_campo within w_pedir_datos_expedicion
end type
type st_3 from statictext within w_pedir_datos_expedicion
end type
type cb_cancelar from commandbutton within w_pedir_datos_expedicion
end type
type cb_ok from commandbutton within w_pedir_datos_expedicion
end type
type gb_2 from groupbox within w_pedir_datos_expedicion
end type
type gb_3 from groupbox within w_pedir_datos_expedicion
end type
type gb_4 from groupbox within w_pedir_datos_expedicion
end type
type gb_5 from groupbox within w_pedir_datos_expedicion
end type
type dw_peso_albaranes from u_datawindow within w_pedir_datos_expedicion
end type
type gb_6 from groupbox within w_pedir_datos_expedicion
end type
type gb_1 from groupbox within w_pedir_datos_expedicion
end type
end forward

global type w_pedir_datos_expedicion from window
integer x = 599
integer y = 420
integer width = 2875
integer height = 2100
boolean titlebar = true
string title = "Introducción datos expedición"
windowtype windowtype = response!
long backcolor = 12632256
em_importe_forma_envio em_importe_forma_envio
uo_forma_envio uo_forma_envio
st_13 st_13
st_12 st_12
em_1 em_1
st_11 st_11
cbx_metodo_2 cbx_metodo_2
cbx_metodo_1 cbx_metodo_1
st_10 st_10
tara_contenedor tara_contenedor
st_9 st_9
booking booking
st_7 st_7
cbx_imprimir_vgm cbx_imprimir_vgm
uo_agencia uo_agencia
pb_conductor pb_conductor
pb_agencia pb_agencia
em_total_pallets em_total_pallets
st_6 st_6
uo_conductor uo_conductor
st_2 st_2
st_1 st_1
cbx_imprimir_cmr cbx_imprimir_cmr
remolque remolque
st_8 st_8
peso_neto peso_neto
dni dni
matricula matricula
st_5 st_5
st_4 st_4
precinto precinto
texto texto
peso peso
contenedor contenedor
st_3 st_3
cb_cancelar cb_cancelar
cb_ok cb_ok
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
dw_peso_albaranes dw_peso_albaranes
gb_6 gb_6
gb_1 gb_1
end type
global w_pedir_datos_expedicion w_pedir_datos_expedicion

type variables
string is_cliente,is_transportista,is_conductor
long   il_albaranes
dec    id_portes
end variables

on w_pedir_datos_expedicion.create
this.em_importe_forma_envio=create em_importe_forma_envio
this.uo_forma_envio=create uo_forma_envio
this.st_13=create st_13
this.st_12=create st_12
this.em_1=create em_1
this.st_11=create st_11
this.cbx_metodo_2=create cbx_metodo_2
this.cbx_metodo_1=create cbx_metodo_1
this.st_10=create st_10
this.tara_contenedor=create tara_contenedor
this.st_9=create st_9
this.booking=create booking
this.st_7=create st_7
this.cbx_imprimir_vgm=create cbx_imprimir_vgm
this.uo_agencia=create uo_agencia
this.pb_conductor=create pb_conductor
this.pb_agencia=create pb_agencia
this.em_total_pallets=create em_total_pallets
this.st_6=create st_6
this.uo_conductor=create uo_conductor
this.st_2=create st_2
this.st_1=create st_1
this.cbx_imprimir_cmr=create cbx_imprimir_cmr
this.remolque=create remolque
this.st_8=create st_8
this.peso_neto=create peso_neto
this.dni=create dni
this.matricula=create matricula
this.st_5=create st_5
this.st_4=create st_4
this.precinto=create precinto
this.texto=create texto
this.peso=create peso
this.contenedor=create contenedor
this.st_3=create st_3
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.dw_peso_albaranes=create dw_peso_albaranes
this.gb_6=create gb_6
this.gb_1=create gb_1
this.Control[]={this.em_importe_forma_envio,&
this.uo_forma_envio,&
this.st_13,&
this.st_12,&
this.em_1,&
this.st_11,&
this.cbx_metodo_2,&
this.cbx_metodo_1,&
this.st_10,&
this.tara_contenedor,&
this.st_9,&
this.booking,&
this.st_7,&
this.cbx_imprimir_vgm,&
this.uo_agencia,&
this.pb_conductor,&
this.pb_agencia,&
this.em_total_pallets,&
this.st_6,&
this.uo_conductor,&
this.st_2,&
this.st_1,&
this.cbx_imprimir_cmr,&
this.remolque,&
this.st_8,&
this.peso_neto,&
this.dni,&
this.matricula,&
this.st_5,&
this.st_4,&
this.precinto,&
this.texto,&
this.peso,&
this.contenedor,&
this.st_3,&
this.cb_cancelar,&
this.cb_ok,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.dw_peso_albaranes,&
this.gb_6,&
this.gb_1}
end on

on w_pedir_datos_expedicion.destroy
destroy(this.em_importe_forma_envio)
destroy(this.uo_forma_envio)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.em_1)
destroy(this.st_11)
destroy(this.cbx_metodo_2)
destroy(this.cbx_metodo_1)
destroy(this.st_10)
destroy(this.tara_contenedor)
destroy(this.st_9)
destroy(this.booking)
destroy(this.st_7)
destroy(this.cbx_imprimir_vgm)
destroy(this.uo_agencia)
destroy(this.pb_conductor)
destroy(this.pb_agencia)
destroy(this.em_total_pallets)
destroy(this.st_6)
destroy(this.uo_conductor)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_imprimir_cmr)
destroy(this.remolque)
destroy(this.st_8)
destroy(this.peso_neto)
destroy(this.dni)
destroy(this.matricula)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.precinto)
destroy(this.texto)
destroy(this.peso)
destroy(this.contenedor)
destroy(this.st_3)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.dw_peso_albaranes)
destroy(this.gb_6)
destroy(this.gb_1)
end on

event open;//peso.text = message.StringParm
//this.ole_1.object.LoadSkin(gs_sknpath)
//this.ole_1.Object.ApplySkin(Handle( this )) 

long ll_indice,ll_donde,ll_pallets_totales,ll_lineas_pedidos
dec  ld_peso_neto_total,ld_peso_bruto_total
str_venparametros lstr_venparametros
tipo_array  val

f_cargar_str_venparametros(codigo_empresa,lstr_venparametros)

val = message.PowerObjectParm

is_cliente       = val.valor[1]
il_albaranes     = dec(val.valor[2])
id_portes        = dec(val.valor[3])
is_transportista = val.valor[4]

if trim(is_transportista) = "" then
	is_transportista = f_venclientes_transportista(codigo_empresa,is_cliente)
end if

uo_agencia.em_codigo.text = is_transportista

uo_agencia.event modificado(0,0)

em_importe_forma_envio.text = string(id_portes,em_importe_forma_envio.mask)

ld_peso_neto_total  = 0
ld_peso_bruto_total = 0

for ll_indice = 1 to il_albaranes
	ll_lineas_pedidos = dec(val.valor[(ll_indice * 4)+4])
	if ll_lineas_pedidos > 0 then
		ll_donde = dw_peso_albaranes.insertrow(0)
		dw_peso_albaranes.object.albaran[ll_donde]               = ll_indice
		
		/*MARCOS 21/01/2021 PONEMOS PESO 1 EN LÍNEAS INFERIORES A 1 KG*/
		if dec(val.valor[(ll_indice * 4)+1]) < 1 then val.valor[(ll_indice * 4)+1] = '1'
		dw_peso_albaranes.object.peso_bruto_real[ll_donde]       = dec(val.valor[(ll_indice * 4)+1])
		
		if dec(val.valor[(ll_indice * 4)+2]) < 1 then val.valor[(ll_indice * 4)+2] = '1'
		dw_peso_albaranes.object.peso_neto_real[ll_donde]        = dec(val.valor[(ll_indice * 4)+2])
		
		dw_peso_albaranes.object.pallets_reales[ll_donde]        = dec(val.valor[(ll_indice * 4)+3])	
		dw_peso_albaranes.object.peso_bruto_modificado[ll_donde] = dec(val.valor[(ll_indice * 4)+1])
		dw_peso_albaranes.object.peso_neto_modificado[ll_donde]  = dec(val.valor[(ll_indice * 4)+2])
		dw_peso_albaranes.object.pallets_modificados[ll_donde]   = dec(val.valor[(ll_indice * 4)+3])	
		
		ld_peso_neto_total  = ld_peso_neto_total  + dec(val.valor[(ll_indice * 4)+2])
		ld_peso_bruto_total = ld_peso_bruto_total + dec(val.valor[(ll_indice * 4)+1])
		ll_pallets_totales  = ll_pallets_totales  + dec(val.valor[(ll_indice * 4)+3])
	end if
next

peso.text             = string(ld_peso_bruto_total)
peso_neto.text        = string(ld_peso_neto_total)
em_total_pallets.text = string(ll_pallets_totales)

if lstr_venparametros.vgm_metodo_utilizado_por_defecto = '1' then
	cbx_metodo_1.checked = true
	cbx_metodo_2.checked = false
else
	cbx_metodo_1.checked = false
	cbx_metodo_2.checked = true
end if

uo_agencia.em_campo.SetFocus ( )

end event

type em_importe_forma_envio from u_em_campo within w_pedir_datos_expedicion
integer x = 2450
integer y = 832
integer width = 375
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0.00"
end type

type uo_forma_envio from u_em_campo_2 within w_pedir_datos_expedicion
integer x = 402
integer y = 832
integer width = 1737
integer taborder = 130
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;this.em_campo.text = f_nombre_venformaenvio(codigo_empresa,this.em_codigo.text)	

If Trim(this.em_campo.text) = "" then
	this.em_campo.text  = ""
	this.em_codigo.text = ""
end if 	

end event

on uo_forma_envio.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_datawindow = "dw_ayuda_venformaenvio"
ue_titulo     = "AYUDA SELECCION FORMAS DE ENVIO"
ue_filtro     = ""
end event

type st_13 from statictext within w_pedir_datos_expedicion
integer x = 2226
integer y = 844
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Importe:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_pedir_datos_expedicion
integer x = 46
integer y = 844
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Forma Envio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from u_em_campo within w_pedir_datos_expedicion
integer x = 320
integer y = 300
integer width = 2491
integer taborder = 40
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_11 from statictext within w_pedir_datos_expedicion
integer x = 46
integer y = 304
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Texto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_metodo_2 from checkbox within w_pedir_datos_expedicion
integer x = 2702
integer y = 728
integer width = 114
integer height = 52
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "2"
boolean checked = true
boolean lefttext = true
end type

type cbx_metodo_1 from checkbox within w_pedir_datos_expedicion
integer x = 2702
integer y = 676
integer width = 114
integer height = 52
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "1"
boolean lefttext = true
end type

type st_10 from statictext within w_pedir_datos_expedicion
integer x = 2034
integer y = 676
integer width = 654
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Método Verif. Masa Bruta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type tara_contenedor from u_em_campo within w_pedir_datos_expedicion
integer x = 1655
integer y = 688
integer width = 375
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,##0"
end type

type st_9 from statictext within w_pedir_datos_expedicion
integer x = 1102
integer y = 692
integer width = 539
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Tara del Contenedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type booking from u_em_campo within w_pedir_datos_expedicion
integer x = 457
integer y = 684
integer width = 617
integer taborder = 90
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_7 from statictext within w_pedir_datos_expedicion
integer x = 55
integer y = 692
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Nº Booking:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_imprimir_vgm from checkbox within w_pedir_datos_expedicion
integer x = 2336
integer y = 596
integer width = 480
integer height = 52
integer taborder = 230
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Imprimir VGM"
boolean lefttext = true
end type

type uo_agencia from u_em_campo_2 within w_pedir_datos_expedicion
integer x = 320
integer y = 116
integer width = 965
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agencia.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE TRANSPORTISTAS"
ue_datawindow = "dw_ayuda_ventransportistas"
ue_filtro     = ""
is_transportista = ""

return 0
end event

event modificado;call super::modificado;if is_transportista = "" then

this.em_campo.text = f_nombre_ventransportista(codigo_empresa,this.em_codigo.text)
	
	If Trim(this.em_campo.text)="" then
		this.em_campo.text=""
		this.em_codigo.text=""
		is_transportista = ""
	else
		is_transportista = this.em_codigo.text
	end if 
	
end IF

	
end event

type pb_conductor from picturebutton within w_pedir_datos_expedicion
integer x = 2725
integer y = 120
integer width = 101
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\BMP\CARPETA.BMP"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos 	= 3
lstr_param.s_argumentos[2] = uo_agencia.em_codigo.text
lstr_param.s_argumentos[3] = uo_conductor.em_codigo.text

OpenWithParm(wi_mant_venconductores,lstr_param)
end event

type pb_agencia from picturebutton within w_pedir_datos_expedicion
integer x = 1294
integer y = 120
integer width = 101
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\BMP\CARPETA.BMP"
alignment htextalign = right!
end type

event clicked;  
 str_parametros lstr_param

lstr_param.i_nargumentos 	= 2
lstr_param.s_argumentos[1] = uo_agencia.em_codigo.text

OpenWithParm(wi_mant_ventransportistas,lstr_param)
end event

type em_total_pallets from u_em_campo within w_pedir_datos_expedicion
integer x = 2400
integer y = 1824
integer width = 370
integer taborder = 190
boolean bringtotop = true
long textcolor = 128
long backcolor = 15793151
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
string displaydata = "Ä"
end type

event modified;call super::modified;//long ll_indice,ll_total,ll_lineas
//long ll_pallets_modificados,ll_pallets_reales,ll_pallets_mod_ya_asignados
//
//
//ll_pallets_modificados = dec(this.text)
//
//ll_pallets_reales       = dec(dw_peso_albaranes.describe("evaluate('sum(pallets_reales for all)',1)"))
//
//ld_factor_de_conversion = ld_peso_bruto_real / ld_peso_bruto_modificado
//
//ll_lineas = dw_peso_albaranes.rowcount()
//
//if ll_lineas = 1 then
//	dw_peso_albaranes.object.pallets_modificados[1] = ll_pallets_modificados
//else	
//	ll_pallets_mod_ya_asignados = 0
//	
//	for ll_indice = 1 to ll_lineas
//		if ll_indice = ll_total then
//			dw_peso_albaranes.object.pallets_modificados[ll_indice]  = ll_pallets_modificados - ll_pallets_mod_ya_asignados
//		else
//			ld_peso_neto_modificado_linea = dw_peso_albaranes.object.peso_neto_real[ll_indice] / ld_factor_de_conversion
//			ld_peso_neto_modificado_linea = round(ld_peso_neto_modificado_linea,0)
//			ld_peso_neto_mod_ya_asignado  = ld_peso_neto_mod_ya_asignado + ld_peso_neto_modificado_linea
//			dw_peso_albaranes.object.peso_neto_modificado[ll_indice] = ld_peso_neto_modificado_linea
//			
//		end if
//	next
//end if
//
//
//
end event

type st_6 from statictext within w_pedir_datos_expedicion
integer x = 1431
integer y = 216
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "DNI:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_conductor from u_em_campo_2 within w_pedir_datos_expedicion
integer x = 1705
integer y = 116
integer width = 1019
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

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
			 remolque  
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
dni.text = ls_dni
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

on uo_conductor.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_pedir_datos_expedicion
integer x = 1403
integer y = 128
integer width = 288
integer height = 64
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

type st_1 from statictext within w_pedir_datos_expedicion
integer x = 46
integer y = 128
integer width = 261
integer height = 64
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

type cbx_imprimir_cmr from checkbox within w_pedir_datos_expedicion
integer x = 1385
integer y = 1936
integer width = 480
integer height = 80
integer taborder = 200
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Imprimir CMR"
boolean lefttext = true
end type

type remolque from u_em_campo within w_pedir_datos_expedicion
integer x = 1248
integer y = 448
integer width = 617
integer taborder = 60
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type st_8 from statictext within w_pedir_datos_expedicion
integer x = 955
integer y = 456
integer width = 279
integer height = 64
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

type peso_neto from u_em_campo within w_pedir_datos_expedicion
integer x = 1495
integer y = 1824
integer width = 453
integer taborder = 170
boolean bringtotop = true
long textcolor = 128
long backcolor = 15793151
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
string displaydata = "Ä"
end type

event modified;call super::modified;//long ll_indice,ll_total,ll_lineas
//dec  ld_peso_neto_modificado,ld_peso_neto_real,ld_factor_de_conversion,ld_peso_neto_mod_ya_asignado
//dec  ld_peso_neto_modificado_linea
//dec  ld_peso_bruto_modificado,ld_peso_bruto_real,ld_peso_bruto_mod_ya_asignado
//dec  ld_peso_bruto_modificado_linea
//
//
//ld_peso_neto_modificado = dec(this.text)
//
//ld_peso_neto_real       = dec(dw_peso_albaranes.describe("evaluate('sum(peso_neto_real for all)',1)"))
//ld_peso_bruto_real      = dec(dw_peso_albaranes.describe("evaluate('sum(peso_bruto_real for all)',1)"))
//
//ld_factor_de_conversion = ld_peso_neto_real / ld_peso_neto_modificado
//
//ld_peso_bruto_modificado = round(ld_peso_bruto_real / ld_factor_de_conversion,0)
//
//ll_lineas = dw_peso_albaranes.rowcount()
//
//if ll_lineas = 1 then
//	dw_peso_albaranes.object.peso_neto_modificado[1] = ld_peso_neto_modificado
//	dw_peso_albaranes.object.peso_bruto_modificado[1] = ld_peso_bruto_modificado	
//else	
//	ld_peso_neto_mod_ya_asignado  = 0
//	ld_peso_bruto_mod_ya_asignado = 0
//	
//	for ll_indice = 1 to ll_lineas
//		if ll_indice = ll_total then
//			dw_peso_albaranes.object.peso_neto_modificado[ll_indice]  = ld_peso_neto_modificado - ld_peso_neto_mod_ya_asignado
//			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado - ld_peso_bruto_mod_ya_asignado
//		else
//			ld_peso_neto_modificado_linea = dw_peso_albaranes.object.peso_neto_real[ll_indice] / ld_factor_de_conversion
//			ld_peso_neto_modificado_linea = round(ld_peso_neto_modificado_linea,0)
//			ld_peso_neto_mod_ya_asignado  = ld_peso_neto_mod_ya_asignado + ld_peso_neto_modificado_linea
//			dw_peso_albaranes.object.peso_neto_modificado[ll_indice] = ld_peso_neto_modificado_linea
//			
//			ld_peso_bruto_modificado_linea = dw_peso_albaranes.object.peso_bruto_real[ll_indice] / ld_factor_de_conversion
//			ld_peso_bruto_modificado_linea = round(ld_peso_bruto_modificado_linea,0)
//			ld_peso_bruto_mod_ya_asignado  = ld_peso_bruto_mod_ya_asignado + ld_peso_bruto_modificado_linea
//			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado_linea			
//		end if
//	next
//end if
//
//peso.text = string(ld_peso_bruto_modificado)
//
//
//
end event

event modificado;call super::modificado;long ll_indice,ll_total,ll_lineas
dec  ld_peso_neto_modificado,ld_peso_neto_real,ld_factor_de_conversion,ld_peso_neto_mod_ya_asignado
dec  ld_peso_neto_modificado_linea
dec  ld_peso_bruto_modificado,ld_peso_bruto_real,ld_peso_bruto_mod_ya_asignado
dec  ld_peso_bruto_modificado_linea


ld_peso_neto_modificado = dec(this.text)

//formula para calcular el bruto

ld_peso_bruto_modificado= round((ld_peso_neto_modificado * 1.016),2)

ld_peso_neto_real       = dec(dw_peso_albaranes.describe("evaluate('sum(peso_neto_real for all)',1)"))
ld_peso_bruto_real      = dec(dw_peso_albaranes.describe("evaluate('sum(peso_bruto_real for all)',1)"))

ld_factor_de_conversion = ld_peso_neto_real / ld_peso_neto_modificado

//ld_peso_bruto_modificado = round(ld_peso_bruto_real / ld_factor_de_conversion,0)

ll_lineas = dw_peso_albaranes.rowcount()

if ll_lineas = 1 then
	dw_peso_albaranes.object.peso_neto_modificado[1] = ld_peso_neto_modificado
	dw_peso_albaranes.object.peso_bruto_modificado[1] = ld_peso_bruto_modificado	
else	
	ld_peso_neto_mod_ya_asignado  = 0
	ld_peso_bruto_mod_ya_asignado = 0
	
	for ll_indice = 1 to ll_lineas
		if ll_indice = ll_total then
			dw_peso_albaranes.object.peso_neto_modificado[ll_indice]  = ld_peso_neto_modificado - ld_peso_neto_mod_ya_asignado
			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado - ld_peso_bruto_mod_ya_asignado
		else
			ld_peso_neto_modificado_linea = dw_peso_albaranes.object.peso_neto_real[ll_indice] / ld_factor_de_conversion
			ld_peso_neto_modificado_linea = round(ld_peso_neto_modificado_linea,0)
			ld_peso_neto_mod_ya_asignado  = ld_peso_neto_mod_ya_asignado + ld_peso_neto_modificado_linea
			dw_peso_albaranes.object.peso_neto_modificado[ll_indice] = ld_peso_neto_modificado_linea
			
			ld_peso_bruto_modificado_linea = dw_peso_albaranes.object.peso_bruto_real[ll_indice] / ld_factor_de_conversion
			ld_peso_bruto_modificado_linea = round(ld_peso_bruto_modificado_linea,0)
			ld_peso_bruto_mod_ya_asignado  = ld_peso_bruto_mod_ya_asignado + ld_peso_bruto_modificado_linea
			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado_linea			
		end if
	next
end if


peso.text = string(ld_peso_bruto_modificado)



end event

type dni from u_em_campo within w_pedir_datos_expedicion
integer x = 1705
integer y = 208
integer width = 585
integer taborder = 30
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type matricula from u_em_campo within w_pedir_datos_expedicion
integer x = 320
integer y = 448
integer width = 617
integer taborder = 50
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type st_5 from statictext within w_pedir_datos_expedicion
integer x = 46
integer y = 456
integer width = 261
integer height = 64
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

type st_4 from statictext within w_pedir_datos_expedicion
integer x = 1102
integer y = 600
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Nº Precinto:"
alignment alignment = right!
boolean focusrectangle = false
end type

type precinto from u_em_campo within w_pedir_datos_expedicion
integer x = 1413
integer y = 596
integer width = 617
integer taborder = 80
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

type texto from multilineedit within w_pedir_datos_expedicion
integer x = 41
integer y = 988
integer width = 2770
integer height = 212
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

event losefocus;This.BackColor= RGB(192,192,192)
end event

event getfocus;This.BackColor= RGB(255,255,255)
end event

type peso from u_em_campo within w_pedir_datos_expedicion
integer x = 1947
integer y = 1824
integer width = 453
integer taborder = 180
boolean bringtotop = true
long textcolor = 128
long backcolor = 15793151
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###"
string displaydata = "Ä"
end type

event modified;call super::modified;//long ll_indice,ll_total,ll_lineas
//dec  ld_peso_neto_modificado,ld_peso_neto_real,ld_factor_de_conversion,ld_peso_neto_mod_ya_asignado
//dec  ld_peso_neto_modificado_linea
//dec  ld_peso_bruto_modificado,ld_peso_bruto_real,ld_peso_bruto_mod_ya_asignado
//dec  ld_peso_bruto_modificado_linea
//
//
//ld_peso_bruto_modificado = dec(this.text)
//
//ld_peso_neto_real       = dec(dw_peso_albaranes.describe("evaluate('sum(peso_neto_real for all)',1)"))
//ld_peso_bruto_real      = dec(dw_peso_albaranes.describe("evaluate('sum(peso_bruto_real for all)',1)"))
//
//ld_factor_de_conversion = ld_peso_bruto_real / ld_peso_bruto_modificado
//
//ld_peso_neto_modificado = round(ld_peso_neto_real / ld_factor_de_conversion,0)
//
//ll_lineas = dw_peso_albaranes.rowcount()
//
//if ll_lineas = 1 then
//	dw_peso_albaranes.object.peso_neto_modificado[1] = ld_peso_neto_modificado
//	dw_peso_albaranes.object.peso_bruto_modificado[1] = ld_peso_bruto_modificado	
//else	
//	ld_peso_neto_mod_ya_asignado  = 0
//	ld_peso_bruto_mod_ya_asignado = 0
//	
//	for ll_indice = 1 to ll_lineas
//		if ll_indice = ll_total then
//			dw_peso_albaranes.object.peso_neto_modificado[ll_indice]  = ld_peso_neto_modificado - ld_peso_neto_mod_ya_asignado
//			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado - ld_peso_bruto_mod_ya_asignado
//		else
//			ld_peso_neto_modificado_linea = dw_peso_albaranes.object.peso_neto_real[ll_indice] / ld_factor_de_conversion
//			ld_peso_neto_modificado_linea = round(ld_peso_neto_modificado_linea,0)
//			ld_peso_neto_mod_ya_asignado  = ld_peso_neto_mod_ya_asignado + ld_peso_neto_modificado_linea
//			dw_peso_albaranes.object.peso_neto_modificado[ll_indice] = ld_peso_neto_modificado_linea
//			
//			ld_peso_bruto_modificado_linea = dw_peso_albaranes.object.peso_bruto_real[ll_indice] / ld_factor_de_conversion
//			ld_peso_bruto_modificado_linea = round(ld_peso_bruto_modificado_linea,0)
//			ld_peso_bruto_mod_ya_asignado  = ld_peso_bruto_mod_ya_asignado + ld_peso_bruto_modificado_linea
//			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado_linea			
//		end if
//	next
//end if
//
//peso_neto.text = string(ld_peso_neto_modificado)
//
//
//
end event

event modificado;call super::modificado;long ll_indice,ll_total,ll_lineas
dec  ld_peso_neto_modificado,ld_peso_neto_real,ld_factor_de_conversion,ld_peso_neto_mod_ya_asignado
dec  ld_peso_neto_modificado_linea
dec  ld_peso_bruto_modificado,ld_peso_bruto_real,ld_peso_bruto_mod_ya_asignado
dec  ld_peso_bruto_modificado_linea


ld_peso_bruto_modificado = dec(this.text)
//formula con la que calculan el neto
ld_peso_neto_modificado = round((ld_peso_bruto_modificado / 1.016),2)

ld_peso_neto_real       = dec(dw_peso_albaranes.describe("evaluate('sum(peso_neto_real for all)',1)"))
ld_peso_bruto_real      = dec(dw_peso_albaranes.describe("evaluate('sum(peso_bruto_real for all)',1)"))

//ld_factor_de_conversion = ld_peso_bruto_real / ld_peso_bruto_modificado

//ld_factor_de_conversion = ld_peso_bruto_real / ld_peso_bruto_modificado

//ld_peso_neto_modificado = round(ld_peso_neto_real / ld_factor_de_conversion,0)

ll_lineas = dw_peso_albaranes.rowcount()

if ll_lineas = 1 then
	dw_peso_albaranes.object.peso_neto_modificado[1] = ld_peso_neto_modificado
	dw_peso_albaranes.object.peso_bruto_modificado[1] = ld_peso_bruto_modificado	
else	
	ld_peso_neto_mod_ya_asignado  = 0
	ld_peso_bruto_mod_ya_asignado = 0
	
	for ll_indice = 1 to ll_lineas
		if ll_indice = ll_total then
			dw_peso_albaranes.object.peso_neto_modificado[ll_indice]  = ld_peso_neto_modificado - ld_peso_neto_mod_ya_asignado
			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado - ld_peso_bruto_mod_ya_asignado
		else
			ld_peso_bruto_modificado = dec(this.text)

			ld_peso_neto_real       = dec(dw_peso_albaranes.describe("evaluate('sum(peso_neto_real for all)',1)"))
			ld_peso_bruto_real      = dec(dw_peso_albaranes.describe("evaluate('sum(peso_bruto_real for all)',1)"))

			ld_factor_de_conversion = ld_peso_bruto_real / ld_peso_bruto_modificado

			ld_peso_neto_modificado = round(ld_peso_neto_real / ld_factor_de_conversion,0)

			ld_peso_neto_modificado_linea = dw_peso_albaranes.object.peso_neto_real[ll_indice] / ld_factor_de_conversion
			ld_peso_neto_modificado_linea = round(ld_peso_neto_modificado_linea,0)
			ld_peso_neto_mod_ya_asignado  = ld_peso_neto_mod_ya_asignado + ld_peso_neto_modificado_linea
			dw_peso_albaranes.object.peso_neto_modificado[ll_indice] = ld_peso_neto_modificado_linea
			
			ld_peso_bruto_modificado_linea = dw_peso_albaranes.object.peso_bruto_real[ll_indice] / ld_factor_de_conversion
			ld_peso_bruto_modificado_linea = round(ld_peso_bruto_modificado_linea,0)
			ld_peso_bruto_mod_ya_asignado  = ld_peso_bruto_mod_ya_asignado + ld_peso_bruto_modificado_linea
			dw_peso_albaranes.object.peso_bruto_modificado[ll_indice] = ld_peso_bruto_modificado_linea			
		end if
	next
end if
//
peso_neto.text = string(ld_peso_neto_modificado)

//
//
end event

type contenedor from u_em_campo within w_pedir_datos_expedicion
integer x = 457
integer y = 592
integer width = 617
integer taborder = 70
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!"
end type

event modified;call super::modified;cbx_imprimir_vgm.checked = true
end event

type st_3 from statictext within w_pedir_datos_expedicion
integer x = 55
integer y = 600
integer width = 389
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Nº Contenedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_pedir_datos_expedicion
integer x = 2450
integer y = 1932
integer width = 325
integer height = 84
integer taborder = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;tipo_array  val
val.valor[1] = "RETURN"
val.valor[2] = ""
val.valor[3] = ""

closewithreturn(parent,val)
end event

type cb_ok from commandbutton within w_pedir_datos_expedicion
integer x = 2121
integer y = 1932
integer width = 325
integer height = 84
integer taborder = 210
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

event clicked;tipo_array  val
long ll_indice,ll_donde

val.valor[1] = texto.text
val.valor[2] = peso.text
val.valor[3] = contenedor.text
val.valor[4] = precinto.text
val.valor[5] = matricula.text
val.valor[6] = dni.text
val.valor[7] = peso_neto.text
val.valor[8] = remolque.text

if cbx_imprimir_cmr.checked then
	val.valor[9] = 'S'
else
	val.valor[9] = 'N'
end if
val.valor[10] = uo_agencia.em_codigo.text
val.valor[11] = uo_conductor.em_codigo.text
//Datos para el VGM
if cbx_imprimir_vgm.checked then
	val.valor[12] = 'S'
else
	val.valor[12] = 'N'
end if
val.valor[13] = booking.text
val.valor[14] = tara_contenedor.text
if cbx_metodo_1.checked then
	val.valor[15] = '1'
else
	val.valor[15] = '2'
end if

val.valor[16] = em_importe_forma_envio.text//precio_portes
val.valor[17] = uo_forma_envio.em_codigo.text//formaenvio

//val.valor[11 + (ll_indice * 4)+1]

for ll_indice = 1 to il_albaranes
	ll_donde = dw_peso_albaranes.find("albaran = "+string(ll_indice,"###0"),1,dw_peso_albaranes.rowcount())
		
	val.valor[13 + (ll_indice * 4)+1] = string(ll_indice,"###0")
	if ll_donde > 0 then
		val.valor[13 + (ll_indice * 4)+2] = string(dw_peso_albaranes.object.peso_bruto_modificado[ll_donde],"#########0.00")
		val.valor[13 + (ll_indice * 4)+3] = string(dw_peso_albaranes.object.peso_neto_modificado[ll_donde],"#########0.00")
		val.valor[13 + (ll_indice * 4)+4] = string(dw_peso_albaranes.object.pallets_modificados[ll_donde],"#########0")
	else
		val.valor[13 + (ll_indice * 4)+2] = ""
		val.valor[13 + (ll_indice * 4)+3] = ""
		val.valor[13 + (ll_indice * 4)+4] = ""
	end if

next

Closewithreturn(parent,val)

end event

type gb_2 from groupbox within w_pedir_datos_expedicion
integer x = 23
integer y = 76
integer width = 2811
integer height = 320
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Transportista"
borderstyle borderstyle = stylebox!
end type

type gb_3 from groupbox within w_pedir_datos_expedicion
integer x = 23
integer y = 404
integer width = 2811
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Vehiculo"
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_pedir_datos_expedicion
integer x = 23
integer y = 552
integer width = 2811
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Contenedor"
borderstyle borderstyle = stylebox!
end type

type gb_5 from groupbox within w_pedir_datos_expedicion
integer x = 23
integer y = 940
integer width = 2811
integer height = 276
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Observaciones"
borderstyle borderstyle = stylebox!
end type

type dw_peso_albaranes from u_datawindow within w_pedir_datos_expedicion
integer x = 5
integer y = 1252
integer width = 2843
integer height = 668
integer taborder = 160
string dataobject = "dw_pedir_datos_expedicion"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;long ll_indice,ll_total,ll_pallets_anteriores,ll_pallets_actuales
dec  ld_peso_neto_modificado,ld_peso_bruto_modificado,ld_pallets_modificados
dec  ld_valor_linea,ld_peso_bruto_anterior,ld_peso_bruto_actual

choose case dwo.name
	case "peso_neto_modificado"
		ld_peso_neto_modificado = 0
		ll_total = this.rowcount()
		for ll_indice = 1 to ll_total
			if ll_indice <> row then
				ld_valor_linea = this.object.peso_neto_modificado[ll_indice]
			else
				ld_valor_linea = dec(data)
			end if
			ld_peso_neto_modificado = ld_peso_neto_modificado + ld_valor_linea
		next
		
		peso_neto.text = string(ld_peso_neto_modificado)
		
		ld_peso_bruto_modificado = 0
		ll_total = this.rowcount()
		for ll_indice = 1 to ll_total
			ld_valor_linea = this.object.peso_bruto_modificado[ll_indice]

			ld_peso_bruto_modificado = ld_peso_bruto_modificado + ld_valor_linea
		next
		
		peso.text = string(ld_peso_bruto_modificado)	
	case "peso_bruto_modificado"
		ld_peso_bruto_modificado = 0
		ll_total = this.rowcount()
		for ll_indice = 1 to ll_total
			if ll_indice <> row then
				ld_valor_linea = this.object.peso_bruto_modificado[ll_indice]
			else
				ld_valor_linea = dec(data)
			end if
			ld_peso_bruto_modificado = ld_peso_bruto_modificado + ld_valor_linea
		next
		
		peso.text = string(ld_peso_bruto_modificado)	
		
		
		ld_peso_neto_modificado = 0
		ll_total = this.rowcount()
		for ll_indice = 1 to ll_total
			ld_valor_linea = this.object.peso_neto_modificado[ll_indice]

			ld_peso_neto_modificado = ld_peso_neto_modificado + ld_valor_linea
		next
		
		peso_neto.text = string(ld_peso_neto_modificado)
	case "pallets_modificados"

		ld_pallets_modificados = 0
		ll_total = this.rowcount()
		for ll_indice = 1 to ll_total
			if ll_indice <> row then
				ld_valor_linea = this.object.pallets_modificados[ll_indice]
			else
				ld_valor_linea = dec(data)
			end if
			ld_pallets_modificados = ld_pallets_modificados + ld_valor_linea
		next
		
		em_total_pallets.text = string(ld_pallets_modificados)		
		
		//Añadiremos o quitaremos 25 kilos por cada pallet añadido o quitado
		ll_pallets_anteriores = this.object.pallets_modificados[row]
		ll_pallets_actuales   = dec(data)
		
		ld_peso_bruto_anterior = this.object.peso_bruto_modificado[row]
		ld_peso_bruto_actual   = ld_peso_bruto_anterior + ((ll_pallets_actuales - ll_pallets_anteriores)*25)
		this.object.peso_bruto_real[row] = this.object.peso_bruto_real[row] + ((ll_pallets_actuales - ll_pallets_anteriores)*25)
		
		this.object.peso_bruto_modificado[row] = ld_peso_bruto_actual
		this.event itemchanged(row,this.object.peso_bruto_modificado,string(ld_peso_bruto_actual))
		this.groupcalc()
		//Añadiremos o quitaremos 25 kilos por cada pallet añadido o quitado		
end choose
end event

type gb_6 from groupbox within w_pedir_datos_expedicion
integer x = 23
integer y = 792
integer width = 2811
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Portes"
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_pedir_datos_expedicion
integer x = 5
integer y = 12
integer width = 2843
integer height = 1228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Datos transporte"
borderstyle borderstyle = stylebox!
end type

