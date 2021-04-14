$PBExportHeader$w_lis_cmr.srw
forward
global type w_lis_cmr from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_cmr
end type
type st_2 from statictext within w_lis_cmr
end type
type em_anyo from u_em_campo within w_lis_cmr
end type
type em_albaran from u_em_campo within w_lis_cmr
end type
type st_3 from statictext within w_lis_cmr
end type
type st_6 from statictext within w_lis_cmr
end type
type em_copias1 from editmask within w_lis_cmr
end type
type pb_imprimir_preli from picturebutton within w_lis_cmr
end type
type st_7 from statictext within w_lis_cmr
end type
type st_cliente from statictext within w_lis_cmr
end type
type st_codcli from statictext within w_lis_cmr
end type
type st_pagina from statictext within w_lis_cmr
end type
type uo_1 from u_selec_impresoras within w_lis_cmr
end type
type cb_imprimir_cmr from u_boton within w_lis_cmr
end type
type cb_preliminar_cmr from u_boton within w_lis_cmr
end type
type pb_preliminar_cmr from picturebutton within w_lis_cmr
end type
type pb_imprimir_cmr from picturebutton within w_lis_cmr
end type
type uo_manejo from u_manejo_datawindow within w_lis_cmr
end type
type dw_preliminar from datawindow within w_lis_cmr
end type
type gb_3 from groupbox within w_lis_cmr
end type
end forward

global type w_lis_cmr from w_int_con_empresa
integer width = 3694
integer height = 5132
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_albaran em_albaran
st_3 st_3
st_6 st_6
em_copias1 em_copias1
pb_imprimir_preli pb_imprimir_preli
st_7 st_7
st_cliente st_cliente
st_codcli st_codcli
st_pagina st_pagina
uo_1 uo_1
cb_imprimir_cmr cb_imprimir_cmr
cb_preliminar_cmr cb_preliminar_cmr
pb_preliminar_cmr pb_preliminar_cmr
pb_imprimir_cmr pb_imprimir_cmr
uo_manejo uo_manejo
dw_preliminar dw_preliminar
gb_3 gb_3
end type
global w_lis_cmr w_lis_cmr

type variables
string filtro,var_idioma,var_moneda,var_tipocli,var_codcli
Dec{4}  var_total
integer lineas = 24
integer lnpie,contador,var_tipo
String  var_clase,c,des,referencia
long v_pedido,ant_pedido
string is_impresora
boolean automatico = false

end variables

forward prototypes
public subroutine f_pagina ()
end prototypes

public subroutine f_pagina ();If dw_preliminar.GetRow() = 0 Then Return
st_pagina.text  =dw_preliminar.getItemString(dw_preliminar.GetRow(),"pagina")
end subroutine

event open;call super::open;Integer r,j,copias_valorado,anyo,copias
long    albaran
string  cliente
istr_parametros.s_titulo_ventana="Listado albaranes"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))
var_tipo = 1

IF istr_parametros.i_nargumentos>1 THEN
	 if istr_parametros.s_argumentos[6] = "N" then
				automatico = false
	else
		automatico = true
	end if
	
		j= istr_parametros.i_nargumentos - 3
		FOR r = 1 To j
			if istr_parametros.s_argumentos[r+3]= "N"  or &
			istr_parametros.s_argumentos[r+3]="" then
				exit;
			else
			  em_anyo.text=istr_parametros.s_argumentos[3]	
			  em_albaran.text=istr_parametros.s_argumentos[r+3]
			  
			 
			  
			  IF Not IsNull(em_albaran.text) and Trim(em_albaran.text) <> "" Then
					anyo    = dec(em_anyo.text)
					albaran = dec(em_albaran.text)
					
					cliente = f_cliente_venalb(codigo_empresa,anyo,albaran)
					
					copias_valorado = f_num_copias_albaran_valorado_vencliente(codigo_empresa,cliente)
					
					copias          = f_num_copias_albaran_venclientes(codigo_empresa,cliente)		
								
					
						em_albaran.TriggerEvent("modificado")
						istr_parametros.i_nargumentos = 0
						if dec(istr_parametros.s_argumentos[2]) = 0 then
							if copias > 0 then
								em_copias1.text = string(copias,"#0")
							else
								em_copias1.text = "1" //istr_parametros.s_argumentos[2]
							end if
						else
							em_copias1.text = istr_parametros.s_argumentos[2]
						end if
						
						if automatico then
						
								cb_imprimir_cmr.triggerevent(Clicked!)
							
							if copias_valorado <> 0 then
								em_copias1.text = string(copias_valorado)
								cb_imprimir_cmr.triggerevent(Clicked!)
							end if
						end if
					  END IF
					end if
			NEXT
			if automatico then		
				Close(This)
				Return
			end if
		
END IF




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

on w_lis_cmr.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_3=create st_3
this.st_6=create st_6
this.em_copias1=create em_copias1
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_7=create st_7
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.st_pagina=create st_pagina
this.uo_1=create uo_1
this.cb_imprimir_cmr=create cb_imprimir_cmr
this.cb_preliminar_cmr=create cb_preliminar_cmr
this.pb_preliminar_cmr=create pb_preliminar_cmr
this.pb_imprimir_cmr=create pb_imprimir_cmr
this.uo_manejo=create uo_manejo
this.dw_preliminar=create dw_preliminar
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_albaran
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.em_copias1
this.Control[iCurrent+8]=this.pb_imprimir_preli
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_cliente
this.Control[iCurrent+11]=this.st_codcli
this.Control[iCurrent+12]=this.st_pagina
this.Control[iCurrent+13]=this.uo_1
this.Control[iCurrent+14]=this.cb_imprimir_cmr
this.Control[iCurrent+15]=this.cb_preliminar_cmr
this.Control[iCurrent+16]=this.pb_preliminar_cmr
this.Control[iCurrent+17]=this.pb_imprimir_cmr
this.Control[iCurrent+18]=this.uo_manejo
this.Control[iCurrent+19]=this.dw_preliminar
this.Control[iCurrent+20]=this.gb_3
end on

