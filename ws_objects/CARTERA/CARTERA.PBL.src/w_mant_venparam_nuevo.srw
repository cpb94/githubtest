$PBExportHeader$w_mant_venparam_nuevo.srw
forward
global type w_mant_venparam_nuevo from wi_mvent_con_empresa
end type
type gb_1 from groupbox within w_mant_venparam_nuevo
end type
type gb_2 from groupbox within w_mant_venparam_nuevo
end type
type gb_3 from groupbox within w_mant_venparam_nuevo
end type
type st_2 from statictext within w_mant_venparam_nuevo
end type
type em_anyo from u_em_campo within w_mant_venparam_nuevo
end type
end forward

global type w_mant_venparam_nuevo from wi_mvent_con_empresa
integer width = 2286
integer height = 1484
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
st_2 st_2
em_anyo em_anyo
end type
global w_mant_venparam_nuevo w_mant_venparam_nuevo

on w_mant_venparam_nuevo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.st_2=create st_2
this.em_anyo=create em_anyo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_anyo
end on

on w_mant_venparam_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.st_2)
destroy(this.em_anyo)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Contadores"
istr_parametros.s_listado        = "report_venparam"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text = istr_parametros.s_argumentos[2]
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
	 dw_1.Retrieve(codigo_empresa,em_anyo.text,sle_valor.Text)
	END IF
ELSE
	f_activar_campo(em_anyo)
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"anyo",em_anyo.text)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(em_anyo.text)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "venparam"

dw_1.Retrieve(codigo_empresa,em_anyo.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;
em_anyo.enabled = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
em_anyo.enabled = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_venparam_nuevo
integer x = 46
integer y = 444
integer width = 1669
integer height = 412
string dataobject = "dw_venparam"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_venparam_nuevo
integer x = 18
integer y = 308
integer width = 366
string text = "Código:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_venparam_nuevo
integer x = 1742
integer y = 452
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_venparam_nuevo
integer x = 1746
integer y = 592
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_venparam_nuevo
integer x = 402
integer y = 308
integer width = 384
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;IF Trim(em_anyo.text)="" THEN
	f_activar_campo(em_anyo)
	Return
END IF

ue_titulo ="AYUDA SELECCIÓN DE CODIGOS DE CONTADORES"
ue_datawindow ="dw_ayuda_venparam"
ue_filtro ="anyo = " + "'" + Trim(em_anyo.text) + "'"
isle_campo =this
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_venparam_nuevo
integer x = 1746
integer y = 728
integer width = 389
integer textsize = -10
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_venparam_nuevo
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_venparam_nuevo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_venparam_nuevo
end type

type gb_1 from groupbox within w_mant_venparam_nuevo
integer x = 1728
integer y = 408
integer width = 421
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mant_venparam_nuevo
integer x = 1733
integer y = 548
integer width = 416
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_mant_venparam_nuevo
integer x = 1733
integer y = 684
integer width = 416
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_2 from statictext within w_mant_venparam_nuevo
integer x = 128
integer y = 180
integer width = 256
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_mant_venparam_nuevo
integer x = 402
integer y = 176
integer taborder = 10
string displaydata = ""
end type

