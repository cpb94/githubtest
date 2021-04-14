$PBExportHeader$wi_mant_previsiones.srw
forward
global type wi_mant_previsiones from wi_mvent_con_empresa
end type
type st_2 from statictext within wi_mant_previsiones
end type
type sle_valor2 from u_em_campo within wi_mant_previsiones
end type
type st_3 from statictext within wi_mant_previsiones
end type
type cb_1 from commandbutton within wi_mant_previsiones
end type
type cb_2 from commandbutton within wi_mant_previsiones
end type
end forward

global type wi_mant_previsiones from wi_mvent_con_empresa
integer width = 2793
integer height = 2228
st_2 st_2
sle_valor2 sle_valor2
st_3 st_3
cb_1 cb_1
cb_2 cb_2
end type
global wi_mant_previsiones wi_mant_previsiones

on wi_mant_previsiones.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_valor2=create sle_valor2
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_valor2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
end on

on wi_mant_previsiones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.sle_valor2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento Previsiones de Ventas"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana
sle_valor2.setfocus()
end event

event ue_recuperar;call super::ue_recuperar;dw_1.Retrieve(dec(sle_valor2.text),sle_valor.text)
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_previsiones
integer x = 82
integer y = 412
integer width = 2235
integer height = 1524
integer taborder = 30
string dataobject = "dw_mant_previsiones"
boolean vscrollbar = true
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_previsiones
integer x = 96
integer y = 304
string text = "Grupo :"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_previsiones
integer x = 2354
integer y = 432
integer width = 370
integer height = 108
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_previsiones
boolean visible = false
integer x = 2354
integer y = 440
integer width = 370
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_previsiones
integer x = 498
integer y = 300
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "VENTANA SELECCION DE GRUPOS"
ue_datawindow = "dw_ayuda_vengruposfac"
ue_filtro     = "" 	


end event

event sle_valor::modificado;call super::modificado;st_3.text = f_nombre_vengruposfac(codigo_empresa, sle_valor.text )
dw_1.Retrieve(dec(sle_valor2.text),sle_valor.text)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_previsiones
integer x = 2354
integer y = 768
integer width = 370
integer height = 108
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_previsiones
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_previsiones
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_previsiones
integer width = 2697
end type

type st_2 from statictext within wi_mant_previsiones
integer x = 96
integer y = 204
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año :"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_valor2 from u_em_campo within wi_mant_previsiones
integer x = 498
integer y = 200
integer taborder = 10
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_3 from statictext within wi_mant_previsiones
integer x = 768
integer y = 300
integer width = 1070
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 134217748
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from commandbutton within wi_mant_previsiones
integer x = 2354
integer y = 544
integer width = 370
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Insertar"
end type

event clicked;long donde,max_mes,indice,mes,num_mes,meses[12]

max_mes = 0
num_mes = dw_1.rowcount()
for indice = 1 to num_mes
	mes = dw_1.getitemnumber(indice,"mes")
	if mes > max_mes then
		max_mes = mes
	end if
next
if max_mes = 12 then
	if num_mes = 12 then
		messagebox("Atención","No se puede insertar")
		return
	else
		for indice = 1 to 12
			meses [indice] = -1
		next
		for indice = 1 to num_mes
			mes = dw_1.getitemnumber(indice,"mes")
			meses[mes] = mes
		next
		for indice = 1 to 12
			mes = meses[indice]
			if mes = -1 then
				donde = dw_1.insertrow(0)
				dw_1.ScrollToRow(donde)
				dw_1.SetItem(donde,"ejercicio",dec(sle_valor2.text))
				dw_1.SetItem(donde,"grupo",sle_valor.text)
				dw_1.SetItem(donde,"mes",indice)
				dw_1.SetItem(donde,"prevision",0)
				dw_1.SetItem(donde,"prevision_euros",0)
				dw_1.update()
				dw_1.setfocus()
				exit
			end if
		next
	end if
else
	donde = dw_1.insertrow(0)
	dw_1.ScrollToRow(donde)
	dw_1.SetItem(donde,"ejercicio",dec(sle_valor2.text))
	dw_1.SetItem(donde,"grupo",sle_valor.text)
	dw_1.SetItem(donde,"mes",max_mes + 1)
	dw_1.SetItem(donde,"prevision",0)
	dw_1.SetItem(donde,"prevision_euros",0)
	dw_1.update()
	dw_1.setfocus()
end if

end event

type cb_2 from commandbutton within wi_mant_previsiones
integer x = 2354
integer y = 656
integer width = 370
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar"
end type

event clicked;long donde

donde = dw_1.getrow()
dw_1.deleterow(donde)
dw_1.update()

end event