on w_lis_cmr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.em_copias1)
destroy(this.pb_imprimir_preli)
destroy(this.st_7)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.st_pagina)
destroy(this.uo_1)
destroy(this.cb_imprimir_cmr)
destroy(this.cb_preliminar_cmr)
destroy(this.pb_preliminar_cmr)
destroy(this.pb_imprimir_cmr)
destroy(this.uo_manejo)
destroy(this.dw_preliminar)
destroy(this.gb_3)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_cmr
integer x = 2409
integer y = 452
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_cmr
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_albaran)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_lis_cmr
integer x = 14
integer y = 4
integer width = 3479
integer height = 96
end type

type pb_1 from upb_salir within w_lis_cmr
integer x = 3511
integer y = 8
integer width = 142
integer height = 112
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type st_2 from statictext within w_lis_cmr
integer x = 14
integer y = 160
integer width = 302
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
boolean enabled = false
string text = "CMR:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_cmr
integer x = 329
integer y = 156
integer width = 192
integer height = 80
integer taborder = 0
end type

type em_albaran from u_em_campo within w_lis_cmr
integer x = 562
integer y = 156
integer width = 247
integer height = 80
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;long ll_ejercicio

ll_ejercicio = Dec(em_anyo.text)

select cliente
into   :var_codcli
from   ven_cmr_cabecera
where  empresa   = :codigo_empresa
and    ejercicio = :ll_ejercicio
and    codigo    = :em_albaran.text;

st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_cmr
integer x = 521
integer y = 164
integer width = 46
integer height = 92
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
string text = "--"
boolean focusrectangle = false
end type

type st_6 from statictext within w_lis_cmr
integer x = 919
integer y = 164
integer width = 256
integer height = 64
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

type em_copias1 from editmask within w_lis_cmr
integer x = 1189
integer y = 156
integer width = 192
integer height = 80
integer taborder = 60
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

type pb_imprimir_preli from picturebutton within w_lis_cmr
boolean visible = false
integer x = 3506
integer y = 328
integer width = 101
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
end type

event clicked;OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_albaran)
end event

type st_7 from statictext within w_lis_cmr
integer x = 27
integer y = 324
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cliente from statictext within w_lis_cmr
integer x = 535
integer y = 324
integer width = 1490
integer height = 80
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_codcli from statictext within w_lis_cmr
integer x = 329
integer y = 324
integer width = 201
integer height = 80
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
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_pagina from statictext within w_lis_cmr
integer x = 3273
integer y = 232
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

type uo_1 from u_selec_impresoras within w_lis_cmr
integer x = 2267
integer y = 124
integer height = 100
integer taborder = 70
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_preliminar
is_impresora = u_selec_impresoras_report.describe("datawindow.printer")
end event

on uo_1.destroy
call u_selec_impresoras::destroy
end on

type cb_imprimir_cmr from u_boton within w_lis_cmr
integer x = 1701
integer y = 224
integer width = 320
integer height = 84
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;int  anyo
string ls_albaran

//Variables de conversion
anyo		= dec(em_anyo.text)
ls_albaran	= em_albaran.text


dw_preliminar.reset()
dw_preliminar.dataobject = "report_list_cmr"
dw_preliminar.SetRedraw(FALSE)
f_carga_dw_cmr(codigo_empresa,anyo,ls_albaran,dw_preliminar)
//dw_preliminar.Modify(" datawindow.print.copies = 4")
dw_preliminar.Modify(" datawindow.print.copies = "+em_copias1.text)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible = TRUE
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)

PRINT(dw_preliminar)
end event

type cb_preliminar_cmr from u_boton within w_lis_cmr
integer x = 1701
integer y = 140
integer width = 320
integer height = 84
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Preliminar"
end type

event clicked;int  anyo
string ls_albaran

//Variables de conversion
anyo		= dec(em_anyo.text)
ls_albaran	= em_albaran.text


dw_preliminar.reset()
dw_preliminar.dataobject = "report_list_cmr"
dw_preliminar.SetRedraw(FALSE)
f_carga_dw_cmr(codigo_empresa,anyo,ls_albaran,dw_preliminar)
dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom = " + "75" + ")")
dw_preliminar.visible = TRUE
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type pb_preliminar_cmr from picturebutton within w_lis_cmr
integer x = 1595
integer y = 140
integer width = 101
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\prelimi.bmp"
end type

event clicked;cb_preliminar_cmr.triggerevent(clicked!)
end event

type pb_imprimir_cmr from picturebutton within w_lis_cmr
integer x = 1595
integer y = 224
integer width = 101
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;cb_imprimir_cmr.triggerevent(clicked!)
end event

type uo_manejo from u_manejo_datawindow within w_lis_cmr
boolean visible = false
integer x = 3035
integer y = 280
integer width = 599
integer height = 160
end type

event valores;call super::valores;dw_data =dw_preliminar
f_pagina()
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_preliminar from datawindow within w_lis_cmr
boolean visible = false
integer x = 14
integer y = 440
integer width = 3630
integer height = 4520
string dataobject = "report_list_cmr"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_lis_cmr
integer x = 5
integer y = 80
integer width = 2048
integer height = 348
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

