$PBExportHeader$wi_mant_act_obs_elementos.srw
forward
global type wi_mant_act_obs_elementos from wi_mvent_con_empresa
end type
type st_2 from statictext within wi_mant_act_obs_elementos
end type
type st_elemento from statictext within wi_mant_act_obs_elementos
end type
type em_elemento from u_em_campo within wi_mant_act_obs_elementos
end type
end forward

global type wi_mant_act_obs_elementos from wi_mvent_con_empresa
integer width = 2871
integer height = 1092
st_2 st_2
st_elemento st_elemento
em_elemento em_elemento
end type
global wi_mant_act_obs_elementos wi_mant_act_obs_elementos

type variables

end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Actualizaciones de los Elementos" 
	valor_empresa = True
	istr_parametros.s_listado        = ""
   This.title = istr_parametros.s_titulo_ventana
   
	tipo_mantenimiento = 'F'
	
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      em_elemento.text = istr_parametros.s_argumentos[2]
		st_elemento.text = f_desc_bienesdet(codigo_empresa,dec(istr_parametros.s_argumentos[2]))		
		If istr_parametros.i_nargumentos>2 then
			sle_valor.text=istr_parametros.s_argumentos[3]
			IF Trim(sle_valor.text)<>"00-00-0000" and Trim(em_elemento.text)<>""  Then
				dw_1.Retrieve(codigo_empresa,dec(em_elemento.text),datetime(date(sle_valor.Text)))
			END IF
		Else
			sle_valor.setfocus()
			em_elemento.text = istr_parametros.s_argumentos[2]
		END IF
   END IF
end event

event ue_activa_claves;call super::ue_activa_claves;em_elemento.enabled = True
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;em_elemento.enabled = False
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"elemento",dec(em_elemento.text))
dw_1.setitem(dw_1.getrow(),"fecha",datetime(date(sle_valor.Text)))

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_bienesdet_obs"

If sle_valor.Text = "00-00-0000" then Return

dw_1.Retrieve(codigo_empresa,dec(em_elemento.text),datetime(date(sle_valor.Text)))

CALL Super::ue_recuperar
end event

on wi_mant_act_obs_elementos.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_elemento=create st_elemento
this.em_elemento=create em_elemento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_elemento
this.Control[iCurrent+3]=this.em_elemento
end on

on wi_mant_act_obs_elementos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_elemento)
destroy(this.em_elemento)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_obs_elementos
integer x = 23
integer y = 368
integer width = 2825
integer height = 524
string dataobject = "dwact_bienesdet_obs"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_obs_elementos
integer x = 206
integer y = 248
integer width = 274
integer height = 84
string text = "Fecha"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_obs_elementos
integer x = 1911
integer y = 136
integer width = 302
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_obs_elementos
integer x = 2213
integer y = 136
integer width = 302
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_obs_elementos
integer y = 252
integer width = 347
integer taborder = 20
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_bienesdet"
ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
ue_filtro         = ""
isle_campo        = This
valor_empresa		= True
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_obs_elementos
integer x = 2523
integer y = 136
integer width = 302
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_obs_elementos
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_obs_elementos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_obs_elementos
integer y = 20
integer width = 2811
end type

type st_2 from statictext within wi_mant_act_obs_elementos
integer x = 192
integer y = 144
integer width = 288
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
string text = "Elemento"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_elemento from statictext within wi_mant_act_obs_elementos
integer x = 873
integer y = 152
integer width = 1001
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_elemento from u_em_campo within wi_mant_act_obs_elementos
integer x = 494
integer y = 152
integer width = 347
integer taborder = 10
boolean bringtotop = true
end type

event modificado;call super::modificado;st_elemento.text = f_desc_bienesdet(codigo_empresa,dec(this.text))

If st_elemento.text = "" and trim(this.text)<>''then
	f_mensaje("Código erróneo","No existe ese elemento.")
	this.setfocus()
End If
end event

event getfocus;call super::getfocus;ue_datawindow     = "dw_ayuda_act_bienesdet"
ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
ue_filtro         = ""
isle_campo        = This
valor_empresa		= True
end event

